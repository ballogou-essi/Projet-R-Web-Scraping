#  Web Scraping sur MyAnimeList avec R

Nous allons récupérer et analyser les données des 200 animés les plus populaires sur MyAnimeList en utilisant R. Ce projet comprend l’extraction des données, leur préparation et leur visualisation.

## Étape 1 : Préparation des Données  
- **Données collectées :** Les données ont été extraites directement des pages du site MyAnimeList.  
- **Format des données exportées :** Un fichier CSV intitulé `200_Top_Anime.csv` contenant les colonnes suivantes :  
  - `Title` : Nom de l'animé  
  - `Score` : Note moyenne attribuée par les utilisateurs  
  - `Members` : Nombre de membres ayant interagi avec l'animé  

## Étape 2 : Exploration des Données  
Nous avons utilisé plusieurs visualisations pour explorer les données collectées :  
1. **Répartition des Scores** : Histogramme montrant la distribution des scores des animés.  
2. **Top 10 des Animés les Plus Populaires** : Classement des animés avec le plus grand nombre de membres.  
3. **Corrélation Membres-Score** : Analyse de la relation entre la popularité (membres) et les scores attribués.  
4. **Densité des Membres** : Graphique de densité pour identifier la concentration des valeurs de popularité.  

## Étape 3 : Technologies et Fonctions Utilisées  
- **Bibliothèques R :**  
  - `rvest` : Pour extraire les données du site web.  
  - `stringr` : Pour manipuler et nettoyer les chaînes de caractères.  
  - `ggplot2` : Pour créer des visualisations graphiques.  
- **Boucle for** : Utilisée pour parcourir plusieurs pages du site et collecter les données.  
- **Fonctions personnalisées** : Une fonction dédiée pour automatiser l'extraction des données d'une page spécifique.  

## Résultats  
- La majorité des animés ont un score compris entre 8.4 et 8.7.  
- Une corrélation positive entre le nombre de membres et les scores a été observée.  
- Les animés les plus populaires regroupent un grand nombre de membres.  

## Conclusion  
Ce projet démontre comment le web scraping et l'analyse des données peuvent fournir des informations intéressantes sur la popularité et la qualité perçue des animés. Les résultats pourraient être utilisés pour recommander des animés aux spectateurs ou pour identifier des tendances dans le domaine de l'animation.  

## Fichier Exporté  
- **Nom :** `200_Top_Anime.csv`  
- **Description :** Contient les 200 animés les plus populaires avec leurs scores et leur popularité.  

## Source des Données 
[MyAnimeList](https://myanimelist.net/topanime.php?type=all&topkeyword=)

## Noms des membres du Groupe
 - **BALLOGOU Essi Carole Claudia**
 - **DIALLO Alpha Oumar**
