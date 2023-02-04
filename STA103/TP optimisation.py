from math import exp
from numpy import * 
import matplotlib.pyplot as plt

############ Exercice 1 - Dichotomie ############

def f1(x):
    return x**2 - 2

def h_test11(x):
    return x**3 * exp(x) + x - 1

# Algorithme de dichotomie
def dicho(h, a0, b0, epsilon):
    a = a0
    b = b0
    i = 0
    # On vérifie que h(a)h(b) est négatif, sinon on arrête
    if h(a) * h(b) > 0:
        stop("Erreur : h(a)h(b) doit être négatif")
    while abs(b - a) > epsilon:
        i = i + 1 # Compteur
        c = (a + b) / 2 # Milieu de l'intervalle
        if h(c) > 0:
            b = c
        else:
            a = c
    x0 = (a + b) / 2
    print(f"Le zéro de la fonction est {x0} et il a été trouvé en {i} itérations.")
    return(x0, i)

### Tests
dicho(f1, 0, 2, 10**(-5))
test1 = dicho(h_test11, 0, 1, 10**(-5))
# affichage de h_test11 sur [-1, 1]
# Montrer le zéro : tracer une ligne verticale et une horizontale à x0 et f(x0)
abscisse1 = linspace(-1, 1, 100)
plt.plot(abscisse1, h_test11(abscisse1))
plt.axvline(x = test1[0], color = "red")
plt.axhline(y = h_test11(test1[0]), color = "red")
plt.show()

############ Exercice 2 - Newton-Raphson ############
def h_test2(x):
    return (x - 1)**4 + x**2 + 4

def dh_test2(x):
    return 4 * (x - 1)**3 + 2 * x

def dh2_test2(x):
    return 12 * (x - 1)**2 + 2

def f_test2(x):
    return x**3 * exp(x) + x - 1

def df_test2(x):
    return 3 * x**2 * exp(x) + x**3 * exp(x) + 1


def h2_test(x):
    return (x - 1)**4 + (x - 2)**3 + 2 * (x - 2)**2

def dh2_test(x):
    return 4 * (x - 1)**3 + 3 * (x - 2)**2 + 4 * (x - 2)

def newton_raphson(h, dh, x0, epsilon = 10**(-5)):
    x = x0
    i = 0
    while (abs(dh(x)) >= epsilon and i < 1 / epsilon):
        i = i + 1
        x = x - h(x) / dh(x)
    print(f"Le zéro de la fonction est {x} et il a été trouvé en {i} itérations.")
    return(x, i)

##Tests
abscisse2 = linspace(-5, 5, 100)
sortie2_h = newton_raphson(dh_test2, dh2_test2, 1)
plt.plot(abscisse2, h_test2(abscisse2))
plt.axvline(x = sortie2_h[0], color = "red")
plt.axhline(y = h_test2(sortie2_h[0]), color = "red")
plt.show()