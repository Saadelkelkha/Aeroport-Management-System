mysql> create database aeroport;
Query OK, 1 row affected (0.01 sec)

mysql> use aeroport;
Database changed
mysql> create table avion(
    -> ID_A INT PRIMARY KEY,
    -> NOM VARCHAR(15),
    -> CAPACITE INT);
Query OK, 0 rows affected (0.03 sec)

mysql> ALTER TABLE AVION
    -> ADD COLUMN LOCALITE VARCHAR(15);
Query OK, 0 rows affected (0.03 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> create table PILOTE(
    -> ID_P INT PRIMARY KEY,
    -> NOM VARCHAR(15),
    -> ADRESSE VARCHAR(15));
Query OK, 0 rows affected (0.04 sec)

mysql> create table VOL(
    -> ID_V INT PRIMARY KEY,
    -> ID_A INT,
    -> ID_P INT,
    -> VILLEDEPART VARCHAR(15),
    -> VILLEARRIVEE VARCHAR(15),
    -> HEUREDEPART TIME,
    -> HEUREAEEIVEE TIME);
Query OK, 0 rows affected (0.04 sec)

mysql> INSERT INTO Avion
    -> VALUES (100, 'AIRBUS', 300, 'RABAT'),(101, 'B737', 250, 'CASA'),(102, 'B737', 220, 'RABAT');
Query OK, 3 rows affected (0.01 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM Avion
    -> ORDER BY NOM;
+------+--------+----------+----------+
| ID_A | NOM    | CAPACITE | LOCALITE |
+------+--------+----------+----------+
|  100 | AIRBUS |      300 | RABAT    |
|  101 | B737   |      250 | CASA     |
|  102 | B737   |      220 | RABAT    |
+------+--------+----------+----------+
3 rows in set (0.00 sec)

mysql> SELECT NOM, Capacite FROM Avion;
+--------+----------+
| NOM    | Capacite |
+--------+----------+
| AIRBUS |      300 |
| B737   |      250 |
| B737   |      220 |
+--------+----------+
3 rows in set (0.00 sec)

mysql> SELECT DISTINCT localite FROM Avion;
+----------+
| localite |
+----------+
| RABAT    |
| CASA     |
+----------+
2 rows in set (0.00 sec)

mysql> SELECT * FROM Avion
    -> WHERE localite IN ('RABAT', 'CASA');
+------+--------+----------+----------+
| ID_A | NOM    | CAPACITE | LOCALITE |
+------+--------+----------+----------+
|  100 | AIRBUS |      300 | RABAT    |
|  101 | B737   |      250 | CASA     |
|  102 | B737   |      220 | RABAT    |
+------+--------+----------+----------+
3 rows in set (0.00 sec)

mysql> UPDATE Avion
    -> SET Capacite = 220
    -> WHERE ID_A = 101;
Query OK, 1 row affected (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> DELETE FROM Avion
    -> WHERE Capacite < 200;
Query OK, 0 rows affected (0.00 sec)

mysql> SELECT MAX(Capacite) AS Capacite_Max,MIN(Capacite) AS Capacite_Min,AVG(Capacite) AS Capacite_Moyenne FROM Avion;
+--------------+--------------+------------------+
| Capacite_Max | Capacite_Min | Capacite_Moyenne |
+--------------+--------------+------------------+
|          300 |          220 |         246.6667 |
+--------------+--------------+------------------+
1 row in set (0.00 sec)

mysql> SELECT * FROM Avion
    -> WHERE Capacite = (SELECT MIN(Capacite) FROM Avion);
+------+------+----------+----------+
| ID_A | NOM  | CAPACITE | LOCALITE |
+------+------+----------+----------+
|  101 | B737 |      220 | CASA     |
|  102 | B737 |      220 | RABAT    |
+------+------+----------+----------+
2 rows in set (0.00 sec)

mysql> SELECT * FROM Avion
    -> WHERE Capacite > (SELECT AVG(Capacite) FROM Avion);
+------+--------+----------+----------+
| ID_A | NOM    | CAPACITE | LOCALITE |
+------+--------+----------+----------+
|  100 | AIRBUS |      300 | RABAT    |
+------+--------+----------+----------+
1 row in set (0.00 sec)

mysql> insert into pilote
    -> values(1,'kbbour','azli'),(2,'saad','massira 1');
Query OK, 2 rows affected (0.02 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> alter table vol
    -> add foreign key (id_a) references avion(id_a);
Query OK, 0 rows affected (0.13 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> alter table vol
    -> add foreign key (id_p) references pilote(id_p);
Query OK, 0 rows affected (0.10 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> alter table vol
    -> modify id_v varchar(15);
Query OK, 0 rows affected (0.10 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> insert into vol
    -> values ('IT100', 100, 1, 'Rabat', 'Casablanca', '08:00', '09:30'),('IT101', 101, 2, 'Marrakech', 'Agadir', '10:15', '11:45'),('IT102', 102, 1, 'Tangier', 'Fez', '12:30', '14:00');
Query OK, 3 rows affected (0.01 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> select id_v, nom, adresse from pilote join vol
    -> where id_v in ('IT100','IT102') AND PILOTE.ID_P = VOL.ID_P;
+-------+--------+---------+
| id_v  | nom    | adresse |
+-------+--------+---------+
| IT100 | kbbour | azli    |
| IT102 | kbbour | azli    |
+-------+--------+---------+
2 rows in set (0.00 sec)

mysql> select id_P from pilote
    -> WHERE ID_P IN (SELECT ID_P FROM VOL);
+------+
| id_P |
+------+
|    1 |
|    2 |
+------+
2 rows in set (0.00 sec)

mysql> select id_P from pilote
    -> WHERE ID_P NOT IN (SELECT ID_P FROM VOL);
Empty set (0.00 sec)

mysql> select nom from pilote
    -> where id_p in (SELECT ID_P FROM VOL);
+--------+
| nom    |
+--------+
| kbbour |
| saad   |
+--------+
2 rows in set (0.00 sec)

mysql> select nom from pilote
    -> where id_p in (SELECT ID_P FROM VOL where id_a in (select id_a from avion where nom = 'AIRBUS'));
+--------+
| nom    |
+--------+
| kbbour |
+--------+
1 row in set (0.01 sec)

mysql>