-- authentification ou connexion dans la console de xamp en ouvrant mysql et apache
>mysql -u root --si pas de mot de passe
mysqm -u root -p motdepasse


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