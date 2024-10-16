-- Active: 1728994797964@@127.0.0.1@3306@exemple


-- 33. Rechercher le prénom des employés et le numéro de la région de leur département.

SELECT employe.prenom, dept.noregion FROM employe JOIN dept ON employe.nodep = dept.nodept;

-- 34. Rechercher le numéro du département, le nom du département, le nom des employés classés par numéro de département (renommer les tables utilisées).

SELECT d.nodept AS "Numéro Département", d.nom AS "Nom Département", e.nom AS "Nom Employé" FROM employe e JOIN dept d ON e.nodep = d.nodept ORDER BY d.nodept;

-- 35. Rechercher le nom des employés du département Distribution.

SELECT e.nom AS "Nom Enployé" FROM employe e JOIN dept d ON e.nodep = d.nodept WHERE d.nom = 'Distribution';

-- 36. Rechercher le nom et le salaire des employés qui gagnent plus que leur patron, et le nom et le salaire de leur patron.

SELECT e.nom AS "Nom Employé", e.salaire AS "Salaire Employé", p.nom AS "Nom Patron", p.salaire AS "Salaire Patron" FROM employe e JOIN employe p ON e.nosup = p.noemp WHERE e.salaire > p.salaire;

-- 37. Rechercher le nom et le titre des employés qui ont le même titre que Amartakaldire.

SELECT e.nom AS "Nom Employé", e.titre AS "Titre" FROM employe e WHERE e.titre = (SELECT titre FROM employe WHERE nom = 'Amartakaldire');

-- 38. Rechercher le nom, le salaire et le numéro de département des employés qui gagnent plus qu'un seul employé du département 31, classés par numéro de département et salaire.

SELECT e.nom AS "Nom Employé", e.salaire AS "Salaire", e.nodep AS "Numéro Département" FROM employe e WHERE e.salaire > (SELECT MIN(salaire) FROM employe WHERE nodep = '31') ORDER BY e.nodep, e.salaire;

-- 39. Rechercher le nom, le salaire et le numéro de département des employés qui gagnent plus que tous les employés du département 31, classés par numéro de département et salaire.

SELECT e.nom AS "Nom Empolyé", e.salaire AS "Salaire", e.nodep AS "Numéro Département" FROM employe e WHERE e.salaire > (SELECT MAX(salaire) FROM employe WHERE nodep = '31') ORDER BY e.nodep, e.salaire;

-- 40. Rechercher le nom et le titre des employés du service 31 qui ont un titre que l'on trouve dans le département 32. 

SELECT e.nom AS "Nom Employé", e.titre AS "Titre" FROM employe e WHERE e.nodep = '31' AND e.titre IN (SELECT DISTINCT titre FROM employe WHERE nodep = '32');

-- 41. Rechercher le nom et le titre des employés du service 31 qui ont un titre l'on ne trouve pas dans le département 32.

SELECT e.nom AS "Nom Employé", e.titre AS "Titre" FROM employe e WHERE e.nodep = '31' AND e.titre NOT IN (SELECT DISTINCT titre FROM employe WHERE nodep = '32');

-- 42. Rechercher le nom, le titre et le salaire des employés qui ont le même titre et le même salaire que Fairant.

SELECT e.nom AS "Nom Employé", e.titre AS "Titre", e.salaire AS "Salaire" FROM employe e WHERE e.titre = (SELECT titre FROM employe WHERE nom = 'Fairant') AND e.salaire = (SELECT salaire FROM employe WHERE nom = 'Fairant');

-- 43. Rechercher le numéro de département, le nom du département, le nom des employés, en affichant aussi les départements dans lesquels il n'y a personne, classés par numéro de département.

SELECT d.nodept AS "Numéro Département", d.nom AS "Nom Département", e.nom AS "Nom Employé" FROM dept d LEFT JOIN employe e ON d.nodept = e.nodep ORDER BY d.nodept;

-- 44. Calculer le nombre d'employés de chaque titre.

SELECT e.titre AS "Titre", COUNT(e.noemp) AS "Nombre d'Employés" FROM employe e GROUP BY e.titre;

-- 45. Calculer la moyenne des salaires et leur somme, par région.

SELECT d.noregion AS "Région", AVG(e.salaire) AS "Moyenne des Salaires", SUM(e.salaire) AS "Somme des Salaires" FROM employe e JOIN dept d ON e.nodep = d.nodept GROUP BY d.noregion;

-- 46. Afficher les numéros des départements ayant au moins 3 employés.

SELECT e.nodep AS "Numéro Département", COUNT(e.noemp) AS "Nombre d'Employés" FROM employe e GROUP BY e.nodep HAVING COUNT(e.noemp) >= 3;

-- 47. Afficher les lettres qui sont l'initiale d'au moins trois employés.

SELECT LEFT(e.nom, 1) AS "Initiale", COUNT(e.noemp) AS "Nombre d'Employés" FROM employe e GROUP BY LEFT(e.nom, 1) HAVING COUNT(e.noemp) >= 3;

-- 48. Rechercher le salaire maximum et le salaire minimum parmi tous les salariés et l'écart entre les deux.

SELECT MAX(e.salaire) AS "Salaire Maximum", MIN(e.salaire) AS "Salaire Minimum", (MAX(e.salaire) - MIN(e.salaire)) AS "Écart des Salaires" FROM employe e;

-- 49. Rechercher le nombre de titres différents.

SELECT COUNT(DISTINCT e.titre) AS "Nombre de Titres Différents" FROM employe e;

-- 50. Pour chaque titre, compter le nombre d'employés possédant ce titre.

-- 51. Pour chaque nom de département, afficher le nom du département et le nombre d'employés.

-- 52. Rechercher les titres et la moyenne des salaires par titre dont la moyenne est supérieure à la moyenne des salaires des Représentants.

-- 53. Rechercher le nombre de salaires renseignés et le nombre de taux de commission renseignés