# --- PACKAGES --
# install.packages(c("httr", "jsonlite", "glue", "lubridate", "dplyr"))
library(httr)
library(jsonlite)
library(glue)
library(lubridate)
library(dplyr)

# ------------------------------------
# 1. Colonnes intéressantes
# ------------------------------------
colonnes_interessantes <- c(
  "numero_dpe",
  "date_reception_dpe",
  "date_etablissement_dpe",
  "date_visite_diagnostiqueur",
  "modele_dpe",
  "numero_dpe_remplace",
  "date_fin_validite_dpe",
  "version_dpe",
  "numero_dpe_immeuble_associe",
  "annee_construction",
  "type_batiment",
  "type_installation_chauffage",
  "type_installation_ecs",
  "periode_construction",
  "code_departement_ban",
  "code_insee_ban",
  "coordonnee_cartographique_x_ban",
  "coordonnee_cartographique_y_ban",
  "type_energie_principale_chauffage",
  "type_energie_principale_ecs",
  "cout_total_5_usages",
  "etiquette_dpe",
  "etiquette_ges",
  "classe_inertie_batiment",
  "cout_chauffage",
  "cout_ecs",
  "cout_refroidissement",
  "cout_eclairage",
  "code_postal_ban",
  "score_ban",
  "surface_habitable_logement",
  "conso_5_usages_par_m2_ep",
  "conso_5_usages_par_m2_ef",
  "conso_5_usages_ef",
  "conso_ecs_ep",
  "emission_ges_5_usages",
  "emission_ges_5_usages_par_m2",
  "qualite_isolation_murs",
  "qualite_isolation_plancher_bas",
  "qualite_isolation_enveloppe",
  "isolation_toiture",
  "inertie_lourde",
  "indicateur_confort_ete",
  "besoin_chauffage",
  "besoin_refroidissement",
  "besoin_ecs",
  "zone_climatique",
  "classe_altitude",
  "nom_commune_ban",
  "_geopoint"
)

colonnes_string <- paste(colonnes_interessantes, collapse = ",")

# ------------------------------------
# 2. EXISTANTS : fonction API (CORRIGÉE)
# ------------------------------------
get_data_existants <- function(base_url, codes_postaux) {
  df <- data.frame()
  
  for (code in codes_postaux) {
    
    params <- list(
      size     = 10000,
      select   = colonnes_string,
      q        = as.character(code),
      q_fields = "code_postal_ban"
    )
    
    url_encoded <- modify_url(base_url, query = params)
    response <- GET(url_encoded)
    
    if (response$status_code == 200) {
      content <- fromJSON(rawToChar(response$content), flatten = FALSE)
      total_logements <- content$total
      print(glue("[existant] Code postal {code} → total = {total_logements}"))
      
      if (!is.null(content$results) && nrow(content$results) > 0) {
        df <- bind_rows(df, as.data.frame(content$results))
      } else if (!is.null(content$result) && length(content$result) > 0) {
        # compat selon structure retournée
        df <- bind_rows(df, content$result)
      }
      
    } else {
      message(glue("Erreur API existants pour code {code} : {response$status_code}"))
    }
  }
  
  df
}

# ------------------------------------
# 3. NEUFS : fonction API (CORRIGÉE)
# ------------------------------------
get_data_neufs <- function(base_url, codes_postaux) {
  df <- data.frame()
  
  for (code in codes_postaux) {
    
    params <- list(
      size     = 10000,
      select   = colonnes_string,      # <- on met aussi select pour avoir les mêmes colonnes
      q        = as.character(code),
      q_fields = "code_postal_ban"
    )
    
    url_encoded <- modify_url(base_url, query = params)
    response <- GET(url_encoded)
    
    if (response$status_code == 200) {
      content <- fromJSON(rawToChar(response$content), flatten = FALSE)
      total_logements <- content$total
      print(glue("[neuf] Code postal {code} → total = {total_logements}"))
      
      if (!is.null(content$results) && nrow(content$results) > 0) {
        tmp <- as.data.frame(content$results)
        df <- bind_rows(df, tmp)
      } else if (!is.null(content$result) && length(content$result) > 0) {
        tmp <- bind_rows(content$result)
        # On garde seulement les colonnes intéressantes présentes
        colonnes_communes <- intersect(colonnes_interessantes, names(tmp))
        tmp <- tmp[, colonnes_communes, drop = FALSE]
        df <- bind_rows(df, tmp)
      }
      
    } else {
      message(glue("Erreur API neufs pour code {code} : {response$status_code}"))
    }
  }
  
  df
}

# ------------------------------------
# 4. Config : URLs + codes postaux (Rhône)
# ------------------------------------
base_url_existants <- "https://data.ademe.fr/data-fair/api/v1/datasets/dpe03existant/lines"
base_url_neufs     <- "https://data.ademe.fr/data-fair/api/v1/datasets/dpe02neuf/lines"

codes_postaux_69 <- c(
  69001, 69002, 69003, 69004, 69005, 69006, 69007, 69008, 69009,
  69100, 69110, 69120, 69140, 69160, 69170, 69190, 69200,
  69210, 69220, 69230, 69240, 69260, 69310, 69320, 69330,
  69340, 69350, 69360, 69370, 69380, 69390, 69400, 69410,
  69420, 69430, 69440, 69450, 69460, 69500, 69510, 69520,
  69530, 69540, 69560, 69570, 69580, 69590, 69600, 69610,
  69620, 69630, 69640, 69650, 69660, 69670, 69680, 69690
)

# ------------------------------------
# 5. Rhône : existants + neufs
# ------------------------------------
df_existants_rhone <- get_data_existants(base_url_existants, codes_postaux_69) %>%
  mutate(zone = "Rhone", flag = "existant")

df_neufs_rhone <- get_data_neufs(base_url_neufs, codes_postaux_69) %>%
  mutate(zone = "Rhone", flag = "neuf")

# ------------------------------------
# 6. Fusion & export
# ------------------------------------
logements_rhone <- bind_rows(df_existants_rhone, df_neufs_rhone)

write.csv2(
  logements_rhone,
  file = "C:/Users/2018e/Downloads/logements_rhone.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

print(table(logements_rhone$flag))

View(logements_rhone)


# ==========================================
# PARTIE PENTAHO - SID
# ==========================================



df_existants_rhone <- subset(logements_rhone, logements_rhone$flag == "existant")
df_neufs_rhone <- subset(logements_rhone, logements_rhone$flag == "neuf")


write.csv2(
  df_existants_rhone,
  file = "C:/Users/2018e/Downloads/logements_existants.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)



write.csv2(
  df_neufs_rhone,
  file = "C:/Users/2018e/Downloads/logements_neufs.csv",
  row.names = FALSE,
  fileEncoding = "UTF-8"
)





