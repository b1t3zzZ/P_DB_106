# Dossier de Rendu Final — Jalon 80%
## Module C106 : Interroger, traiter et assurer la maintenance des bases de données
### Projet : Gestion d’une pizzeria avec livraisons (ThanosPizza)

* **Apprenti :** Maksym Tsybulevskyi
* **Formation :** Informaticien CFC — ETML Lausanne
* **SGBD :** MySQL 8.0 (Docker) & phpMyAdmin
* **Outil de modélisation :** Looping (MERISE)

---

## 📌 Contenu du dossier de rendu (95%)

Ce dossier regroupe l'intégralité des livrables techniques et administratifs attendus pour la validation finale à 100% du module C106 :

<<<<<<< HEAD
1. [**📄 Rapport_100%.md**](./Rapport_100%.md) :  
=======
1. [**📄 Rapport 95%.md**](./Rapport%20100%25.md) :  
>>>>>>> d8e7ae7ef52b79448f9af7e7891e39b3c0fb901c
   Rapport technique complet et interactif structuré selon les sections 3.1 à 3.9 du Cahier des Charges :
   - Modélisation conceptuelle et logique (MCD initial et finalisé, MLD normalisé).
   - Script de création des tables, contraintes d'intégrité référentielle et contraintes de domaine CHECK (prix et quantités positifs).
   - Procédures d'importation des données brutes avec traitement des valeurs `NULL`.
   - Stratégie et commandes de sauvegarde / restauration avec démonstration sécurisée de l'état Avant / Après.
   - Requêtes SQL d'exploitation métier et statistiques décisionnelles (avec captures de résultat pour chaque requête).
   - Analyse de performance et propositions d'indexation validées avec `EXPLAIN`.
   - Matrice de sécurité et implémentation des rôles / privilèges utilisateurs.
   - **Gestion des transactions et intégrité des données (Section 3.8)** :
     - Cas 1 : Annulation atomique de commande (`DELETE` livraison + `UPDATE` statut).
     - Cas 2 : Contrôle financier de solde avant expédition (`COMMIT` si soldé, `ROLLBACK` si impayé).
   - Déclaration d'utilisation de l'intelligence artificielle et journal de vérification humaine.
   - Feuilles d'approbation et signatures.

<<<<<<< HEAD
2. [**📁 db/**](./db/) :  
   - [📄 db_thanospizza.sql](./db/db_thanospizza.sql) : Script DDL exécutable pour la création de la base de données, des 10 tables typées avec contraintes CHECK et des instructions `LOAD DATA LOCAL INFILE`.
   - [📄 db_sauvegarde_thanospizza.sql](./db/db_sauvegarde_thanospizza.sql) : Fichier de sauvegarde intégrale généré avec `mysqldump`.

3. [**📄 eval_retour_80%.docx**](./eval_retour_80%.docx) :  
   Document officiel de retour d'évaluation intermédiaire du jalon 80% ayant servi de guide pour les améliorations de robustesse et de validation.
=======
2. [**📄 db_thanospizza.sql**](./db_thanospizza.sql) :  
   Script DDL exécutable pour la création de la base de données, des 10 tables typées et des instructions `LOAD DATA LOCAL INFILE`.
>>>>>>> d8e7ae7ef52b79448f9af7e7891e39b3c0fb901c

3. [**📊 T-POO-pr55xpt.xlsm**](./T-POO-pr55xpt.xlsm) :  
   Journal de travail (JdT) personnel contenant la planification prévisionnelle et le suivi effectif des tâches (Semaines 1 à 5).

4. [**📁 data/**](./data/) :  
   Ensemble des 10 fichiers de données brutes d'importation au format TSV (`01_t_client.tsv` à `10_t_livraison.tsv`).

<<<<<<< HEAD
6. [**🖼️ images/**](./images/) :  
   Captures d'écran et illustrations intégrées au rapport (40 captures couvrant DDL, LOAD DATA, Sauvegarde Avant/Après, 12 requêtes SQL, Rôles/Privilèges, validations EXPLAIN et comparatifs d'intégrité).

7. [**📁 info_manuel/**](./info_manuel/) :  
=======
5. [**🖼️ images/**](./images/) :  
   Captures d'écran et illustrations intégrées au rapport (36 captures couvrant DDL, LOAD DATA, Sauvegarde, 12 requêtes SQL, Rôles/Privilèges et comparatifs d'intégrité Avant/Après).

6. [**📁 info_pour_rapport/**](./info_pour_rapport/) :  
>>>>>>> d8e7ae7ef52b79448f9af7e7891e39b3c0fb901c
   Dossier d'archivage des travaux préparatoires personnels réalisés en amont de manière autonome :
   - [📄 Rapport 19.52.37.docx](./info_manuel/Rapport%2019.52.37.docx) : Rapport personnel Word complété avec les transactions et les modifications post-évaluation 50% et 80%.
   - [📄 Requetes.txt](./info_manuel/Requetes.txt) : Brouillons et notes de requêtes SQL.
   - [📄 P_DB_106-Tsybulevskyi.loo](./info_manuel/P_DB_106-Tsybulevskyi.loo) : Modélisation MERISE sous Looping.
