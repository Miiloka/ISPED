################### KNN à centroïdes ###################

### Importation des données (conditionne le n >= 1)
data <- iris[, 3:4] # n = 2
data2 <- iris[, 1:3] # n = 3
data3 <- iris[, 1:4] # n = 4

### Création de 3 centroïdes aléatoires à n dimensions

# Afficher chaque centroide (x, y)

plot(data, col = "black", pch = 20, cex = 1.5)
points(centroide1[1], centroide1[2], col = "red", pch = 20, cex = 1.5) # c(4.69753598229545, 1.65325363840755)
points(centroide2[1], centroide2[2], col = "#00eeff", pch = 20, cex = 1.5) # c(2.52316640175337, 1.24792834789522)
points(centroide3[1], centroide3[2], col = "#ffc400", pch = 20, cex = 1.5) # c(3.57301293997634, 0.0600735527413268)

(centroide1 <- c(4.69753598229545, 1.65325363840755))
(centroide2 <- c(2.52316640175337, 1.24792834789522))
(centroide3 <- c(3.57301293997634, 0.0600735527413268))

points(4.69753598229545, 1.65325363840755, col = "red", pch = 20, cex = 1.5)
points(2.52316640175337, 1.24792834789522, col = "#00eeff", pch = 20, cex = 1.5)
points(3.57301293997634, 0.0600735527413268, col = "#ffc400", pch = 20, cex = 1.5)

### Distance euclidienne
distance_euclidienne <- function(matrice, vecteur) {
    # Initialisation des variables
    distance <- c(rep(0, nrow(matrice)))
    # Calcul des distances
    for (i in 1:nrow(matrice)){
        distance[i] <- sqrt(sum((matrice[i, ] - vecteur)^2))
    }
    return(distance)
}

k_means <- function(data) {
    # Initialisation des variables
    centroide1 <- c()
    centroide2 <- c()
    centroide3 <- c()

    distance_centroide1 <- c(rep(0, nrow(data)))
    distance_centroide2 <- c(rep(0, nrow(data)))
    distance_centroide3 <- c(rep(0, nrow(data)))
    matrice_distances_centroides <- cbind(distance_centroide1, distance_centroide2, distance_centroide3)

    label <- c(rep(NA, nrow(data)))
    label_cv <- c(rep("Centroide 1", nrow(data)))
    data <- cbind(labels)
    data <- cbind(label_cv)
    colnames(data)[ncol(data)] <- "Étiquettes"
    colnames(data)[ncol(data)] <- "Étiquettes contrôle convergence"

    testeur_logique = TRUE

    # Corps de la fonction
    while (testeur_logique){
        ### Distances centroides avec chaque points
        distance_centroide1 <- distance_euclidienne(data, centroide1)
        distance_centroide2 <- distance_euclidienne(data, centroide2)
        distance_centroide3 <- distance_euclidienne(data, centroide3)
        matrice_distances_centroides[, 1:3] <- c(distance_centroide1, distance_centroide2, distance_centroide3)

        for (i in 1:nrow(matrice_distances_centroides)){
            indice <- which(matrice_distances_centroides[i, ] == min(matrice_distances_centroides[i, ]))
            dataLabelle[i, ncol(dataLabelle)] <- paste("Centroide", indice)
        }

        ### Affecter le barycentre aux centroides
        centroide1 <- colMeans(dataLabelle[which(dataLabelle[, 3] == "Centroide 1"), 1:2])
        centroide2 <- colMeans(dataLabelle[which(dataLabelle[, 3] == "Centroide 2"), 1:2])
        centroide3 <- colMeans(dataLabelle[which(dataLabelle[, 3] == "Centroide 3"), 1:2])

        ### Convergence :
        ### 1) centroide_etape_i-1 == centroide_etape_i
        ### 2) étiquette étape i-1 == étiquette étape i

        if (all(data[, ncol(data)] == data[, ncol(data)-1] == TRUE)) {
            testeur_logique = FALSE
            return(data)
        }
        data$
    }
}

################### Tests ###################
(min(matrice_distances_centroides[150, ]))
which(matrice_distances_centroides[150, ] == min(matrice_distances_centroides[150, ]))

### Deletion
gc()
rm(list = ls())

################### CRASH TEST DE TRUCS ###################
df <- data.frame(a = c(1, 2, 3), b = c(1,1,5), colonne1 = c("oui", "oui", "oui"), colonne2 = c("oui", "oui", "oui"))

colMeans(df[which(df[, 3] == "oui"), 1:2])

if (all((df$colonne1 == df$colonne2) == TRUE)){
    print ('freirf')
}

kiki = TRUE
i <- 0
while(kiki) {
    if (i < 10){
        print("gne")
        i <- i+1
    } else {
        print(i)
        kiki = FALSE
    } 
}

df[, 1:2] <- c(c(1,1,1), c(2,2,2))
df
