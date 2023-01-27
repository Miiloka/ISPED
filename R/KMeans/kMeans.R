###########################################################
# KNN à centroides.
# A améliorer : nettoyer le code, ajouter des commentaires,
# 
###########################################################

### Distance euclidienne
distance_euclidienne <- function(data, target, n = 2) {
    # Initialisation des variables
    distance <- c(rep(0, nrow(data)))
    dataSansLabel <- data[, c(1:n)]

    # Calcul des distances
    for (i in 1:nrow(dataSansLabel)){
        distance[i] <- sqrt(sum((dataSansLabel[i, ] - target)^2))
    }
    return(distance)
}

k_means <- function(data, n = 2) {
    # Initialisation des variables
    # Choix aléatoire d'un point de départ pour chaque centroïde parmi les données
    centroide1 <- data[sample(1:nrow(data), 1), ]
    centroide2 <- data[sample(1:nrow(data), 1), ]
    centroide3 <- data[sample(1:nrow(data), 1), ]

    distance_centroide1 <- c(rep(0, nrow(data)))
    distance_centroide2 <- c(rep(0, nrow(data)))
    distance_centroide3 <- c(rep(0, nrow(data)))
    matrice_distances_centroides <- cbind(distance_centroide1, distance_centroide2, distance_centroide3)

    labels <- c(rep(NA, nrow(data)))
    label_cv <- c(rep("Centroide 1", nrow(data)))
    data <- cbind(data, labels)
    data <- cbind(data, label_cv)

    testeur_logique <- TRUE

    # Corps de la fonction
    while (testeur_logique) {
        ### Distances centroides avec chaque points
        distance_centroide1 <- distance_euclidienne(data[, c(1:n)], centroide1, n)
        distance_centroide2 <- distance_euclidienne(data[, c(1:n)], centroide2, n)
        distance_centroide3 <- distance_euclidienne(data[, c(1:n)], centroide3, n)
        matrice_distances_centroides[, 1:3] <- c(distance_centroide1, distance_centroide2, distance_centroide3)

        for (i in 1:nrow(matrice_distances_centroides)){
            indice <- which(matrice_distances_centroides[i, ] == min(matrice_distances_centroides[i, ]))
            data$labels[i] <- paste("Centroide", indice)
        }

        ### Affecter le barycentre aux centroides
        centroide1 <- colMeans(data[which(data$labels == "Centroide 1"), 1:n])
        centroide2 <- colMeans(data[which(data$labels == "Centroide 2"), 1:n])
        centroide3 <- colMeans(data[which(data$labels == "Centroide 3"), 1:n])

        ### Convergence :
        ### 1) centroide_etape_i-1 == centroide_etape_i
        ### 2) étiquette étape i-1 == étiquette étape i : choix perso

        if (all((data$label_cv == data$labels) == TRUE)) {
            testeur_logique <- FALSE
        } else {
            data$label_cv <- data$labels
        }
    }
    return(data)
}

################### TEST ###################
data <- iris[, 1:4]
data <- k_means(data, n = 4)

data$colors <- NA

for (i in 1:nrow(data)) {
        if (data$labels[i] == "Centroide 1") {
        data$colors[i] <- "red"
    } else if (data$labels[i] == "Centroide 2") {
        data$colors[i] <- "blue"
    } else if (data$labels[i] == "Centroide 3") {
        data$colors[i] <- "orange"
    }
}
plot(data[, c(3:4)], col = data$colors, pch = 20, cex = 1.5)

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

################### PREMIERS ESSAIS, A OUBLIER ###################

### Importation des données (conditionne le n [>= 2])
# n = 2
data <- iris[, 1:4]
# n = 3
data2 <- iris[, 1:3]
# n = 4
data3 <- iris[, 1:4]

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