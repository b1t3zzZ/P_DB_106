-- =============================================================================
-- Projet C106 - Gestion d'une pizzeria avec livraisons (ThanosPizza)
-- Script de création de la base de données et chargement des données
-- =============================================================================

DROP DATABASE IF EXISTS db_thanospizza;
CREATE DATABASE IF NOT EXISTS db_thanospizza
DEFAULT CHARACTER SET utf8mb4
COLLATE utf8mb4_0900_ai_ci;

SET GLOBAL local_infile = 1;
USE db_thanospizza;

-- -----------------------------------------------------------------------------
-- 1. Table : t_client
-- Informations sur les clients enregistrés
-- -----------------------------------------------------------------------------
CREATE TABLE t_client (
   client_id INT AUTO_INCREMENT,
   nom VARCHAR(50) NOT NULL,
   prenom VARCHAR(50) NOT NULL,
   email VARCHAR(254) NOT NULL,
   telephone VARCHAR(20) NOT NULL,
   PRIMARY KEY (client_id)
) ENGINE=InnoDB;

-- -----------------------------------------------------------------------------
-- 2. Table : t_adresse
-- Adresses des clients (un client peut enregistrer plusieurs adresses)
-- -----------------------------------------------------------------------------
CREATE TABLE t_adresse (
   adresse_id INT AUTO_INCREMENT,
   rue VARCHAR(100) NOT NULL,
   npa SMALLINT NOT NULL,
   localite VARCHAR(100) NOT NULL,
   client_fk INT NOT NULL,
   PRIMARY KEY (adresse_id),
   CONSTRAINT fk_adresse_client FOREIGN KEY (client_fk) REFERENCES t_client (client_id),
   CONSTRAINT uq_client_adresse UNIQUE (client_fk, adresse_id)
) ENGINE=InnoDB;

-- -----------------------------------------------------------------------------
-- 3. Table : t_article
-- Catalogue des articles (pizzas, boissons, desserts)
-- -----------------------------------------------------------------------------
CREATE TABLE t_article (
   article_id INT AUTO_INCREMENT,
   nom VARCHAR(50) NOT NULL,
   type VARCHAR(50) NOT NULL,
   prix DECIMAL(7,2) CHECK(prix >= 0) NOT NULL,
   tva DECIMAL(3,1) NOT NULL,
   actif BOOLEAN NOT NULL DEFAULT 1,
   PRIMARY KEY (article_id)
) ENGINE=InnoDB;

-- -----------------------------------------------------------------------------
-- 4. Table : t_topping
-- Suppléments disponibles pour personnaliser les pizzas
-- -----------------------------------------------------------------------------
CREATE TABLE t_topping (
   topping_id INT AUTO_INCREMENT,
   nom VARCHAR(50) NOT NULL,
   prix DECIMAL(5,2) CHECK(prix >= 0) NOT NULL,
   actif BOOLEAN NOT NULL DEFAULT 1,
   PRIMARY KEY (topping_id)
) ENGINE=InnoDB;

-- -----------------------------------------------------------------------------
-- 5. Table : t_commande
-- Commandes effectuées (sur_place, emporter, livraison)
-- -----------------------------------------------------------------------------
CREATE TABLE t_commande (
   commande_id INT AUTO_INCREMENT,
   date_creation DATETIME NOT NULL,
   type ENUM('sur_place', 'emporter', 'livraison') NOT NULL,
   statut ENUM('recue', 'en_preparation', 'en_livraison', 'livree', 'annulee') NOT NULL,
   adresse_livraison_fk INT NULL,
   client_fk INT NOT NULL,
   PRIMARY KEY (commande_id),
   CONSTRAINT fk_commande_adresse FOREIGN KEY (adresse_livraison_fk) REFERENCES t_adresse (adresse_id),
   CONSTRAINT fk_commande_client FOREIGN KEY (client_fk) REFERENCES t_client (client_id),
   CONSTRAINT fk_client_adresse FOREIGN KEY (client_fk, adresse_livraison_fk) REFERENCES t_adresse (client_fk, adresse_id)
) ENGINE=InnoDB;

-- -----------------------------------------------------------------------------
-- 6. Table : t_ligne_commande
-- Lignes d'articles associées aux commandes
-- -----------------------------------------------------------------------------
CREATE TABLE t_ligne_commande (
   ligne_commande_id INT AUTO_INCREMENT,
   commande_fk INT NOT NULL,
   article_fk INT NOT NULL,
   quantite INT CHECK (quantite > 0) NOT NULL,
   prix_unitaire DECIMAL(10,2) CHECK(prix_unitaire >= 0) NOT NULL,
   PRIMARY KEY (ligne_commande_id),
   CONSTRAINT fk_ligne_commande FOREIGN KEY (commande_fk) REFERENCES t_commande (commande_id),
   CONSTRAINT fk_ligne_article FOREIGN KEY (article_fk) REFERENCES t_article (article_id)
) ENGINE=InnoDB;

