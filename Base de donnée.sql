-- Création de la base
CREATE DATABASE IF NOT EXISTS enchere CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE enchere;

-- ============================
-- TABLE UTILISATEUR
-- ============================
CREATE TABLE UTILISATEUR (
    id_utilisateur INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50),
    prenom VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    mot_de_passe VARCHAR(255),
    date_inscription DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- ============================
-- TABLE LOT (objet mis en vente)
-- ============================
CREATE TABLE LOT (
    id_lot INT AUTO_INCREMENT PRIMARY KEY,
    titre VARCHAR(150),
    description TEXT,
    image VARCHAR(255),
    prix_depart DECIMAL(10,2),
    prix_final DECIMAL(10,2) DEFAULT NULL,
    date_creation DATETIME DEFAULT CURRENT_TIMESTAMP,
    id_vendeur INT,
    FOREIGN KEY (id_vendeur) REFERENCES UTILISATEUR(id_utilisateur)
);

-- ============================
-- TABLE ENCHERE (session d’enchère)
-- ============================
CREATE TABLE ENCHERE (
    id_enchere INT AUTO_INCREMENT PRIMARY KEY,
    id_lot INT,
    date_debut DATETIME,
    date_fin DATETIME,
    statut ENUM('EN_COURS','TERMINE','ANNULEE') DEFAULT 'EN_COURS',
    FOREIGN KEY (id_lot) REFERENCES LOT(id_lot)
);

-- ============================
-- TABLE MISE (offres des utilisateurs)
-- ============================
CREATE TABLE MISE (
    id_mise INT AUTO_INCREMENT PRIMARY KEY,
    id_enchere INT,
    id_utilisateur INT,
    montant DECIMAL(10,2),
    date_mise DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_enchere) REFERENCES ENCHERE(id_enchere),
    FOREIGN KEY (id_utilisateur) REFERENCES UTILISATEUR(id_utilisateur)
);

-- ============================
-- TABLE PAIEMENT (après enchère gagnée)
-- ============================
CREATE TABLE PAIEMENT (
    id_paiement INT AUTO_INCREMENT PRIMARY KEY,
    id_enchere INT,
    id_utilisateur INT,
    montant DECIMAL(10,2),
    date_paiement DATETIME DEFAULT CURRENT_TIMESTAMP,
    methode ENUM('CB','PAYPAL','VIREMENT'),
    statut ENUM('EN_ATTENTE','PAYE','REFUSE') DEFAULT 'EN_ATTENTE',
    FOREIGN KEY (id_enchere) REFERENCES ENCHERE(id_enchere),
    FOREIGN KEY (id_utilisateur) REFERENCES UTILISATEUR(id_utilisateur)
);

-- ============================
-- TABLE HISTORIQUE_ENCHERE (optionnel mais pro)
-- ============================
CREATE TABLE HISTORIQUE_ENCHERE (
    id_historique INT AUTO_INCREMENT PRIMARY KEY,
    id_enchere INT,
    action VARCHAR(255),
    date_action DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_enchere) REFERENCES ENCHERE(id_enchere)
);
