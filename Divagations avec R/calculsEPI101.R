########################################## UTILISATION DES FONCTIONS ##########################################

(tableauExercice <- creationTableau(27, 1523, 65-27, 10244-1523)) # rentrer les valeurs a, b, c, d

# Transversale


# Cas-témoins
RC(tableauExercice) 
IC_SE()
IC_M() # besoin de la statistique du chi-deux

# Cohorte


########################################## FONCTIONS ##########################################

# On a un tableau 2x2. a correspond à la ligne 1 colonne 1, b à la ligne 1 colonne 2 ...

############## TABLEAU DE CONTINGENCE ##############

creationTableau <- function(a, b, c, d){
    # Créer la matrice
    tableau <- matrix(c(a, b, c, d), 2, byrow = TRUE)

    # Ajouter les totaux
    tableau <- rbind(tableau, c(a+c, b+d))	
    tableau <- cbind(tableau, c(a+b, c+d, a+b+c+d))

    # Renommer tableau
    colnames(tableau) <- c("Malade", "Non-malade", "Total")
    rownames(tableau) <- c("Exposé", "Non exposé", "Total")

    # On retourne le tableau
    return(tableau)
}

############## ENQUETES CAS-TEMOINS #############

# Calcul de la côte d'exposition RC (ou odd-radio OR). RC = (a/c)/(b/d)

RC <- function(tableauExercice) {
    return (tableauExercice[1,1]/tableauExercice[1,3])/(tableauExercice[2,1]/tableauExercice[2,3])    
}

# Intervalle de confiance de RC selon la méthode semi-exacte et Miettinen

IC_SE <- function(RC, tableauExercice, alpha){

}

IC_M <- function(RC, tableauExercice, alpha ){

}

############## ENQUETES COHORTES ##############

# Calcul du risque relatif RR
RR <- function(tableauExercice){
    
}
# Intervalle de confiance de RR

############## ENQUETE TRANSVERSALE

# Calcul du rapport de prévalence RP
RP <- function(tableauExercice){
    
}

# Intervalle de confiance de RP

