################### KNN à centroïdes ###################

# A faire :
# - calculer l'inertie du nuage selon la catégorisation
# - 
# - 

# Distance euclidienne
distance_euclidienne <- function(matrice, vecteur) {
    # Initialisation des variables
    distance <- c()
    # Calcul des distances
    for (i in 1:seq_len(dim(matrice))[1]){
        distance <- c(distance, sqrt(sum((matrice[i, ] - vecteur)^2)))
    }
    return(distance)
}

# 

# Test
data <- iris[, 1:4]

a <- (centroides(as.matrix(data)))
a
