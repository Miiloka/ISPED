################### KNN ###################

# Distance euclidienne entre p vecteurs de dimension n
distance_euclidienne <- function(matrice, vecteur) {
    # Initialisation du vecteur distance de longueur p nrow(matrice)
    distance <- c(rep(0, nrow(matrice)))
    # Calcul des distances
    for (i in 1:nrow(matrice)){
        distance[i] <- sqrt(sum((matrice[i, ] - vecteur)^2))
    }
    return(distance)
}

KNN_simple <- function(data, target, k) {
    # Initialisation des variables
    indices <- c(rep(0, nrow(data)))

    # Calcul des distances
    distance <- distance_euclidienne(data, target)

    # Récupération des kppv en fonction des kppd
    kppd <- sort(distance)[1:k]
    for (i in 1:k){
        indices <- c(indices, which(distance == kppd[i]))
    }

    kppv <- c()
    for (i in 1:k){
        kppv <- c(kppv, data[indices[i]])
    }

    # On retourne les indices et les kppv
    return(indices)
}

# On classe les kppv en moyennant les valeurs des classes des kppv
KNN <- function(data, target, k) { # nolint: object_name_linter.
    # Initialisation des variables
    indices <- KNN_simple(data, target, k)

    # Classement
    interet <- iris$Species[indices]
    occurences <- names(sort(table(interet), decreasing = TRUE)[1])

    # Return
    return(occurences)
}

################### Tests ###################
plot(iris$Petal.Width, iris$Petal.Length, col = iris$Species)

KNN(matrix(iris$Petal.Width, ncol = 1), c(1.0), 3) # Versicolor
KNN(matrix(iris$Petal.Width, ncol = 1), c(3.0), 11) # Virginica
KNN(matrix(iris$Petal.Width, ncol = 1), c(0.2), 4) # Setosa

KNN(matrix(iris$Petal.Length, ncol = 1), c(1.0), 3) # Setosa

# KNN avec Petal.Length et Petal.Width
KNN(as.matrix(iris[, 3:4]), c(3.0, 1.0), 11) # Versicolor
KNN(as.matrix(iris[, 3:4]), c(5.0, 1.7), 2) # Versicolor
KNN(as.matrix(iris[, 3:4]), c(5.0, 1.7), 5) # Virginica

# KNN avec toutes les variables (sauf Species)
KNN(as.matrix(iris[, 1:4]), c(2.7, 0.9, 5.0, 1.7), 5) # Versicolor
KNN(as.matrix(iris[, 1:4]), c(0.7, 0.9, 3.0, 1), 1) # Setosa
