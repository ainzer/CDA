-- Active: 1728994797964@@127.0.0.1@3306@papyrus

-- III LES BESOINS D’AFFICHAGE

-- 1. Quelles sont les commandes du fournisseur 09120 ?

SELECT entcom.* FROM entcom JOIN fournis ON entcom.numfou = fournis.numfou WHERE fournis.numfou = 9120;

-- 2. Afficher le code des fournisseurs pour lesquels des commandes ont été passées.

SELECT DISTINCT f.numfou FROM fournis f JOIN entcom e ON f.numfou = e.numfou;

-- 3. Afficher le nombre de commandes fournisseurs passées, et le nombre de fournisseur concernés.

SELECT COUNT(DISTINCT e.numcom) AS nombre_commandes, COUNT(DISTINCT e.numfou) AS nombre_fournisseurs FROM entcom e;

-- 4. Editer les produits ayant un stock inférieur ou égal au stock d'alerte et dont la quantité annuelle est inférieur est inférieure à 1000 (informations à fournir : n° produit, libellé produit, stock, stock actuel d'alerte, quantité annuelle)

SELECT p.codart, p.libart, p.stkphy AS stock, p.stkale AS stock_alerte, p.qteann AS quantite_annuelle FROM produit p WHERE p.stkphy <= p.stkale AND p.qteann < 1000;

-- 5. Quels sont les fournisseurs situés dans les départements 75 78 92 77 ? L’affichage (département, nom fournisseur) sera effectué par département décroissant, puis par ordre alphabétique

SELECT SUBSTRING(f.posfou, 1, 2) AS departement, f.nomfou AS nom_fournisseur FROM fournis f WHERE SUBSTRING(f.posfou, 1, 2) IN ('75', '78', '92', '77') ORDER BY departement DESC, nom_fournisseur ASC;

-- 6. Quelles sont les commandes passées au mois de mars et avril ?

SELECT  * FROM entcom WHERE MONTH(datcom) IN (3, 4);

-- 7. Quelles sont les commandes du jour qui ont des observations particulières ? (Affichage numéro de commande, date de commande)

SELECT numcom, datcom FROM entcom WHERE DATE(datcom) = CURDATE() AND obscom IS NOT NULL;

-- 8. Lister le total de chaque commande par total décroissant (Affichage numéro de commande et total)

SELECT l.numcom, SUM(l.priuni * l.qtecde) AS total_commande FROM ligcom l GROUP BY l.numcom ORDER BY total_commande DESC;

-- 9. Lister les commandes dont le total est supérieur à 10 000€ ; on exclura dans le calcul du total les articles commandés en quantité supérieure ou égale à 1000. (Affichage numéro de commande et total)

SELECT l.numcom, SUM(l.priuni * l.qtecde) AS total_commande FROM ligcom l WHERE l.qtecde < 1000 GROUP BY l.numcom HAVING total_commande > 10000 ORDER BY total_commande DESC;

-- 10. Lister les commandes par nom fournisseur (Afficher le nom du fournisseur, le numéro de commande et la date)

SELECT f.nomfou, e.numcom, e.datcom FROM entcom e JOIN fournis f ON e.numfou = f.numfou ORDER BY f.nomfou ASC;

-- 11. Sortir les produits des commandes ayant le mot "urgent' en observation? (Afficher le numéro de commande, le nom du fournisseur, le libellé du produit et le sous total = quantité commandée * Prix unitaire)

SELECT e.numcom, f.nomfou, p.libart, (l.qtecde * l.priuni) AS sous_total FROM entcom e JOIN fournis f ON e.numfou = f.numfou JOIN ligcom l ON e.numcom = l.numcom JOIN produit p ON l.codart = p.codart WHERE e.obscom LIKE '%urgent%' ORDER BY e.numcom;

-- 12. Coder de 2 manières différentes la requête suivante : Lister le nom des fournisseurs susceptibles de livrer au moins un article

SELECT DISTINCT f.nomfou FROM fournis f JOIN entcom e ON f.numfou = e.numfou JOIN ligcom l ON e.numcom = l.numcom;

SELECT f.nomfou FROM fournis f WHERE f.numfou IN (SELECT DISTINCT e.numfou FROM entcom e JOIN ligcom l ON e.numcom = l.numcom);

-- 13. Coder de 2 manières différentes la requête suivante : Lister les commandes (Numéro et date) dont le fournisseur est celui de la commande 70210 

SELECT e.numcom, e.datcom FROM entcom e JOIN fournis f ON e.numfou = f.numfou WHERE f.numfou = (SELECT e2.numfou FROM entcom e2 WHERE e2.numcom = "70210");

SELECT e.numcom, e.datcom FROM entcom e WHERE e.numfou = (SELECT e2.numfou FROM entcom e2 WHERE e2.numcom = '70210');

