/*
Exercices écrits sur MySQL.
*/

-- Exercice 1
SELECT DISTINCT Ville FROM LECTEUR ORDER BY Ville ASC; 

-- Exercice 2
SELECT Nom, Prenom FROM LECTEUR WHERE Ville IN ('Pessac', 'Merignac') AND DATEDIFF(YEAR, DateNaiss, GETDATE()) < 5;

-- Exercice 3
SELECT RefLivre FROM PRET WHERE NumLecteur = (SELECT Numero FROM LECTEUR WHERE Nom = 'Dupont' AND Prenom = 'Jean') AND DateEmprunt = '2023-01-18';

-- Exercice 4
SELECT Nom, Prenom FROM LECTEUR WHERE Numero IN (SELECT NumLecteur FROM PRET WHERE RefLivre IN (SELECT Ref FROM EXEMPLAIRE WHERE Cote IN (SELECT Cote FROM OUVRAGE WHERE Cote IN (SELECT Cote FROM REL_OUVRAGE_AUTEUR WHERE CodeAuteur IN (SELECT CodeAuteur FROM AUTEUR WHERE NomAuteur = 'Hugo' AND PrenomAuteur = 'Victor')))));

-- Exercice 5
SELECT Nom, Prenom FROM LECTEUR WHERE (Nom, Prenom) IN (SELECT NomAuteur, PrenomAuteur FROM AUTEUR);

-- Exercice 6
SELECT COUNT(RefLivre) AS 'Nombre de livres', DateEmprunt FROM PRET WHERE NumLecteur = (SELECT Numero FROM LECTEUR WHERE Nom = 'Dupont' AND Prenom = 'Jean') GROUP BY DateEmprunt;

-- Exercice 7
SELECT RefLivre, DateEmprunt, NumLecteur FROM PRET WHERE DateRemise IS NULL AND DATEDIFF(MONTH, DateEmprunt, GETDATE()) > 1 ORDER BY DateEmprunt ASC;

-- Exercice 8
SELECT Nom, Prenom, COUNT(RefLivre)/COUNT(DISTINCT DateEmprunt) AS 'Nombre moyen de livres par jour' FROM LECTEUR JOIN PRET ON LECTEUR.Numero = PRET.NumLecteur GROUP BY Nom, Prenom;

-- Exercice 9
SELECT DISTINCT NomAuteur, PrenomAuteur FROM AUTEUR WHERE CodeAuteur IN (SELECT CodeAuteur FROM REL_OUVRAGE_AUTEUR WHERE Cote IN (SELECT Cote FROM OUVRAGE)) ORDER BY NomAuteur, PrenomAuteur ASC;

-- Exercice 10
SELECT MAX(DateEmprunt) FROM PRET WHERE NumLecteur = (SELECT Numero FROM LECTEUR WHERE Nom = 'Dupont' AND Prenom = 'Jean');

-- Exercice 11
SELECT Numero, Nom, Prenom, MAX(DateEmprunt) FROM LECTEUR JOIN PRET ON LECTEUR.Numero = PRET.NumLecteur GROUP BY Numero, Nom, Prenom;

-- Exercice 12 (2 solutions)
SELECT Numero, Nom, Prenom FROM LECTEUR WHERE Numero NOT IN (SELECT NumLecteur FROM PRET);

-- ou alors

SELECT Numero, Nom, Prenom FROM LECTEUR LEFT JOIN PRET ON LECTEUR.Numero = PRET

-- Exercice 13
SELECT Nom, Prenom FROM LECTEUR WHERE Numero NOT IN (SELECT NumLecteur FROM PRET GROUP BY NumLecteur HAVING COUNT(RefLivre) > 2);

-- Exercice 14
SELECT Ref, MAX(DateEmprunt) FROM EXEMPLAIRE JOIN PRET ON EXEMPLAIRE.Ref = PRET.RefLivre WHERE Cote LIKE 'PO%' GROUP BY Ref;