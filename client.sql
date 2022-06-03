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
SELECT name,manufacturer from telephones where manufacturer="Samsung" or manufacturer="Apple";
-- 5: iphone4,galaxys6,s5620Monte,iphone13promax,galaxynote20
-- autre
SELECT name,manufacturer from telephones where manufacturer IN("Apple","Samsung");
SELECT name,manufacturer FROM telephones where price BETWEEN 150 and 200;

-- order by price ascending (default) or descending
SELECT id,name,manufacturer FROM telephones ORDER BY price ASC;
SELECT id,name,manufacturer FROM telephones ORDER BY price DESC manufacturer DESC;

SELECT name AS nom,manufacturer AS constructeur,price*unit_solds AS chiffredaffaires FROM telephones;

-- concatenation
SELECT CONCAT(nom," ",manufacturer),CONCAT(price,"euros") AS prix FROM telephones;


-- les vues
CREATE VIEW nom_vue AS SELECT name AS modele,manufacturer AS constructeur ,price as PRIX, unit_solds AS unite_vendues, 
        CONCAT(price*unit_solds," euros") AS chiffre_affaire from telephones;

 SELECT * FROM nom_vue;

-- fonctions d'aggregation
 SELECT DISTINCT(manufacturer) from telephone ;

-- compter nbre d'enregistrements
 SELECT COUNT(*) FROM telephones;
 SELECT COUNT(*) FROM telephones WHERE manufacturer="Apple";

 SELECT SUM(unit_solds) AS total_ventes FROM telephones;
 -- autres: AVERAGE (AVG), MAX



 -- une personne peut avoir plusiers telephones ou plusieurs emails
 CREATE TABLE telephonesclients(
 id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
 numero VARCHAR(50) NOT NULL,
 id_client INTEGER,
 FOREIGN KEY(id_client) REFERENCES clients(id) ON DELETE CASCADE
);
-- on delete cascade: si client supprime, tous les no tel associes sont supprimes
-- on delete null: champs mis à nul si client supprime mais numero garde (par defaut)
-- on delete restrict (pas possible de del si associe a un id client)

ALTER TABLE clients DROP COLUMN telephones;
-- autre exemple: DROP DATABASE sales; DROP TABLE clients;

INSERT INTO telephones(numero,id_client) values("0636363336",1),("0637363336",1),("0736363336",1),("0638863336",2),("0636360946",2),("0636364446",3),("0637380336",4),("0708463336",4),("0636363339",5),("0636222236",6),("0636363333",6),("0788363336",6),("0639993336",6);

-- afficher tous les numeros de tel de tous les clients JOINTURES (inner join marche aussi)
SELECT clients.nom, clients.prenom,telephonesclients.numero FROM clients JOIN telephonesclients ON clients.id=telephones.id_client;



----- TP 2

CREATE DATABASE tp2;

USE tp2;


-- creer la table clients

CREATE TABLE clients(
 id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
 companyName VARCHAR(50) NOT NULL,
 firstName VARCHAR(50) NOT NULL,
 lastName VARCHAR(50) NOT NULL,
 email VARCHAR(50) NOT NULL,
 phone VARCHAR(50) NOT NULL,
 address VARCHAR(50) NOT NULL,
 zipCode VARCHAR(50) NOT NULL,
 city VARCHAR(50) NOT NULL,
 country VARCHAR(50) NOT NULL,
 state VARCHAR(5) NOT NULL
);


INSERT INTO clients(companyName,firstName,lastName,email,phone,address,zipCode,city,country,state) 
    values("CapGemini","Fabrice","Martin","martin@mail.com","0656858433","abc","xyz","Nantes","France","0"),
    ("M2i Formation","Julien","Lamard","lamard@mail.com","0611223344","abc","xyz","Paris","France","1"),
    ("ATOS","Stitch","Jumba","j@mail.com","06626612","a","b","hawaii","hawaiiH","1"),
    ("Sopra Steria","Maya","Labeille","maya@mail.com","06627612","m","a","ruche","chene","1");

-- creer la table orders
CREATE TABLE orders(
 id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
 typePresta VARCHAR(50) NOT NULL,
 designation VARCHAR(50) NOT NULL,
 clientId INTEGER,
 nbDays INTEGER,
 price FLOAT,
 state INTEGER,
 FOREIGN KEY(clientId) REFERENCES clients(id) ON DELETE CASCADE
);


INSERT INTO orders(typePresta,designation,clientId,nbDays,price,state) 
    values("Formation","Angular init",2,3,1200,0),
    ("Formation","React avance",2,3,1000,2),
    ("Coaching","React Techlead",1,20,900,2),
    ("Coaching","Nest.js Techlead",1,50,800,1),
    ("Coaching","React Techlead",3,9,9,9),
    ("Coaching","Jakarta EE",3,9,9,9),
    ("Coaching","Angular Techlead",4,9,9,9);
    
SELECT * from orders;

-- completer la table

INSERT INTO orders(typePresta,designation,clientId,nbDays,price,state) 
    values("Formation","Java",4,10,1200,2),
    ("Formation","Python",3,5,1000,2),
    ("Coaching","Python Techlead",3,20,900,2);

-- on doit creer deux vues avec totalTaxeExcluded = unitPrice x nbDays
-- et totalWithTaxes (la tva est de 20pourcent en france)

CREATE VIEW vue_taxes AS SELECT typePresta,designation,clientId,nbDays,price,
    price*nbDays AS totalTaxesExcluded, price*nbDays*1.2 AS totalWithTaxes, state from orders;

SELECT * FROM vue_taxes;

-- afficher toutes les formations de m2i formation
SELECT * FROM orders 
    JOIN clients ON orders.clientId=clients.id WHERE clients.companyName="M2i Formation";

-- afficher noms et contacts de tous les clients
--  ayant sollicite un coaching (state=1 ou 2 sur table order)
SELECT CONCAT(clients.firstName," ",clients.lastName," ",clients.email," ",clients.phone) FROM  clients 
    JOIN orders ON orders.clientId=clients.id WHERE orders.state IN ("1","2");

-- afficher noms et contacts de tous les clients
-- ayant sollicite un coaching (state=1 ou 2 sur table order) pour React.js
SELECT CONCAT(clients.firstName," ",clients.lastName," ",clients.email," ",clients.phone) FROM  clients 
    JOIN orders ON orders.clientId=clients.id WHERE orders.state IN ("1","2") 
    AND orders.typePresta="Coaching"
    AND designation="React Techlead";

-- pour chaque demande de formation, afficher prix UHT et TTC
SELECT total_TaxesExcluded,totalWithTaxes,DISTINCT(designation) FROM  vue_taxes;


-- lister toutes les presta >30000 euros et confirmees