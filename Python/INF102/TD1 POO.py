#Classe Ferme
class Ferme:
    def __init__(self, nom):
        self.nom = nom
        self.animaux = []
        self.nb_animaux = 0
    
    def ajouter_animal(self, animal):
        self.animaux.append(animal)
        self.nb_animaux += 1

    def __str__(self):
        res = f"Ferme {self.nom}:\n Nombre d'animaux: {self.nb_animaux}\n"
        for animal in self.animaux:
            res += f"{animal}\n"
        return res

#Classe Animal
class Animal:
    def __init__(self, nom, age):
        self.nom = nom
        self.age = age

    def __str__(self):
        return f"{self.nom}, âgé de {self.age} ans."

    def ajouter_animal(self, animal):
        self.animaux.append(animal)
        self.nb_animaux += 1

    def __str__(self):
        res = f"Ferme {self.nom}:\\n Nombre d'animaux: {self.nb_animaux}\\n"
        for animal in self.animaux:
            res += f"{animal}\\n"
        return res

#Classe Mouton et Canard
class Mouton(Animal):
    def cri(self):
        return "Bêêê!"

    def __str__(self):
        return f"{self.nom}, âgé de {self.age} ans. Cri: {self.cri()}"

class Canard(Animal):
    def cri(self):
        return "Coin-coin!"

    def __str__(self):
        return f"{self.nom}, âgé de {self.age} ans. Cri: {self.cri()}"

#Tests
ferme = Ferme("La ferme de Jean")
mouton1 = Mouton("Sheep", 3)
mouton2 = Mouton("Dolly", 5)
canard1 = Canard("Donald", 2)
canard2 = Canard("Roger", 4)
ferme.ajouter_animal(mouton1)
ferme.ajouter_animal(mouton2)
ferme.ajouter_animal(canard1)
ferme.ajouter_animal(canard2)
print(ferme)