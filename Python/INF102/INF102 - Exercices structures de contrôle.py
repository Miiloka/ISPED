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
print("\n ########## Exercice 7 ########## \n ")

"""
Soient L1 et L2 2 listes triées par ordre croissant. 
Les fusionner pour obtenir une liste avec tous les éléments de L1 et tous les éléments de L2 triés en ordre croissant. 
On n'utilise pas la méthode sort.
"""

def triNaif(L1, L2):
    """
    Tri en utilisant le fait que les deux listes soient triés.
    """
    L = []
    i = 0
    j = 0
    while i < len(L1) and j < len(L2):
        if L1[i] < L2[j]:
            L.append(L1[i])
            i += 1
        else:
            L.append(L2[j])
            j += 1
    L = L + L1[i:] + L2[j:]
    return L

def triParSelection(L1:list, L2:list) -> list:
    """
    Tri par sélection. 
    On cherche le minimum de la liste et on le place en début de liste.
    On recommence avec la liste restante.
    """
    L = L1 + L2
    n = len(L)
    for i in range(n-1):
        min = i
        for j in range(i+1, n):
            if L[j] < L[min]:
                min = j
        L[i], L[min] = L[min], L[i]
    return L

def triBulle(L1:list, L2:list) -> list:
    """
    Tri à bulle.
    On compare deux éléments consécutifs et on les échange si nécessaire.
    On recommence jusqu'à ce que la liste soit triée.
    """
    L = L1 + L2
    for i in range(len(L)):
        for j in range(len(L)-1):
            if L[j] > L[j+1]:
                L[j], L[j+1] = L[j+1], L[j]
    return L

def triInsertion(L1:list, L2:list) -> list:
    """
    Tri par insertion.
    On prend un élément de la liste et on le place dans la partie triée de la liste.
    On recommence avec l'élément suivant.
    """
    L = L1 + L2
    for i in range(len(L)):
        j = i
        while j > 0 and L[j] < L[j-1]:
            L[j], L[j-1] = L[j-1], L[j]
            j -= 1
    return L

def triRapide(L1:list = [], L2:list = []) -> list:
    """
    Tri rapide.
    On prend un élément de la liste comme pivot.
    On place tous les éléments inférieurs au pivot à gauche et tous les éléments supérieurs ou égaux au pivot à droite.
    On recommence avec les deux parties, de manière récursive.
    Par défaut, L1 et L2 sont des listes vides pour pouvoir appeler la fonction avec une seule liste en argument.
    """
    L = L1 + L2
    if len(L) <= 1:
        return L
    else:
        # On prend le premier élément de la liste comme pivot (on peut prendre un autre élément)
        pivot = L[0]
        inf = [x for x in L[1:] if x < pivot] # On prend tous les éléments inférieurs au pivot
        sup = [x for x in L[1:] if x >= pivot] # On prend tous les éléments supérieurs ou égaux au pivot
        return triRapide(inf) + [pivot] + triRapide(sup) # On trie récursivement les deux parties et on fusionne (concaténation)

# Tests
L1 = sorted([rd.randint(0, 100) for i in range(10)])
L2 = sorted([rd.randint(0, 100) for i in range(10)])

print(f"L1 = {L1} \n L2 = {L2} \n")
print(f"La liste triée est : {sorted(L1+L2)}")

print("Tri naïf : ", triNaif(L1, L2))
print("Tri par sélection : ",triParSelection(L1, L2))
print("Tri à bulle : ",triBulle(L1, L2))
print("Tri insertion : ",triInsertion(L1, L2))
print("Tri rapide : ",triRapide(L1, L2))