-- Active: 1728994797964@@127.0.0.1@3306@hotel

-- 1. Afficher la liste des hôtels. Le résultat doit faire apparaître le nom de l’hôtel et la ville

SELECT hot_nom, hot_ville FROM hotel;

-- 2. Afficher la ville de résidence de Mr White Le résultat doit faire apparaître le nom, le prénom, et l'adresse du client

SELECT cli_nom, cli_prenom, cli_ville FROM client WHERE cli_nom = "White";

-- 3. Afficher la liste des stations dont l’altitude < 1000 Le résultat doit faire apparaître le nom de la station et l'altitude

SELECT sta_nom, sta_altitude FROM station WHERE sta_altitude < 1000;

-- 4. Afficher la liste des chambres ayant une capacité > 1 Le résultat doit faire apparaître le numéro de la chambre ainsi que la capacité

SELECT cha_numero, cha_capacite FROM chambre WHERE cha_capacite > 1;