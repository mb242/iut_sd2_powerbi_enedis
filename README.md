# OBSERVATOIRE DPE – Auvergne-Rhône-Alpes

> **Tableau de bord interactif** pour analyser et visualiser les Diagnostics de Performance Énergétique (DPE) des logements de la région   **Auvergne-Rhône-Alpes**

---

## Table des Matières

- [À Propos](#à-propos)
- [Fonctionnalités](#fonctionnalités)
- [Démo](#démo)
- [Utilisation](#utilisation)
- [Architecture](#architecture)
- [Technologies](#technologies)
- [Documentation](#documentation)
- [Contributeurs](#contributeurs)



  ## À Propos

### Contexte du Projet

Cette application Power BI a été développée dans le cadre d’un **projet académique Utilisation avancée d'outils de reporting sous la supervion de Mathieu Gaultier (BUT Science des Données 2è année)**, à l’**IUT Lumière Lyon 2**.

Dans un contexte de **transition énergétique**, de hausse des coûts de l’énergie et de lutte contre le changement climatique, ce projet vise à dresser un **état des lieux précis de la performance énergétique des logements** à l’échelle régionale.

Les données exploitées proviennent des **Diagnostics de Performance Énergétique (DPE)** publiés par l’ADEME.



### Objectifs

L’application vise à :

- Visualiser la **répartition des étiquettes DPE et GES** sur la région Auvergne-Rhône-Alpes
- Identifier les **passoires énergétiques** (logements classés F et G)
- Analyser les **consommations énergétiques**, les **émissions de CO₂** et les **coûts de chauffage**
- Étudier l’impact :
  - du type de logement
  - de la période de construction
  - du type d’énergie utilisée
- Fournir un **outil d’aide à la décision** pour les collectivités et acteurs publics



## Fonctionnalités

### 🔹 Fonctionnalités principales

- Tableau de bord **multi-pages** avec navigation personnalisée
- **KPI dynamiques** :
  - Nombre de logements
  - Nombre de communes
  - % de passoires énergétiques (F-G)
  - % de logements performants (A-C)
  - Émissions moyennes de CO₂
  - Coûts moyens de chauffage
- **Filtres interactifs** :
  - Commune
  - Type de logement
  - Type d’énergie
  - Étiquette DPE
  - Période de construction
- Visualisations variées :
  - Histogrammes
  - Diagrammes en anneau (donut)
  - Nuages de points
  - Tableaux détaillés
- Analyse géographique (par commune / code postal)
- **Sécurité des données (RLS)** selon le profil utilisateur

---

## Démo

### Application Power BI

- Application publiée sur **Power BI Online**
- URL de déploiement accès via lien partagé (selon droits) : https://app.powerbi.com/groups/me/reports/e1d95c2e-3b33-4eef-bd4a-5edea13b98dc/3af0d614f5fcc0f9baa0?experience=power-bi


###  Vidéo de démonstration

- Vidéo explicative 
- Présentation :
  - des fonctionnalités
  - de la navigation
  - du modèle de données
  - des analyses principales

Vidéo de démonstration
URL de déploiement YouTube :


## Architecture

OBSERVATOIRE_DPE_RHONE/
│
├── Power BI/
│   └── Observatoire_DPE_Rhone.pbix
│
├── data/
│   └── logements_rhone.csv
|   └── Extraction Power BI DPE
│
├── docs/
│   ├── doc_fonctionnelle.md
│   └── doc_technique.md
│
├── assets/
│   ├── screenshots/
│   └── schema_modele.png
│
└── README.md



## Documentation

### Documents Disponibles

| Document                 | Description                        | Public cible          |
|--------------------------|------------------------------------|-----------------------|
| [README.md]              | Vue d'ensemble du projet           | Tous                  |
| [doc_fonctionnelle.md]   | Guide utilisateur complet          | Utilisateurs finaux   |
| [doc_technique.md]       | Détails techniques et architecture | Développeurs          |









## Contributeurs

### Participants :  

  - **[Arthur MALLIERE](mailto:arthur.maliere@univ-lyon2.fr)**
  - **[Farès REDISSI](mailto:fares.redissi@univ-lyon2.fr)**
  - **[Elk-Fred MBAHOUKA](mailto:elk-fred.mbahouka@univ-lyon2.fr)**
    
### Client

- **ENEDIS** - Demandeur du projet


