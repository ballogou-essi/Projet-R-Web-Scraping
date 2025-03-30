---
title: "Web Scraping et analyse de données de MyAnimeList à l'aide de R"
author: "BALLOGOU Essi, DIALLO Alpha Oumar"
date: "2024-12-23"
output: html_document
---

## 1. Les bibliothèques
```{r}
library(rvest) # Pour extraire les données depuis le site web de MyAnimeList
library(stringr) # Pour manipuler les chaines de charactères
library(ggplot2) # Pour visualisualiser avec des graphiques 
```

## 2. Fonction pour extraire les informations du site web
```{r}
top_anime_scraper <- function(url) {
  # User agent pour la requête
  user_agent <- httr::user_agent("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36")
  
  # Lire l'HTML de la page
  page <- read_html(url)
  
  # Extraire les détails des animés
  animes <- page %>%
    html_nodes('.detail') %>%
    html_text(trim = TRUE) %>%
    str_replace_all('[\n]', '')
  
  # Séparer les informations des animés
  separated_data <- str_split(animes, "\\s{2,}", simplify = TRUE)
  
  # Convertir en data frame
  data_frame <- as.data.frame(separated_data, stringsAsFactors = FALSE)
  
  # Supprimer les colonnes inutiles
  if (ncol(data_frame) >= 5) {
    data_frame <- data_frame[, -c(5:8)]
  }
  
  # Renommer les colonnes du data frame principal
  colnames(data_frame) <- c("Title", "Type_Episodes", "Airing_Period", "Members")
  
  # Extraire les scores
  scores <- page %>%
    html_nodes('.score.fs14') %>%
    html_text(trim = TRUE) %>%
    str_replace_all('[\n, N/A]', '')

  # Ajouter les scores au data frame principal
  data_frame$Score <- scores
  
  return(data_frame)
}
```



## 3. Boucle pour récupérer les 200 premiers animés
```{r}
all_anime <- data.frame()
  
for (i in seq(0, 150, by = 50)) {
  url <- paste0("https://myanimelist.net/topanime.php?limit=", i)
  anime_page <- top_anime_scraper(url)
  all_anime <- rbind(all_anime, anime_page)
}

#La fonction gsub() est utilisée pour rechercher et remplacer des motifs dans des chaînes de caractères
all_anime$Members <- gsub(" members", "", all_anime$Members) # Retirer le mot "members"

```

## 4. Récupération des données
```{r}
write.csv(all_anime, "200_Top_Anime.csv", row.names = FALSE)
getwd()

```

## 5.Visualisation

### 5.1 Histogramme des Scores

Objectif : Visualiser la répartition des scores des animés
```{r}
ggplot(all_anime, aes(x = as.numeric(Score))) +
  geom_histogram(binwidth = 0.1, fill = "skyblue", color = "black") +
  labs(title = "Répartition des Scores des Animés",
       x = "Score", 
       y = "Nombre d'Animés") 
```

Interprétation: 

 - Environ 156 animés, donc plus de la moitié, de notre dataset, ont un score se situant entre 8.4 et 8.7
 
### 5.2 Top 10 des Animés par Nombre de Membres
```{r}
top_10_members <- all_anime[1:10, ]

# Suppression des virgules et convertion en numérique
top_10_members$Members <- as.numeric(gsub(",", "", top_10_members$Members))

# Réorganisation des titres en fonction des membres
top_10_members$Title <- reorder(top_10_members$Title, top_10_members$Members)

# Graphique

ggplot(top_10_members, aes(x = reorder(Title, Members), y = Members)) +
  geom_bar(stat = "identity", fill = "orange") +
  labs(title = "Top 10 des Animés les Plus Populaires",
       x = "Titre",
       y = "Nombre de Membres") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

```

### 5.3 Membres vs Score
```{r}
# Les nombres contenu dans la colonne Members, sont considérés comme des textes. Alors on convertit tout en numérique en suppriment les ',' (ex: 199,345 en 199345) pour que R les traites comme des nombres : 

all_anime$Members <- as.numeric(gsub(",", "", all_anime$Members)) 

# On fait le plot
ggplot(all_anime, aes(x = Members, y = as.numeric(Score))) +
  geom_point(color = "blue") +
  geom_smooth(method = "lm", color = "red") +
  labs(title = "Corrélation entre Popularité et Score",
       x = "Nombre de membres",
       y = "Score")

```

Interprétation: 

 - Points bleus : Chaque point représente un anime.
 
 - Ligne rouge : C'est la tendance générale (régression linéaire). Ici, elle monte, ce qui signifie que les animés ayant un grand nombre de membres tendent également à avoir un score élevé (corrélation positive)


### 5.4 Densité du Nombre de Membres
```{r}
ggplot(all_anime, aes(x = Members)) +
  geom_density(fill = "purple", alpha = 0.5) +
  labs(title = "Densité du Nombre de Membres", x = "Nombre de Membres", y = "Densité") +
  theme_minimal()

```

Interprétation: 

 - La plupart des animés se concentrent sur des effectifs bas. Donc, la majorité des animés présente dans notre data frame ne sont pas très populaire.
 
 - Une minorité d'animés sont très populaires.


## Conclusion 

Dans ce projet, nous avons exploré les données de MyAnimeList à travers le web scraping pour récupérer et analyser les 200 animés les plus populaires à l'aide de R.

Nous avons examiné la distribution des scores, nous avons mis en évidence la relation entre le score des animés et les membres de MyAnimeList. 

Ces informations peuvent être utilisées pour identifier les animés les mieux notés ou les plus populaires pour orienter les choix des spectateurs.
