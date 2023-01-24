# vecteur "serie1" qui contient 10 entiers aléatoires entre 0 et 10
serie1 <- sample(0:10, 10, replace = TRUE)

# autre manière de l'avoir "serie2"
serie2 <- runif(10, 0, 10)

# vecteur "serie3" qui contient 10 entiers aléatoires avec la loi normale
(serie3 <- round((rnorm(10, 0, 10))))

(which(serie1 == 8))

serie1[c(3, 6, 7)]

# matrice avec serie1, serie2 et serie3
(matrice <- cbind(serie1, serie2, serie3))

(matrice2 <- rbind(serie1, serie2, serie3))

distance1 <- c()
distance2 <- c()

for (i in 1:seq_len(matrice)[1]){
    distance1 <- c(distance1, sqrt(sum(matrice[i, ]**2)))
    distance2 <- c(distance2, sqrt(sum(matrice2[, i]**2)))
}

distance1
distance2


# Vérifie si il y a le mot "Affiche" dans les phrases du vecteur, et l'ajoute à a
# Exemple : 
# vecter <- c("Affiche moi ça", "Affiche 5", "5", 4)
# a doit contenir "Affiche moi ça" et "Affiche 5"

vecter <- c("Affiche moi ça", "Affiche 5", "5", 4)
a <- c()
for (i in 1:seq_len(vecter)[1]){
    if (grepl("Affiche", vecter[i])){
        a <- c(a, vecter[i])
    }
}


# fonction pour calculer le déterminant d'une matrice A
determinant_rec <- function(A){
    if (nrow(A) == 2){
        return(A[1, 1] * A[2, 2] - A[1, 2] * A[2, 1])
    }
    else{
        det <- 0
        for (i in 1:seq_len(A)[1]){
            det <- det + (-1)^(i+1) * A[1, i] * determinant_rec(A[-1, -i])
        }
        return(det)
    }
}

a <- matrix(c(1, 2, 3, 4), 2, 2)
determinant_rec(as.matrix(a))
