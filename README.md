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

1. [**📄 Rapport 95%.md**](./Rapport%20100%25.md) :  
   Rapport technique complet et interactif structuré selon les sections 3.1 à 3.9 du Cahier des Charges :
   - Modélisation conceptuelle et logique (MCD initial et finalisé, MLD normalisé).
   - Script de création des tables et contraintes d'intégrité référentielle.
   - Procédures d'importation des données brutes avec traitement des valeurs `NULL`.
   - Stratégie et commandes de sauvegarde / restauration.
   - Requêtes SQL d'exploitation métier et statistiques décisionnelles.
   - Analyse de performance et propositions d'indexation (`EXPLAIN`).
   - Matrice de sécurité et implémentation des rôles / privilèges utilisateurs.
   - **Gestion des transactions et intégrité des données (Section 3.8)** :
     - Cas 1 : Annulation atomique de commande (`DELETE` livraison + `UPDATE` statut).
     - Cas 2 : Contrôle financier de solde avant expédition (`COMMIT` si soldé, `ROLLBACK` si impayé).
   - Déclaration d'utilisation de l'intelligence artificielle et journal de vérification humaine.
   - Feuilles d'approbation et signatures.

2. [**📄 db_thanospizza.sql**](./db_thanospizza.sql) :  
   Script DDL exécutable pour la création de la base de données, des 10 tables typées et des instructions `LOAD DATA LOCAL INFILE`.

3. [**📊 T-POO-pr55xpt.xlsm**](./T-POO-pr55xpt.xlsm) :  
   Journal de travail (JdT) personnel contenant la planification prévisionnelle et le suivi effectif des tâches (Semaines 1 à 5).

4. [**📁 data/**](./data/) :  
   Ensemble des 10 fichiers de données brutes d'importation au format TSV (`01_t_client.tsv` à `10_t_livraison.tsv`).

5. [**🖼️ images/**](./images/) :  
   Captures d'écran et illustrations intégrées au rapport (36 captures couvrant DDL, LOAD DATA, Sauvegarde, 12 requêtes SQL, Rôles/Privilèges et comparatifs d'intégrité Avant/Après).

6. [**📁 info_pour_rapport/**](./info_pour_rapport/) :  
   Dossier d'archivage des travaux préparatoires personnels réalisés en amont de manière autonome :
   - [📄 Rapport 19.52.37.docx](./info_pour_rapport/Rapport%2019.52.37.docx) : Rapport personnel Word complété avec les transactions et les modifications post-évaluation 50%.
   - [📄 Requetes.txt](./info_pour_rapport/Requetes.txt) : Brouillons et notes de requêtes SQL.
   - [📄 P_DB_106-Tsybulevskyi.loo](./info_pour_rapport/P_DB_106-Tsybulevskyi.loo) : Modélisation MERISE sous Looping.
