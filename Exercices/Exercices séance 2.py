###### Exercice 1
def bissextile(n:int) -> bool :
    if (n % 4 == 0 and n % 100 != 0) or (n%400==0):
        return True
    return False

# Tests
print(bissextile(2012)) # True
print(bissextile(2023)) # False
print(bissextile(400)) # True

###### Exercice 2
def prixRepro(nb:int) -> float:
    """
    Affiche le prix en euro d'un nombre de copies à imprimer.
    """
    if nb < 0 :
        print("Le nombre de copies doit être positif")
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
print(prixRepro(-5)) #

###### Exercice 3
def saisieWhile():
    """
    L'utilisateur saisie le nombre de nombres voulues, puis les rentre.
    """
    return

def saisieFor():
    return
# Tests

###### Exercice 4
def ecart_type(l:list) -> float :
    return
# Tests

###### Exercice 5
def estPremier (n:int) -> bool:
    return
# Tests

###### Exercice 6
def enleverDoublon(l:list)->list:
    return
# Tests

###### Exercice 7 ######

### Tris quadratiques

### Tris linéaires

# Tests