-- authentification ou connexion dans la console de xamp en ouvrant mysql et apache
>mysql -u root --si pas de mot de passe
mysqm -u root -p motdepasse


-- verifier le mode de mysql avec ses variables globales notamment sql_mode
SHOW VARIABLES LIKE "sql_mode";
-- modifier le mode en strict
SET GLOBAL sql_mode="STRiCT_TRANS_TABLES";


-- lister toutes les bases de donnees
SHOW DATABASES;

-- 1 creation de la base de donnees

CREATE DATABASE ventes;
DEFAULT CHARACTER SET utf8;
DEFAULT COLLATE utf_general_ci;

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

-- voir la description de la table
DESC clients; -- peut aussi etre DESCRIBE

-- modifier la table en ajoutant une colonne
ALTER TABLE clients ADD COLUMN postnom VARCHAR(50); --AFTER prenom possible
-- ALTER TABLE clients MODIFY COLUMN email VARCHAR(70) NOT NULL;


-- LMD requetes

SELECT * FROM clients;

INSERT INTO clients(nom, prenom, postnom, email, telephone) values("Mollion","Maeva","MM","monemail@email.com",0000000);
INSERT INTO clients(nom, prenom, postnom, email, telephone) values("Mollion","éva","EM","monemaile@email.com",0000000);
-- insertions multiples
INSERT INTO clients(nom, prenom, postnom, email, telephone) 
    values("Universe","Steven","SU","crystalgems@email.com","0000001"),
    ("Butterfly","Star","SB","mewny@email.com","0000002");

-- rajout d'une colonne age (2 chiffres maximum)
ALTER TABLE clients ADD COLUMN age INTEGER(2);

-- mise a jour des donnees
UPDATE clients SET telephone="1234567" WHERE id=3;

-- ajout
INSERT INTO clients(nom,prenom,email,telephone,age) values("Roshi","Muten","kame@email.com","84848484",80);

--delete
DELETE FROM clients where id=5;

UPDATE clients SET age="28" WHERE id=1;
UPDATE clients SET age="14" WHERE id=2;
UPDATE clients SET age="10" WHERE id=3;
UPDATE clients SET age="16" WHERE id=4;


-- filtrer/trouver des clients specifiques
SELECT * FROM clients where age>15;
SELECT * FROM clients where age>15 AND nom="Mollion";

-- autres: or


--- l'exercice

CREATE DATABASE sales;

USE sales;

CREATE TABLE telephones(
 id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
 name VARCHAR(50) NOT NULL,
 manufacturer VARCHAR(50) NOT NULL,
 price FLOAT,
 unit_solds INTEGER
);


INSERT INTO telephones(name, manufacturer, price, unit_solds) 
    values("N1280","Nokia",199,1925),
    ("iphone4","Apple",399,9436),
    ("GalaxyS6","Samsung",299,2359),
    ("S5620Monte","Samsung",250,2385),
    ("N8","Nokia",150,7543),
    ("Droid","Motorola",150,8395),
    ("Iphone13ProMax","Apple",1300,12849),
    ("GalaxyNote20","Samsung",1100,10353);

-- requetes
SELECT name, manufacturer FROM telephones WHERE price>200;
--5: iphone4,galaxys6,s5620Monte,iphone13promax,galaxynote20
SELECT name,manufacturer FROM telephones where price>150 and price<200;
-- 1: N1280 de Nokia
SELECT name,manufacturer from telephones where manufacturer="Samsung" or manufacturer="Nokia";
-- 5: n1280,galaxys6,s5620Monte,n8,galaxynote20