-- -----------------------------------------------------------------------------
-- 7. Table : t_ligne_topping
-- Personnalisation des lignes de commande avec des toppings
-- -----------------------------------------------------------------------------
CREATE TABLE t_ligne_topping (
   ligne_commande_fk INT NOT NULL,
   topping_fk INT NOT NULL,
   prix_facture DECIMAL(10,2) CHECK(prix_facture >= 0) NOT NULL,
   PRIMARY KEY (ligne_commande_fk, topping_fk),
   CONSTRAINT fk_lt_ligne FOREIGN KEY (ligne_commande_fk) REFERENCES t_ligne_commande (ligne_commande_id),
   CONSTRAINT fk_lt_topping FOREIGN KEY (topping_fk) REFERENCES t_topping (topping_id)
) ENGINE=InnoDB;

-- -----------------------------------------------------------------------------
-- 8. Table : t_paiement
-- Règlements enregistrés pour chaque commande
-- -----------------------------------------------------------------------------
CREATE TABLE t_paiement (
   paiement_id INT AUTO_INCREMENT,
   commande_fk INT NOT NULL,
   date_paiement DATETIME NOT NULL,
   montant DECIMAL(10,2) CHECK(montant >= 0) NOT NULL,
   mode ENUM('carte', 'twint', 'cash', 'bon') NOT NULL,
   PRIMARY KEY (paiement_id),
   CONSTRAINT fk_paiement_commande FOREIGN KEY (commande_fk) REFERENCES t_commande (commande_id)
) ENGINE=InnoDB;

-- -----------------------------------------------------------------------------
-- 9. Table : t_livreur
-- Données relatives aux livreurs de la pizzeria
-- -----------------------------------------------------------------------------
CREATE TABLE t_livreur (
   livreur_id INT AUTO_INCREMENT,
   nom VARCHAR(50) NOT NULL,
   prenom VARCHAR(50) NOT NULL,
   telephone VARCHAR(20) NOT NULL,
   actif BOOLEAN NOT NULL DEFAULT 1,
   PRIMARY KEY (livreur_id)
) ENGINE=InnoDB;

-- -----------------------------------------------------------------------------
-- 10. Table : t_livraison
-- Détails et suivi des livraisons
-- -----------------------------------------------------------------------------
CREATE TABLE t_livraison (
   livraison_id INT AUTO_INCREMENT,
   commande_fk INT NOT NULL,
   livreur_fk INT NOT NULL,
   heure_depart DATETIME NULL,
   heure_arrivee DATETIME NULL,
   PRIMARY KEY (livraison_id),
   CONSTRAINT uq_livraison_commande UNIQUE (commande_fk),
   CONSTRAINT fk_livraison_commande FOREIGN KEY (commande_fk) REFERENCES t_commande (commande_id),
   CONSTRAINT fk_livraison_livreur FOREIGN KEY (livreur_fk) REFERENCES t_livreur (livreur_id)
) ENGINE=InnoDB;

-- =============================================================================
-- CHARGEMENT DES DONNÉES (LOAD DATA LOCAL INFILE)
-- Ordre de chargement respectant les contraintes d'intégrité référentielle
-- =============================================================================

-- 1. Importation des clients
LOAD DATA LOCAL INFILE '/scripts/data/01_t_client.tsv'
INTO TABLE t_client
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(client_id, nom, prenom, email, telephone);

-- 2. Importation des adresses
LOAD DATA LOCAL INFILE '/scripts/data/02_t_adresse.tsv'
INTO TABLE t_adresse
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(adresse_id, rue, npa, localite, client_fk);

-- 3. Importation des articles du catalogue
LOAD DATA LOCAL INFILE '/scripts/data/03_t_article.tsv'
INTO TABLE t_article
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(article_id, nom, type, prix, tva, actif);

-- 4. Importation des toppings
LOAD DATA LOCAL INFILE '/scripts/data/04_t_topping.tsv'
INTO TABLE t_topping
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(topping_id, nom, prix, actif);

-- 5. Importation des livreurs
LOAD DATA LOCAL INFILE '/scripts/data/05_t_livreur.tsv'
INTO TABLE t_livreur
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(livreur_id, nom, prenom, telephone, actif);

-- 6. Importation des commandes (conversion des valeurs vides en NULL pour l'adresse)
LOAD DATA LOCAL INFILE '/scripts/data/06_t_commande.tsv'
INTO TABLE t_commande
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(commande_id, date_creation, type, statut, client_fk, @adresse)
SET adresse_livraison_fk = NULLIF(@adresse, '');

-- 7. Importation des lignes de commande
LOAD DATA LOCAL INFILE '/scripts/data/07_t_ligne_commande.tsv'
INTO TABLE t_ligne_commande
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(ligne_commande_id, commande_fk, article_fk, quantite, prix_unitaire);

-- 8. Importation des toppings associés aux lignes de commande
LOAD DATA LOCAL INFILE '/scripts/data/08_t_ligne_topping.tsv'
INTO TABLE t_ligne_topping
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(ligne_commande_fk, topping_fk, prix_facture);

-- 9. Importation des paiements
LOAD DATA LOCAL INFILE '/scripts/data/09_t_paiement.tsv'
INTO TABLE t_paiement
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(paiement_id, commande_fk, date_paiement, montant, mode);

-- 10. Importation des livraisons (conversion des valeurs vides en NULL pour les heures)
LOAD DATA LOCAL INFILE '/scripts/data/10_t_livraison.tsv'
INTO TABLE t_livraison
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(livraison_id, commande_fk, livreur_fk, @heure_depart, @heure_arrivee)
SET heure_depart = NULLIF(@heure_depart, ''),
    heure_arrivee = NULLIF(@heure_arrivee, '');