-- 14. Dans les articles susceptibles d’être vendus, lister les articles moins chers (basés sur Prix1) que le moins cher des rubans (article dont le premier caractère commence par R). On affichera le libellé de l’article et prix1

SELECT p.libart, v.prix1 FROM produit p JOIN vente v ON p.codart = v.codart WHERE v.prix1 < (SELECT MIN(v2.prix1) FROM produit p2 JOIN vente v2 ON p2.codart = v2.codart WHERE p2.libart LIKE 'R%') AND p.libart NOT LIKE 'R%';

-- 15. Editer la liste des fournisseurs susceptibles de livrer les produits dont le stock est inférieur ou égal à 150 % du stock d'alerte. La liste est triée par produit puis fournisseur

SELECT p.libart, f.nomfou FROM produit p JOIN ligcom l ON p.codart = l.codart JOIN entcom e ON l.numcom = e.numcom JOIN fournis f ON e.numfou = f.numfou WHERE p.stkphy <= (1.5 * p.stkale) ORDER BY p.libart, f.nomfou;

-- 16. Éditer la liste des fournisseurs susceptibles de livrer les produit dont le stock est inférieur ou égal à 150 % du stock d'alerte et un délai de livraison d'au plus 30 jours. La liste est triée par fournisseur puis produit

SELECT f.nomfou, p.libart FROM produit p JOIN ligcom l ON p.codart = l.codart JOIN entcom e ON l.numcom = e.numcom JOIN fournis f ON e.numfou = f.numfou JOIN vente v ON l.codart = v.codart WHERE p.stkphy <= (1.5 * p.stkale) AND v.delliv <= 30 ORDER BY f.nomfou, p.codart;

-- 17. Avec le même type de sélection que ci-dessus, sortir un total des stocks par fournisseur trié par total décroissant

SELECT f.nomfou, SUM(p.stkphy) AS total_stock FROM produit p JOIN ligcom l ON p.codart = l.codart JOIN entcom e ON l.numcom = e.numcom JOIN fournis f ON e.numfou = f.numfou WHERE p.stkphy <= (1.5 * p.stkale) GROUP BY f.nomfou ORDER BY total_stock DESC;

-- 18. En fin d'année, sortir la liste des produits dont la quantité réellement commandée dépasse 90% de la quantité annuelle prévue.

SELECT p.libart, SUM(l.qtecde) AS quantite_commande, p.qteann FROM produit p JOIN ligcom l ON p.codart = l.codart JOIN entcom e ON l.numcom = e.numcom WHERE e.datcom >= '2023-01-01' AND e.datcom < '2024-01-01' GROUP BY p.libart, p.qteann HAVING SUM(l.qtecde) > 0.9 * p.qteann;

-- 19. Calculer le chiffre d'affaire par fournisseur pour l'année 93 sachant que les prix indiqués sont hors taxes et que le taux de TVA est 20%.

SELECT f.nomfou, SUM(v.prix1 * l.qtecde) AS chiffre_affaires_ht, SUM(v.prix1 * l.qtecde) * 1.2 AS chiffre_affaire_ttc FROM fournis f JOIN entcom e ON f.numfou = e.numfou JOIN ligcom l ON e.numcom = l.numcom JOIN vente v ON l.codart = v.codart WHERE e.datcom >= '1993-01-01' AND e.datcom < '1994-01-01' GROUP BY f.nomfou ORDER BY chiffre_affaires_ht DESC;

-- IV LES BESOINS DE MISE A JOUR

-- 1. Application d'une augmentation de tarif de 4% pour le prix 1 et de 2% pour le prix2 pour le fournisseur 9180

UPDATE vente v SET v.prix1 = v.prix1 * 1.04, v.prix2 = v.prix2 * 1.02 WHERE v.codart IN (SELECT l.codart FROM ligcom l JOIN entcom e ON l.numcom = e.numcom WHERE e.numfou = '9180');

-- 2. Dans la table vente, mettre à jour le prix2 des articles dont le prix2 est null, en affectant a prix2 la valeur de prix1.

UPDATE vente SET prix2 = prix1 WHERE prix2 IS NULL;

-- 3. Mettre à jour le champ obscom en positionnant '*****' pour toutes les commandes dont le fournisseur a un indice de satisfaction <5

UPDATE entcom e SET e.obscom = '*****' WHERE e.numfou IN (SELECT f.numfou FROM fournis f WHERE f.satisf < 5);

-- 4. Suppression du produit I110

DELETE FROM vente WHERE codart = 'I110';

DELETE FROM produit WHERE codart = 'I110';

-- 5. Suppression des entête de commande qui n'ont aucune ligne

DELETE FROM entcom WHERE numcom NOT IN (SELECT numcom FROM ligcom);