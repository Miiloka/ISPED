# ================================Librairies ===============================#
library(skimr) # Résumé des données (nb d'obs, var, val manquantes...)
library(emmeans) # cf. https://www.youtube.com/watch?v=_okuMw4JFfU
library(tidyverse) # Importe bcp de librairies (https://tidyverse.tidyverse.org)
library(gtsummary) # Pour faire des tableaux de résumés
############################################################################

# ==================== Explications de certaines choses ====================#
#### La fonction duplicated() ####
# On enlève les doublons avec la fonction duplicated.
# Si la ligne est un doublon, la fonction renvoie TRUE, sinon FALSE.
# On utilise l'opérateur ! pour inverser les booléens.
# On renvoie donc les lignes qui ne sont PAS des doublons.

### Les pipes %>% ####
# Les pipes permettent de faire des opérations sur des objets sans '(' et ')'
# Ex. : round(exp(log(10))) devient 10 %>% log() %>% exp() %>% round()

### rbind ###
# rbind() permet de concaténer des matrices en lignes.

### map_dfr du package purrr (via tidyverse) ###
# map_dfr() permet de faire une boucle for sur un vecteur.

### distinct() du package dplyr (via tidyverse) ###
# distinct() permet d'enlever les doublons d'une matrice.

### La fonction paste() ###
# La fonction paste() permet de concaténer des chaînes de caractères.
# Ex. : paste("Bonjour", "à tous", sep = " ") renvoie "Bonjour à tous"
############################################################################

# ============================= Chargement des données =====================#
# 1.1. Chargement et concaténation des données BDD1.csv à BDD13.csv
data_initial <- read.csv("R/EPI101/BDD/BDD1.csv", header = TRUE, sep = ";")
for (i in 2:13) {
    data_initial <- rbind(data_initial, read.csv(paste("R/EPI101/BDD/BDD", i, ".csv", sep = ""), header = TRUE, sep = ";"))
}

# 1.2. Concaténation avec dyplr
data_initial2 <- map_dfr(1:13, ~ read.csv(paste("R/EPI101/BDD/BDD", .x, ".csv", sep = ""), header = TRUE, sep = ";"))

# 2.1. Enlever les doublons avec les fonctions R de base : duplicated().
data_epuree <- data_initial[!duplicated(data_initial), ]

# 2.2. Enlever les doublons avec dyplr
data_epuree2 <- data_initial %>% distinct() # ou alors : data_epuree2 <- distinct(data_initial)
############################################################################

# ============================= Résumé des données =========================#
# 3.1. Résumé des données avec skimr
skim(data_epuree)

# 3.2. Résumé des données avec gtsummary
tbl_summary(data_epuree)

# 3.3. Résumé des données avec dyplr
data_epuree %>% glimpse()
############################################################################

