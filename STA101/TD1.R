library(epiR)
library(epitools)

################## Partie 1 - Statistiques descriptives

alpha = 0.05

# 1.1 - Chargement des données
data2 <- read.table("Github\\ISPED\\STA101\\cweschler.txt", header = TRUE, sep = "\t")

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

# 2.2 - Test d'association entre les variables sexe et le score CODEW0 chez les plus de 80 ans
personnes_moins_de_80_ans <- data[data$AGE > 80, ]
nrow(personnes_moins_de_80_ans)

# Trie du score 
personnes_moins_de_80_ans <- personnes_moins_de_80_ans[order(personnes_moins_de_80_ans$CODEW0), ]


# test de wilcoxon
wilcox.test(personnes_moins_de_80_ans$CODEW0 ~ personnes_moins_de_80_ans$SEXE, alternative = "two.sided")

# Nombre de personnes avec une consommation de vin comvin == 0, 1 puis 2 dans data
table(data$COMVIN)

# Moyenne score pour chaque niveau de consommation de vin
(moyenne_score_0 <- mean(data[data$COMVIN == 0, "CODEW0"]))
(moyenne_score_1 <- mean(data[data$COMVIN == 1, "CODEW0"]))
(moyenne_score_2 <- mean(data[data$COMVIN == 2, "CODEW0"]))

# Moyenne totale
moyenne_score <- mean(data$CODEW0)

# Effectif dans chaque niveau de consommation de vin
(n0 <- nrow(data[data$COMVIN == 0, ]))
(n1 <- nrow(data[data$COMVIN == 1, ]))
(n2 <- nrow(data[data$COMVIN == 2, ]))

# Somme carrés intra SCE
SCE <- sum((data[data$COMVIN == 0, "CODEW0"] - moyenne_score_0)^2) +
        sum((data[data$COMVIN == 1, "CODEW0"] - moyenne_score_1)^2) +
        sum((data[data$COMVIN == 2, "CODEW0"] - moyenne_score_2)^2)

# Somme carrés inter SCR
SCR <- n0 * (moyenne_score_0 - moyenne_score)^2 +
        n1 * (moyenne_score_1 - moyenne_score)^2 +
        n2 * (moyenne_score_2 - moyenne_score)^2

# Test F
(F <- (SCR / (3 - 1)) / (SCE / (501 - 3)))

# Test anova directement
anova(lm(CODEW0 ~ as.factor(COMVIN), data = data2))
summary(aov(CODEW0 ~ as.factor(COMVIN), data = data2))

# Région critique
(fsup <- qf(alpha, df1 = 3 - 1, df2 = 501 - 3, lower.tail = FALSE))

# p-valeur
(pvalue <- pf(F, df1 = 3 - 1, df2 = 501 - 3, lower.tail = FALSE))

# 2.4 Association niveau d'éducation (certif) et consommation de vin (comvin) chez les plus de 80 ans

(personnes_plus_de_80_ans <- data[data$AGE > 80, ])

# Tableau de contingence entre certif et comvin
TCO <- table(personnes_plus_de_80_ans$CERTIF, personnes_plus_de_80_ans$COMVIN)
TCO <- rbind(TCO, colSums(TCO))
TCO <- cbind(TCO, rowSums(TCO))

# Tableau de contingence théorique
TCT <- matrix(0, nrow = 4, ncol = 4)
for (i in 1:4) {
  for (j in 1:4) {
    TCT[i, j] <- TCO[4, j] * TCO[i, 4] / TCO[4, 4]
  }
}

################## Partie 3 - Régression linéaire simple

################## Partie 4 - Régression linéaire multiple

######################################################
rm(list = ls())
gc()