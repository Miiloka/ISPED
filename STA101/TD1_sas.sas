*/
codew0 : score au test de Wechsler à T0
comvin : consommation de vin déclarée à T0
-  0=non buveur
-  1=1/4 de litre /jour
-  2=1/2 litre /jour ou plus
certif : niveau d’études
-  0=sans certificat d’études primaire
-  1=avec certificat d’études primaire

numero : numéro d’identification
age : âge à T0 (en années)
sexe : sexe
- 0=hommes
* 1=femmes
metier : profession
- 0=femme au foyer
-  1=ouvrier agricole
-  2=exploitant agricole
-  3=employé de service
-  4=ouvrier
-  5=artisan-commerçant
-  6=autres employés
-  7=profession intellectuelle
/*;

*/
Exercice 1 - Description des données
/*;

* 1.1 - Importation des données "Github\ISPED\R\STA101\ad.tx"t;

proc print data=ad;
run;

* 1.2 - Description des données;

* Décrire la distribution de l’âge et du score au test de Wechsler à T0;
proc univariate data=ad;
    histogram age / normal;
    var age;
run;

proc sgplot data=ad;
    histogram age / normal;
run;

proc univariate data=ad;
    var codew0;
run;

proc sgplot data=ad;
    histogram codew0 / normal;
run;

* Décrire toutes les variables disponibles à l’aide d’indices numériques, résumer ces indices dans un seul tableau;
proc means data=ad;
    var age codew0 comvin certif;
run;

proc freq data=ad;
    tables sexe metier;
run;

*/
Exercice 2 - Tests statistiques
/*;

* 2.1 - Test de comparaison de deux moyennes indépendantes sexe et codew0;
proc ttest data=ad:
    var codew0;
	class sexe;
run;

*/
Exercice 3 - Régression linéaire simple
/*;



*/
Exercice 4 - Régression linéaire multiple
/*;

