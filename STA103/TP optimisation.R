# On cherche à implémenter des fonctions pour trouver leur zéros.
# On utilise les méthodes de dichotomie, de Newton-Raphson et de descente de gradient.
# Si on utilise la fonction f, alors on cherche quand elle s'annule.
# Si on utilise la fonction f', alors on cherche quand la dérivée s'annule => extréma (minimum en pratique ici).


############ Exercice 1 - Dichotomie ############

f1 <- function(x) {
    x^2 - 2
}

h_test11 <- function(x) {
    x**3 * exp(x) + x - 1
}

# Algorithme de dichotomie
dicho <- function(h, a0, b0, epsilon) {
    a <- a0
    b <- b0
    i <- 0
    # On vérifie que h(a)h(b) est négatif, sinon on arrête
    if (h(a) * h(b) > 0) {
        stop("Erreur : h(a)h(b) doit être négatif")
    }
    while (abs(b - a) > epsilon) {
        i <- i + 1 # Compteur
        c <- (a + b) / 2 # Milieu de l'intervalle
        if (h(c) > 0) {
        b <- c
        } else {
        a <- c
        }
    }
    x0 <- (a + b) / 2
    return(list("Approximation de x0 : ", x0,
                 "Nombre d'itérations :", i,
                 " h(x0) : ", h(x0)))
}

### Tests
dicho(f1, 0, 2, 10**(-5))
sortie1 <- dicho(h_test1, -1, 1, 10**(-3))
abscisses1 <- seq(-1, 1, 0.001)
plot(abscisses, h_test1(abscisses), type = "l", col = "blue")
abline(h = 0, col = "red")
abline(v = sortie[[2]], col = "green")

############ Exercice 2 - Newton-Raphson ############
h_test2 <- function(x) {
    return((x - 1)^4 + x^2 + 4)
}

dh_test2 <- function(x) {
    return(4 * (x - 1)^3 + 2 * x)
}

f_test2 <- function(x) {
    return(x^3 * exp(x) + x - 1)
}

df_test2 <- function(x) {
    return(3 * x^2 * exp(x) + x^3 * exp(x) + 1)
}

h2_test <- function(x) {
    return((x - 1)**4 + (x - 2)**3 + 2 * (x - 2)**2)
}

dh2_test <- function(x) {
    return(4 * (x - 1)**3 + 3 * (x - 2)**2 + 4 * (x - 2))
}

newton_raphson <- function(h, dh, x0, epsilon = 10**(-5)) {
    x <- x0
    i <- 0
    while (abs(dh(x)) >= epsilon && i < 1 / epsilon) {
        i <- i + 1
        x <- x - h(x) / dh(x)
    }
    return(list("Approximation de x0 : ", x,
                "Nombre d'itérations :", i,
                " h(x0) : ", h(x)))
}

### Tests
abscisses2 <- seq(-5, 5, 0.001)
plot(abscisses2, h_test2(abscisses2), type = "l", col = "green")
# plot(abscisses2, dh_test2(abscisses2), type = "l", col = "blue")
sortie2_h <- newton_raphson(h_test2, dh_test2, 1)
abline(h = sortie2_h[[6]], v = sortie2_h[[2]], col = "red")

sortie2_f <- newton_raphson(f_test2, df_test2, 1)
plot(abscisses2, f_test2(abscisses2), type = "l", col = "green")
abline(h = f_test2(sortie2_f[[2]]), v = sortie2_f[[2]], col = "blue")

sortie3_h <- newton_raphson(h2_test, dh2_test, 2)
sortie4_h <- newton_raphson(h2_test, dh2_test, -0.5)
plot(abscisses2, h2_test(abscisses2), type = "l", col = "green")
abline(h = h2_test(sortie3_h[[2]]), v = sortie3_h[[2]], col = "blue")
abline(h = h2_test(sortie4_h[[2]]), v = sortie4_h[[2]], col = "red")

############ Exercice 3 - Descente de gradient ############

h_test_3 <- function(x) {
    return(1 / 4 * x^4 + (x - 1)^2)
}

dh_test3 <- function(x) {
    return(x^3 + 2 * (x - 1))
}

descente_gradient <- function(h, dh, x0, s, epsilon = 10**(-5)) {
    x <- x0
    i <- 0
    while (abs(dh(x)) >= epsilon && i < 1 / epsilon) {
        i <- i + 1
        x <- x - s * dh(x)
    }
    print(paste("x0 : ", x0, " h(x0) : ", h(x0), "iterations : ", i))
    return(c(x, i, h(x)))
}

### Tests
abscisses3 <- seq(0, 2, 0.001)
plot(abscisses3, h_test_3(abscisses3), type = "l", col = "green")
sortie3 <- descente_gradient(h_test_3, dh_test3, 0, 0.001)
abline(h = h_test_3(sortie3[[1]]), v = sortie3[[1]], col = "blue")

gp_test <- function(x) {
    return(1 / 2 * x[1]**2 + 7 / 2 * x[2]**2)
}

dgp_test <- function(x) {
    return(c(x[1], 7 * x[2]))
}

descente_gradient_2 <- function(h, dh, x0, s, epsilon = 10**(-5)) {
    x <- x0
    i <- 0
    while (abs(dh(x)) >= epsilon && i < 1 / epsilon) {
        i <- i + 1
        x <- x - s * dh(x)
    }
    return(list(x, i, h(x)))
}

### Tests
descente_gradient_2(gp_test, dgp_test, c(7, 1.5), 0.001)
