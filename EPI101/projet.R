# ================================Librairies ===============================#
#install.packages("skimr", "ggplot2", "tidyverse", "gtsummary", "emmeans")
library(skimr) # Résumé des données (nb d'obs, var, val manquantes...)
library(emmeans) # cf. https://www.youtube.com/watch?v=_okuMw4JFfU
library(tidyverse) # Importe bcp de librairies (https://tidyverse.tidyverse.org)
library(gtsummary) # Pour faire des tableaux de résumés

# ========================== 1. Importation des données ====================== #
data <- read.csv("Github\\ISPED\\EPI101\\BDD\\BDD11.csv", header = TRUE, sep = ";")

# ============================= 2. Résumé des données =========================#
# Résumé des données avec skimr
skim(data)

# Résumé des données avec gtsummary 
data %>%
  select(-ident)%>%
  tbl_summary(label = list(sexe ~ "Sexe", age ~ "Âge"), 
              statistic = list(all_continuous() ~"{mean} ({sd})", all_categorical() ~ "{n} ({p})")
              )%>%
  add_n()%>%
  add_ci(statistic = list(all_continuous() ~ "{conf.low}, {conf.high}", all_categorical() ~ "{conf.low}, {conf.high}"))%>%
  modify_caption("**Tableau récapitulatif de toutes les variables (N = {N})**")

# ============================= 3. Gestion de la BDD =========================#
# On ne garde que les variables relatives aux vaccins
vaccins <- data[, 28:56]
avis_vaccins_tabac <- data %>% select(Vacc_Fav, Vacc_defav, tabac)
# Version alternative : avis_vaccins_tabac <- data_11[, c(28, 29, 23)]

# Fréquence (+ IC 95%) des vaccins
vaccins %>%
  tbl_summary(statistic = list(all_continuous() ~"{mean} ({sd})", all_categorical() ~ "{n} ({p})"))%>%
  add_n()%>%
  add_ci(statistic = list(all_continuous() ~ "{conf.low}, {conf.high}", all_categorical() ~ "{conf.low}, {conf.high}"))%>%
  modify_caption("**Tableau descriptif des retours sur les vaccins (N = {N})**")

# Graphique
ggplot(vaccins, aes(x = Vacc_Fav)) +
  geom_bar()

# Vaccins selon le statut tabagique
avis_vaccins_tabac %>%
  tbl_summary(by = tabac, 
              statistic = list(all_continuous() ~"{mean} ({sd})", all_categorical() ~ "{n} ({p})"),
              label = list(Vacc_Fav ~ "Favorable au vaccin", Vacc_defav ~ "Défavorable au vaccin")
              )%>%
  add_n()%>%
  add_ci(statistic = list(all_continuous() ~ "{conf.low}, {conf.high}", all_categorical() ~ "{conf.low}, {conf.high}"))%>%
  modify_caption("**Croisement (Vacc_Fav, Vacc_defav) x tabagisme (N = {N})**")
