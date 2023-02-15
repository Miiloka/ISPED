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
