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
