######################################################
# A améliorer :
# - Systématiser le parcours du vecteur "citation"
# - Ajouter une connexion à scopus pour faire du scrapping du hindex
# - Pour les articles récents (années 2021-2023), multiplier les nombres par un facteur de pondération 
######################################################

# Librairies et require
library("dplyr")
library("rvest")

# importation du fichier "docs.csv" dans "C:\Users\jeric\Downloads\Nouveau dossier"
data_zotero <- read.csv("C:\\Users\\jeric\\OneDrive\\Programmation\\Github\\ISPED\\Divagations avec R\\Scrapping citations with DOI\\docs.csv", header = TRUE, sep = ",") # nolint

# Garder le titre (Title), les auteurs (Author) et le DOI (DOI) dans data2
data_analyse <- data_zotero[, which(names(data_zotero) %in% c("Title", "Author", "DOI"))]

# Ajout d'une colonne "citations"
data_analyse$citations <- 0

# Recherche du nombre de citation sur google scholar.
# Exemple avec le DOI "10.1111/j.1747-7093.2002.tb00395.x" : https://scholar.google.com/scholar?hl=it&as_sdt=0%2C5&q=10.4103%2Fijph.ijph_185_20&btnG=
# Selector : #gs_res_ccl_mid .gs_nph+ a

for (i in 1:dim(data_analyse)[1]) {
  if (data_analyse$DOI[i] != "" && data_analyse$citations[i] == 0) {
    url <- paste0("https://scholar.google.com/scholar?hl=it&as_sdt=0%2C5&q=", data_analyse$DOI[i])
    webpage <- read_html(url)
    citations <- html_nodes(webpage, "#gs_res_ccl_mid .gs_nph+ a") %>% html_text()
    # On ajoute la citation à la colonne "citations" si elle contient le texte "Citato".
    # On le fait pour citations[1] et citations[2] (car on a eu deux selector empiriquement)
    if (grepl("Citato", citations[1])) {
      data_analyse$citations[i] <- citations[1]
    } else if (grepl("Citato", citations[2])) {
      data_analyse$citations[i] <- citations[2]
    } else {
      data_analyse$citations[i] <- "Pas d'informations sur GS"
    }
    Sys.sleep(round(runif(1, 8, 15)))
  }
}

# On ne garde que les lignes qui n'ont pas de citations = 0
data_avec_citations <- data_analyse[data_analyse$citations != 0, ] 

# Extraction des doi manquants dans data3
data_sans_doi <- data_analyse[data_analyse$DOI == "", ]

# Sauvegarder le csv
write.csv(data_avec_citations, "C:\\Users\\jeric\\Downloads\\Nouveau dossier\\docsCitations.csv", row.names = FALSE)
write.csv(data_sans_doi, "c:\\Users\\jeric\\Downloads\\Nouveau dossier\\docsSansDOI.csv", row.names = FALSE)


######### Ponderation #########

# On enlève "Citato da " et on transforme en numérique ce qui reste
test <- read.csv("C:\\Users\\jeric\\OneDrive\\Programmation\\Github\\ISPED\\Divagations avec R\\Scrapping citations with DOI\\docsCitations.csv", header = TRUE, sep = ",")
test$citations <- gsub("Citato da ", "", test$citations)
test$citations <- as.numeric(test$citations) # 163 avec valeurs

# Ajout d'une colonne "Date" avec la date de publication depuis data_zotero
# Jours de différence par rapport à 2023
test$jours_ecarts <- as.numeric(as.Date("2023-01-01") - as.Date(data_zotero$Date))

# Fonction de pondération
fonction_sigmoide <- function(jours) {
  if (jours - 365 < 0){
    return(2 / (1 + exp(-0.98 * (jours - 1.17))))
  } else {
    return(1 - 2 / (1 + exp(-0.98 * (jours - 1.17))))
  }
}

# Calcul du score
test$score <- NA
for (i in 1:length(test$score)){
  test$score[i] <- fonction_sigmoide(test$citations[i])
}

# Version où on ajoute / enlève la moyenne 
moyenne_citations <- mean(test$citations)

# Calcul du score
test$score_moyenne <- NA

for (i in 1:length(test$score_moyenne)){
  test$score_moyenne[i] <- moyenne_citations * fonction_sigmoide(test$citations[i])
}

######### Suivre un lien - Récupération de dates sur internet #########
# Suivre un lien avec rvest : follow_link()

#gc()
#rm(list = ls())