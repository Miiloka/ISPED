# Importation
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.colors import ListedColormap

def grille(n,p):
    G = np.zeros((n,n))
    for i in range(n):
        for j in range(n):
            if np.random.rand()<p:
                G[i,j]=1
    return G

# Fonctions

def fill(G):
    n = len(G)
    L = []

    for i in range(n):
        if G[0,i]==1:
            L.append((0,i))
            G[0,i]=0.5

    while len(L)>0:
        x,y = L.pop()
        if x>0 and G[x-1,y]==1:
            G[x-1,y]=0.5
            L.append((x-1,y))
        if x<n-1 and G[x+1,y]==1:
            G[x+1,y]=0.5
            L.append((x+1,y))
        if y>0 and G[x,y-1]==1:
            G[x,y-1]=0.5
            L.append((x,y-1))
        if y<n-1 and G[x,y+1]==1:
            G[x,y+1]=0.5
            L.append((x,y+1))

    return G

def remplissage_reussi(G):
    n = len(G)
    for i in range(n):
        if G[n-1,i]==0.5:
            return True
    return False

"""
Votre programme devra afficher la probabilité que le liquide traverse (étant donnée une valeur de p et une taille de grille à saisir par l'utilisateur de votre programme)

Pour cela vous pouvez :

2. Trouver la condition pour que le liquide traverse (=> il arrive sur la dernière ligne)
3. Générer un grand nombre de grille et compter le nombre de fois où le liquide traverse => vous pourrez alors calculer 
la probabilité demandée.
"""

# 2. Trouver la condition pour que le liquide traverse (=> il arrive sur la dernière ligne)
# Soit m le nombre de murs, n la longueur du labyrinthe (n² le nombre de cases totales). 
# Si m > n(n-1), alors c'est impossible. Si m < n , alors c'est toujours possible. Sinon, ça dépend de la configuration.

# 3. Générer un grand nombre de grille et compter le nombre de fois où le liquide traverse
# On crée un affichage graphique qui permet de faire varier p et n.
# Pour chaque couple (n,p), on génère 100 grilles et on compte le nombre de fois où le liquide traverse.
# On affiche le résultat sous forme de graphique (p en abscisse, nombre de traversées en ordonnée).

def affichage():
    # Initialisation
    p = np.linspace(0.1, 1, 99)
    # que des entiers n
    n = np.linspace(1, 100, 100, dtype=int)
    P = np.zeros((100,100))
    # Calcul
    for i in range(100):
        for j in range(99):
            for k in range(100):
                G = grille(n[i],p[j])
                fill(G)
                if remplissage_reussi(G):
                    P[i,j] += 1
            P[i,j] /= 100
    # Affichage
    plt.figure()
    for i in range(100):
        plt.plot(p,P[i,:])
    plt.show()
    

affichage()