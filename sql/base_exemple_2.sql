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