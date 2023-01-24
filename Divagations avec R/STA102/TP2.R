########## Exercice 1 ##########

# Déterminant récursif
determinant_rec <- function(a) {
  if (nrow(a) == 1) {
    return(a[1, 1])
  } else {
    det <- 0
    for (i in 1:ncol(a)) {
      det <- det + (-1)^(i + 1) * a[1, i] * determinant_rec(a[-1, -i, drop = FALSE])
    }
    return(det)
  }
}

a <- matrix(1:4, nrow = 2, ncol = 2)
determinant_rec(a)

# Comatrice
comatrice <- function(matrice_entree) {
  if (ncol(matrice_entree) != nrow(matrice_entree)) {
    stop("La matrice n'est pas carrée")
  }
  comat_a <- matrix(0, nrow = ncol(matrice_entree), ncol = nrow(matrice_entree))
  for (i in 1:nrow(matrice_entree)) {
    for (j in 1:ncol(matrice_entree)) {
      comat_a[i, j] <- (-1)^(i + j) * determinant_rec(matrice_entree[-i, -j, drop = FALSE])
    }
  }
  return(comat_a)
}

# Transposee
transposee <- function(matrice_entree) {
  matrice_sortie <- matrix(0, ncol = ncol(matrice_entree), nrow = nrow(matrice_entree))
  for (i in 1:nrow(matrice_entree)){
    matrice_sortie[i, ] <- matrice_entree[, i]
  }
  return(matrice_sortie)
}

# Inverse matrice
inverse <- function(matrice) {
  if (determinant_rec(matrice) == 0) {
    stop("La matrice n'est pas inversible")
  }
  return(transposee(comatrice(matrice)) / determinant_rec(matrice))
}

########## Exercoce 2 ##########

# Pivot de Gauss
pivot_gauss <- function(a) {
  # on vérifie que les pivots sont non nuls
  for (i in 1:nrow(a)) {
    if (a[i, i] == 0) {
      stop("Le pivot est nul.")
    }
  }
  # identité de même dimension que A
  inv_a <- diag(1, nrow(a))

  # on annule les éléments en dessous des pivots
  for (i in 1:nrow(a)) {
    for (j in 1:nrow(a)) {
      if (i != j) {
        inv_a[j, ] <- inv_a[j, ] - a[j, i] / a[i, i] * inv_a[i, ] # le futur inverse
        a[j, ] <- a[j, ] - a[j, i] / a[i, i] * a[i, ] # la future identité
      }
    }
  }
  # on divise par les pivots
  for (i in 1:nrow(a)) {
    inv_a[i, ] <- inv_a[i, ] / a[i, i]
    a[i, ] <- a[i, ] / a[i, i]
  }
  return(list(a, inv_a)) # Renvoyer A permet de vérifier que A soit l'identité
}

A <- matrix(1:4, nrow = 2, ncol = 2)
pivot_gauss(A)
solve(A)


########## Microbenchmark ##########
library(microbenchmark)
microbenchmark(det(matrice_a), determinant_rec(matrice_a), times = 50) # ma version récursive gagne
microbenchmark(transposee(matrice_a), t(matrice_a), times = 50) # l'implémentation R gagne
microbenchmark(comatrice(matrice_a), times = 50) # 30µs mean
microbenchmark(solve(matrice_a), inverse(matrice_a), times = 50) # l'implémetation R gagne