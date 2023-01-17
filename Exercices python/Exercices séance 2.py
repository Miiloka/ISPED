# PACKAGES POUR EXERCICE 4
import random as rd

###### Exercice 1
print("########## Exercice 1 ########## \n ")

def bissextile(n:int) -> bool :
    """
    Retourne True si l'année est bissextile, False sinon.    
    """
    if (n % 4 == 0 and n % 100 != 0) or (n%400==0):
        return True
    return False

# Tests
print(bissextile(2012)) # True
print(bissextile(2023)) # False
print(bissextile(400)) # True

###### Exercice 2
print("\n ########## Exercice 2 ########## \n ")
def prixRepro(nb:int) -> float:
    """
    Affiche le prix en euro d'un nombre de copies à imprimer.
    """
    if nb < 0 :
        return("Le nombre de copies doit être positif")
    if 0 <= nb <= 10:
        prix = nb*0.2
    elif 10 < nb <=30:
        prix = 10*0.2 + (nb-10)*0.15 
    else:
        prix = 10*0.2 + 20*0.15 + (nb-30)*0.1
    
    print(f'Le prix de {nb} copies est de {prix} euros')

# Tests
print(prixRepro(10)) # 2.0
print(prixRepro(27)) # 4.55
print(prixRepro(30)) # 5.0
print(prixRepro(60)) # 8.0
print(prixRepro(-5)) # None (Le nombre de copies doit être positif)

###### Exercice 3
print("\n ########## Exercice 3 ########## \n ")
def saisieFor() -> list:
    """
    L'utilisateur saisie le nombre de nombres voulues, puis les rentre.
    """
    nb = int(input("Combien de nombres voulez-vous saisir ? "))
    l = [input(f"Entrer le {i+1}th nombre : ") for i in range(nb)]
    return l

def saisieWhile():
    nb = int(input("Combien de nombres voulez-vous saisir ? "))
    i = 0
    l = []
    while i < nb:
        l.append(int(input(f"Entrer le {i+1}th nombre : ")))
        i += 1
    return l

def saisieStopQ():
    """
    Saisir des nombres entiers dans une liste jusqu’à ce que l’utilisateur saisisse Q (pour « quitter »)
    """
    l = []
    T = True
    while T:
        nb = input("Entrer un nombre ou Q pour quitter : ")
        if nb == "Q" or nb == "q":
            T = False
        elif type(nb) != int:
            try:
                l.append(int(nb))
            except:
                print("Erreur, ce n'est pas un nombre.")
        else:
            l.append(int(nb))  
    return l
# Tests
#print(saisieFor())
#print(saisieWhile())
print(saisieStopQ())

###### Exercice 4
print("\n ########## Exercice 4 ########## \n ")
def ecart_type(l:list) -> float :

    N = len(l)

    somme = 0
    sommeCarree = 0

    for i in l:
        somme += i
        sommeCarree += i**2
    
    moyenne = somme/N

    return (sommeCarree/N - moyenne**2)**0.5 # Koenig-Huygens : V(x) = E(x²) - E(x)²*

# Tests
print(ecart_type([1,2,3,4,5])) # 1.4142135623730951
print(ecart_type([-1,0,1])) # 0.816496580927726

###### Exercice 5
print("\n ########## Exercice 5 ########## \n ")
def premierPrecedent(nb:int, afficherListe:bool = True) -> bool:
    """
    Entrer un nombre entier et afficher le nombre de nombre premier inférieur à ce nombre.
    """
    # nb = int(input("Entrer un nombre : "))
    if nb <= 2:
        print("Impossible.")
        return False
    elif nb % 2 == 0:
        print("Impossible, le nombre est pair.")
        return False
    else :
        nombres = [i for i in range(3, nb) if i % 2 != 0]
        estPremier = [j for j in nombres if all(j % k != 0 for k in range(3, round(j**0.5), 2))] # Test de primalité suivant le crible d'Ératosthène
        print(f"Il y a {len(estPremier)} nombres premiers inférieurs à {nb}.")
        if afficherListe:
            print(f"Les nombres premiers inférieurs à {nb} sont : {estPremier}.")
        print(f"Le dernier nombre premier est {estPremier[-1]}.")
        return True

# Tests
premierPrecedent(15) # False
premierPrecedent(17) # True, 15
premierPrecedent(2) # False, impossible
premierPrecedent(1) # False, impossible
premierPrecedent(65537, False) # True, 65521

###### Exercice 6
print("\n ########## Exercice 6 ########## \n ")

def enleverDoublon(l:list)->list:
    """
    Enlever les doublons d'une liste.
    """
    return list(set(l))

def enleverDoublonPile(l:list)->list:
    """
    Enlever les doublons d'une liste.
    """
    pile = []
    for i in l:
        if i not in pile:
            pile.append(i)
    return pile

# Tests
print(enleverDoublon([1,2,3,4,5,1,2,3,4,5])) # [1, 2, 3, 4, 5]
print(enleverDoublonPile([1,2,3,4,5,1,2,3,4,5])) # [1, 2, 3, 4, 5]
alea = [rd.randint(0,50) for i in range(30)]
print(sorted(alea), enleverDoublon(alea))

###### Exercice 7 ######

### Tris quadratiques

### Tris linéaires

# Tests