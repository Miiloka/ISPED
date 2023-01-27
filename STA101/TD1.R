library(ggplot2)

################## Partie 1 - Statistiques descriptives

# 1.1 - Chargement des données
data <- read.table("Github\\ISPED\\STA101\\cweschler.txt", header = TRUE, sep = "\t")

# 1.2 - Statistiques descriptives de data$AGE et data$CODEW0

# plot age sans les valeurs manquantes
plot(data$AGE, data$CODEW0, xlab = "Age", ylab = "Code W0", main = "Age vs Code W0", pch = 19, col = "blue")

summary(data$AGE)
summary(data$CODEW0)

# Histogrammes. hist(x, breaks = n) permet d'avoir au plus n classes.
hist(data$AGE, main = "Histogramme de l'âge", xlab = "Age", ylab = "Effectif", col = "#ffa60036")
hist(data$CODEW0, main = "Histogramme du test à T0", xlab = "Test de Wechsler à T0", ylab = "Effectif", col = "#0000ff67")

# 1.3 - Description de toutes les variables
summary(data)
plot(data)

################## Partie 2 - Tests d'hypothèses

# 2.1 - Test d'association entre les variables SEXE et le score CODEW0

score_homme <- data[data$SEXE == 0, "CODEW0"]
score_femme <- data[data$SEXE == 1, "CODEW0"]

# Sexe est une variable qualitative binaire (0 = homme, 1 = femme)
# CODEW0 est une variable quantitative discrète (score du test de Wechsler à T0)
# On note m1 la moyenne des CODEW0 pour les femmes et m0 pour les hommes

(moyenne_femmes <- mean(data[data$SEXE == 1, "CODEW0"]))
(moyenne_hommes <- mean(data[data$SEXE == 0, "CODEW0"]))

# On utilise le test de comparaison de moyennes de deux échantillons indépendants # nolint
# Les conditions d'applications (normalité via TCL car n_homme > 30 et n_femme > 30) sont vérifiées # nolint

n1 <- nrow(data[data$SEXE == 1, ])
n0 <- nrow(data[data$SEXE == 0, ])

qqnorm(data[data$SEXE == 1, "CODEW0"], 
        main = "Normalité des scores de Wechsler à T0 pour les femmes", 
        xlab = "Quantiles théoriques", 
        ylab = "Quantiles observés", 
        col = "red")
qqline(data[data$SEXE == 1, "CODEW0"], col = "red")

qqnorm(data[data$SEXE == 0, "CODEW0"], 
        main = "Normalité des scores de Wechsler à T0 pour les hommes", 
        xlab = "Quantiles théoriques", 
        ylab = "Quantiles observés", 
        col = "blue")
qqline(data[data$SEXE == 0, "CODEW0"], col = "blue")

shapiro.test(data[data$SEXE == 1, "CODEW0"]) # pas normal car p-value < 0.05
shapiro.test(data[data$SEXE == 0, "CODEW0"])

# On pose alpha = 0.05 le risque d'erreur de première espèce.
# H0 : mean(CODEW0) est la même pour les hommes et les femmes
# H1 : mean(CODEW0) est différente pour les hommes et les femmes (bilatéral)

# Égalité des variances.
# On pose : H0' : "les variances sont égales".
# Sous H0', F = s1²/s2² suit une loi de Fisher F(n1-1, n2-1).
(variance_hommes_2_1 <- var(data[data$SEXE == 0, "CODEW0"]))
(variance_femmes_2_1 <- var(data[data$SEXE == 1, "CODEW0"]))
(F_2_1 <- max(variance_hommes_2_1, variance_femmes_2_1) / min(variance_hommes_2_1, variance_femmes_2_1))

# Comme p-value >= 0.05, on accepte H0. Les variances sont égales.

# - On calcule l'écart-type de test
std_test_2_1 <- sqrt(((n1 - 1) * variance_femmes_2_1 + (n0 - 1) * variance_hommes_2_1) / (n1 + n0 - 2))

# - On calcule la statistique de test 
test_student_2_1 <- (moyenne_femmes - moyenne_hommes) / (std_test_2_1 * sqrt(1 / n1 + 1 / n0)) 

# On calcule la région critique
rc_2_1 <- c(qt(0.025, df = n1 + n0 - 2), qt(0.975, df = n1 + n0 - 2))

# On calcule la p-valeur
(2 * qt(abs(test_student_2_1), df = n1 + n0 - 2, lower.tail = FALSE))

# On rejette H0 à 5% de risque d'erreur de première espèce.

### Ou directement avec la fonction t.test
barplot(c(moyenne_femmes, moyenne_hommes),
        names.arg = c("Femmes", "Hommes"),
        main = "Moyenne des scores de Wechsler à T0 selon le sexe",
        ylab = "Moyenne des scores de Wechsler à T0",
        col = c("red", "blue"))

(var.test(score_homme, score_femme))
(test_2_1 <- t.test(data$CODEW0 ~ data$SEXE, var.equal = TRUE, alternative = "two.sided"))
(test_2_1$statistic)
(test_2_1$p.value)
(test_2_1$conf.int)

################## Partie 3 - Régression linéaire simple

################## Partie 4 - Régression linéaire multiple

######################################################
rm(list = ls())
gc()