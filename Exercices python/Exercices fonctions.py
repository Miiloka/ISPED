# Exercices du TD2 non corrigés dans le fichier "exercices structures de contrôle.py"

# Exercice 5

def estPremier(nb:int) -> bool:
    """
    Renvoie True si le nombre est premier, False sinon.
    Crible d'Ératosthène : n est premier ssi n n'est divisible que par 1 et par lui-même entre 2 et la racine carrée de n (ou n**0.5).
    """
    if nb == 1:
        return False
    elif nb == 2:
        return True
    else:
        for i in range(3, round(nb**0.5), 2):
            if nb % i == 0:
                return False
        return True

def premierSuivant(nb:int) -> int:
    """
    Renvoie le premier nombre premier supérieur à nb.
    """
    if nb == 1:
        return 2
    elif nb == 2:
        return 3
    else:
        while True:
            nb += 1
            if nb % 2 != 0 and estPremier(nb):
                return nb
    
# tests
print(premierSuivant(1)) # 2
print(premierSuivant(2)) # 3
print(premierSuivant(3)) # 5
print(premierSuivant(17)) # 19
print(premierSuivant(622431)) # 622477