-- Active: 1728994797964@@127.0.0.1@3306@hotel

-- 1. Afficher la liste des hôtels. Le résultat doit faire apparaître le nom de l’hôtel et la ville

SELECT hot_nom, hot_ville FROM hotel;

-- 2. Afficher la ville de résidence de Mr White Le résultat doit faire apparaître le nom, le prénom, et l'adresse du client

SELECT cli_nom, cli_prenom, cli_ville FROM client WHERE cli_nom = "White";

-- 3. Afficher la liste des stations dont l’altitude < 1000 Le résultat doit faire apparaître le nom de la station et l'altitude

SELECT sta_nom, sta_altitude FROM station WHERE sta_altitude < 1000;

-- 4. Afficher la liste des chambres ayant une capacité > 1 Le résultat doit faire apparaître le numéro de la chambre ainsi que la capacité

SELECT cha_numero, cha_capacite FROM chambre WHERE cha_capacite > 1;

-- 5. Afficher les clients n’habitant pas à Londre Le résultat doit faire apparaître le nom du client et la ville

SELECT cli_nom, cli_ville FROM client WHERE cli_ville != "Londre";

-- 6. Afficher la liste des hôtels située sur la ville de Bretou et possédant une catégorie>3 Le résultat doit faire apparaître le nom de l'hôtel, ville et la catégorie

SELECT hot_nom, hot_ville, hot_categorie FROM hotel WHERE hot_ville = "Bretou" AND hot_categorie > 3;

-- 7. Afficher la liste des hôtels avec leur station Le résultat doit faire apparaître le nom de la station, le nom de l’hôtel, la catégorie, la ville)

SELECT station.sta_nom AS 'Nom de la Station', hotel.hot_nom AS 'Nom de l’Hôtel', hotel.hot_categorie AS 'Catégorie', hotel.hot_ville AS 'Ville' FROM hotel JOIN station ON hotel.hot_sta_id = station.sta_id;

-- 8. Afficher la liste des chambres et leur hôtel Le résultat doit faire apparaître le nom de l’hôtel, la catégorie, la ville, le numéro de la chambre)

SELECT hotel.hot_nom AS 'Nom de l’Hôtel', hotel.hot_categorie AS 'Catégorie', hotel.hot_ville AS 'Ville', chambre.cha_numero AS 'Numéro de la Chambre' FROM chambre JOIN hotel ON chambre.cha_hot_id = hotel.hot_id;

-- 9. Afficher la liste des chambres de plus d'une place dans des hôtels situés sur la ville de Bretou Le résultat doit faire apparaître le nom de l’hôtel, la catégorie, la ville, le numéro de la chambre et sa capacité)

SELECT  hotel.hot_nom AS 'Nom de l’Hôtel', hotel.hot_categorie AS 'Catégorie', hotel.hot_ville AS 'Ville', chambre.cha_numero AS 'Numéro de la Chambre', chambre.cha_capacite AS 'Capacité' FROM chambre JOIN hotel ON chambre.cha_hot_id = hotel.hot_id WHERE hotel.hot_ville = 'Bretou' AND chambre.cha_capacite > 1;

-- 10. Afficher la liste des réservations avec le nom des clients Le résultat doit faire apparaître le nom du client, le nom de l’hôtel, la date de réservation

SELECT client.cli_nom AS 'Nom du Client', hotel.hot_nom AS 'Nom de l’Hôtel', reservation.res_date AS 'Date de Réservation' FROM reservation JOIN chambre ON reservation.res_cha_id = chambre.cha_id JOIN hotel ON chambre.cha_hot_id = hotel.hot_id JOIN client ON reservation.res_cli_id = client.cli_id;

-- 11. Afficher la liste des chambres avec le nom de l’hôtel et le nom de la station Le résultat doit faire apparaître le nom de la station, le nom de l’hôtel, le numéro de la chambre et sa capacité)

SELECT station.sta_nom AS 'Nom de la Station', hotel.hot_nom AS 'Nom de l’Hôtel', chambre.cha_numero AS 'Numéro de la Chambre', chambre.cha_capacite AS 'Capacité' FROM chambre JOIN hotel ON chambre.cha_hot_id = hotel.hot_id JOIN station ON hotel.hot_sta_id = station.sta_id; 

-- 12. Afficher les réservations avec le nom du client et le nom de l’hôtel Le résultat doit faire apparaître le nom du client, le nom de l’hôtel, la date de début du séjour et la durée du séjour

SELECT client.cli_nom AS 'Nom du Client', hotel.hot_nom AS 'Nom de l’Hôtel', reservation.res_date_debut AS 'Date de Début du Séjour', reservation.res_date_fin AS 'Date de Fin du Séjour', DATEDIFF(reservation.res_date_fin, reservation.res_date_debut) AS 'Durée du Séjour (Jours)' FROM reservation JOIN chambre ON reservation.res_cha_id = chambre.cha_id JOIN hotel ON chambre.cha_hot_id = hotel.hot_id JOIN client ON reservation.res_cli_id = client.cli_id;

-- 13. Compter le nombre d’hôtel par station

SELECT station.sta_nom AS 'Nom de la Station', COUNT(hotel.hot_id) AS 'Nombre d’Hôtels' FROM hotel JOIN station ON hotel.hot_sta_id = station.sta_id GROUP BY station.sta_nom;

-- 14. Compter le nombre de chambre par station

SELECT station.sta_nom AS 'Nom de la Station', COUNT(chambre.cha_id) AS 'Nombre de Chambres' FROM chambre JOIN hotel ON chambre.cha_hot_id = hotel.hot_id JOIN station ON hotel.hot_sta_id = station.sta_id GROUP BY station.sta_nom;

-- 15. Compter le nombre de chambre par station ayant une capacité > 1

SELECT station.sta_nom AS 'Nom de la Station', COUNT(chambre.cha_id) AS 'Nombre de Chambres (Capacité > 1)' FROM chambre JOIN hotel ON chambre.cha_hot_id = hotel.hot_id JOIN station ON hotel.hot_sta_id = station.sta_id WHERE chambre.cha_capacite > 1 GROUP BY station.sta_nom;

-- 16. Afficher la liste des hôtels pour lesquels Mr Squire a effectué une réservation

SELECT hotel.hot_nom AS 'Nom de l’Hôtel', hotel.hot_categorie AS 'Catégorie', hotel.hot_ville AS 'Ville' FROM reservation JOIN chambre ON reservation.res_cha_id = chambre.cha_id JOIN hotel ON chambre.cha_hot_id = hotel.hot_id JOIN client ON reservation.res_cli_id = client.cli_id WHERE client.cli_nom = 'Squire';

-- 17. Afficher la durée moyenne des réservations par station

SELECT station.sta_nom AS 'Nom de la Station', AVG(DATEDIFF(reservation.res_date_fin, reservation.res_date_debut)) AS 'Durée Moyenne des Réservations (jours)' FROM reservation JOIN chambre ON reservation.res_cha_id = chambre.cha_id JOIN hotel ON chambre.cha_hot_id = hotel.hot_id JOIN station ON hotel.hot_sta_id = station.sta_id GROUP BY station.sta_nom;