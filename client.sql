-- authentification ou connexion dans la console de xamp en ouvrant mysql et apache
>mysql -u root --si pas de mot de passe
mysqm -u root -p motdepasse


-- lister toutes les bases de donnees
SHOW DATABASES;

-- 1 creation de la base de donnees

CREATE DATABASE ventes;
USE ventes;

SHOW TABLES;
--2 creation de la table client

CREATE TABLE clients(
 id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
 nom VARCHAR(50) NOT NULL,
 prenom VARCHAR(50) NOT NULL,
 email VARCHAR(70),
 telephone VARCHAR(20) NOT NULL
);