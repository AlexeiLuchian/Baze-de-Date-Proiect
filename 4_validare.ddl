-- testare constrangere PK --
--------------------------------------------------------------------------------------------------------------------

-- la adaugarea unui id deja existent --
INSERT INTO utilizatori (id_utilizator, nume, prenume, email, parola) 
VALUES (1, 'Test', 'User', 'test.pk@email.com', 'Parola123456789');
-- eroare: "ORA-00001: unique constraint (RO_A285_SQL_S50.UTILIZATORI_PK) violated", deoarece PK nu permite duplicate

INSERT INTO produse (id_produs, titlu, pret, status, data_postare, id_utilizator) 
VALUES (1, 'Test produs', 100.00, 'disponibil', SYSDATE, 1);
-- eroare: "ORA-00001: unique constraint (RO_A285_SQL_S50.PRODUSE_PK) violated", deoarece PK nu permite duplicate
--------------------------------------------------------------------------------------------------------------------

-- la modificarea unui id intr-un id deja existent --
UPDATE utilizatori SET id_utilizator = 2 WHERE id_utilizator = 1;
-- eroare: "ORA-00001: unique constraint (RO_A285_SQL_S50.UTILIZATORI_PK) violated", deoarece PK nu permite duplicate

UPDATE produse SET id_produs = 2 WHERE id_produs = 1;
-- eroare: "ORA-00001: unique constraint (RO_A285_SQL_S50.PRODUSE_PK) violated", deoarece PK nu permite duplicate
--------------------------------------------------------------------------------------------------------------------


-- testare constrangere NN --
--------------------------------------------------------------------------------------------------------------------

-- la adaugarea unui utilizator fara nume/email sau unui set de detalii fara categorie --
INSERT INTO utilizatori (prenume, email, parola) 
VALUES ('Test', 'test.nn1@email.com', 'Parola123456789');
-- eroare: "ORA-01400: cannot insert NULL into ("RO_A285_SQL_S50"."UTILIZATORI"."NUME")", deoarece NUME e obligatoriu

INSERT INTO utilizatori (nume, prenume, parola) 
VALUES ('Test', 'Nume', 'Parola123456789');
-- eroare: "ORA-01400: cannot insert NULL into ("RO_A285_SQL_S50"."UTILIZATORI"."EMAIL")", deoarece EMAIL e obligatoriu

INSERT INTO detalii (descriere, stare, id_produs) 
VALUES ('Descriere fara categorie', 'nou', 1);
-- eroare: "ORA-01400: cannot insert NULL into ("RO_A285_SQL_S50"."DETALII"."CATEGORIE")", deoarece CATEGORIE e obligatorie
--------------------------------------------------------------------------------------------------------------------

-- la modificarea email sau pret cu NULL --
UPDATE utilizatori SET email = NULL WHERE id_utilizator = 1;
-- eroare: "ORA-01407: cannot update ("RO_A285_SQL_S50"."UTILIZATORI"."EMAIL") to NULL", deoarece EMAIL e obligatoriu

UPDATE produse SET pret = NULL WHERE id_produs = 1;
-- eroare: "ORA-01407: cannot update ("RO_A285_SQL_S50"."PRODUSE"."PRET") to NULL") to NULL", deoarece PRET e obligatoriu
--------------------------------------------------------------------------------------------------------------------


-- testare constrangere UK --
--------------------------------------------------------------------------------------------------------------------

-- la adaugarea unui utilizator cu email existent sau a altei recenzii pentru aceeasi tranzactie --
INSERT INTO utilizatori (nume, prenume, email, parola) 
VALUES ('Ionescu', 'Maria', 'ion.popescu@email.com', 'Parola123456789');
-- eroare: "ORA-00001: unique constraint (RO_A285_SQL_S50.EMAIL) violated", deoarece EMAIL e unic
INSERT INTO recenzii (rating, comentariu, id_tranzactie, id_autor, id_destinatar) 
VALUES (3, 'A doua recenzie', 1, 2, 4);
-- eroare: "ORA-00001: unique constraint (RO_A285_SQL_S50.RECENZII__IDX) violated", deoarece o tranzactie permite o singura recenzie (cumparator -> vanzator)
--------------------------------------------------------------------------------------------------------------------

-- la modificarea numarului de telefon sau emailului cu unul deja existent --
UPDATE profil SET nr_telefon = '+40721234567' WHERE id_utilizator = 2;
-- eroare: "ORA-00001: unique constraint (RO_A285_SQL_S50.NR_TELEFON) violated", deoarece NR_TELEFON e unic
UPDATE utilizatori SET email = 'maria.ionescu@email.com' WHERE id_utilizator = 1;
-- eroare: "ORA-00001: unique constraint (RO_A285_SQL_S50.EMAIL) violated", deoarece EMAIL e unic


-- testare constrangere CK --
--------------------------------------------------------------------------------------------------------------------

-- la adaugarea unui utilizator cu email fara domeniu sau a unui produs cu titlu de un caracter/al carui status nu face parte din domeniul de valori/are un pret negativ --
INSERT INTO utilizatori (nume, prenume, email, parola) 
VALUES ('Test', 'Email2', 'test@', 'Parola123456789');
-- eroare: "ORA-02290: check constraint (RO_A285_SQL_S50.SYS_C0024384771) violated", deoarece emailul nu are domeniu
INSERT INTO produse (titlu, pret, status, data_postare, id_utilizator) 
VALUES ('A', 100.00, 'disponibil', SYSDATE, 1);
-- eroare: "ORA-02290: check constraint (RO_A285_SQL_S50.SYS_C0024384738) violated", deoarece titlul trebuie sa aiba mai mult de un caracter
INSERT INTO produse (titlu, pret, status, data_postare, id_utilizator) 
VALUES ('Test status', 100.00, 'inchiriat', SYSDATE, 1);
-- eroare: "ORA-02290: check constraint (RO_A285_SQL_S50.SYS_C0024384740) violated", deoarece valoarea statusului nu face parte din domeniul de valori
INSERT INTO produse (titlu, pret, status, data_postare, id_utilizator) 
VALUES ('Produs pret negativ', -50.00, 'disponibil', SYSDATE, 1);
-- eroare: "ORA-02290: check constraint (RO_A285_SQL_S50.SYS_C0024384739) violated", deoarece pretul nu poate fi negativ
--------------------------------------------------------------------------------------------------------------------

-- la modificarea parolei utilizatorului sau a descrierii unui produs (in tabela detalii) cu una prea scurta --
UPDATE utilizatori SET parola = 'Tiny12' WHERE id_utilizator = 1;
-- eroare: "ORA-02290: check constraint (RO_A285_SQL_S50.SYS_C0024384772) violated", deoarece parola trebuie sa fie de 12 caractere sau mai lunga
UPDATE detalii SET descriere = 'Mic' WHERE id_produs = 1;
-- eroare: "ORA-02290: check constraint (RO_A285_SQL_S50.SYS_C0024384728) violated", deoarece descrierea trebuie sa fie mai lunga de 9 caractere
--------------------------------------------------------------------------------------------------------------------


-- testare constrangere FK --
--------------------------------------------------------------------------------------------------------------------

-- la adaugarea detalii pentru un produs inexistent/profil pentru un utilizator inexistent/tranzactie cu un produs inexistent --
INSERT INTO detalii (descriere, categorie, stare, id_produs) 
VALUES ('Detalii fara produs', 'diverse', 'nou', 9999);
-- eroare: "ORA-02291: integrity constraint (RO_A285_SQL_S50.DETALII_PRODUSE_FK) violated - parent key not found", deoarece produsul cu id 9999 inca nu exista
INSERT INTO profil (bio, nr_telefon, id_utilizator) 
VALUES ('Profil fara utilizator', '+40799999999', 9999);
-- eroare: "ORA-02291: integrity constraint (RO_A285_SQL_S50.PROFIL_UTILIZATORI_FK) violated - parent key not found", deoarece utilizatorul cu id 9999 inca nu exista
INSERT INTO tranzactii (pret_final, data_tranzactie, id_cumparator, id_vanzator, id_produs) 
VALUES (100.00, SYSDATE, 1, 2, 9999);
-- eroare: "ORA-02291: integrity constraint (RO_A285_SQL_S50.TRANZACTII_PRODUSE_FK) violated - parent key not found", deoarece produsul cu id 9999 inca nu exista
--------------------------------------------------------------------------------------------------------------------

-- la modificarea produs cu unul inexistent in cos_cumparaturi/cumparator cu unul inexistent in tranzactii/autor cu unul inexistent in recenzii --
UPDATE cos_cumparaturi SET id_produs = 9999 WHERE id_adaugare = 1;
-- eroare: "ORA-02291: integrity constraint (RO_A285_SQL_S50.COS_PRODUSE_FK) violated - parent key not found", deoarece produsul cu id 9999 inca nu exista
UPDATE tranzactii SET id_cumparator = 9999 WHERE id_tranzactie = 1;
-- eroare: "ORA-02291: integrity constraint (RO_A285_SQL_S50.TRANZACTII_CUMPARATOR_FK) violated - parent key not found", deoarece utilizatorul cu id 9999 inca nu exista
UPDATE recenzii SET id_autor = 9999 WHERE id_recenzie = 1;
-- eroare: "ORA-02291: integrity constraint (RO_A285_SQL_S50.AUTOR_RECENZII_FK) violated - parent key not found", deoarece utilizatorul cu id 9999 inca nu exista
--------------------------------------------------------------------------------------------------------------------

-- la stergerea unui utillizator/produs/tranzactie care este FK pentru alt tabel
DELETE FROM utilizator WHERE id_utilizator = 1;
-- eroare: "ORA-02292: integrity constraint (RO_A285_SQL_S50.TRANZACTII_CUMPARATOR_FK) violated - child record found", deoarece utilizatorul este FK pentru tabelul tranzactii (si altele)
DELETE FROM produse WHERE id_produs = 2;
-- eroare: "ORA-02292: integrity constraint (RO_A285_SQL_S50.TRANZACTII_PRODUSE_FK) violated - child record found", deoarece produsul este FK pentru tabelul tranzactii (si altele)
DELETE FROM tranzactii WHERE id_tranzactie = 1;
-- eroare: "ORA-02292: integrity constraint (RO_A285_SQL_S50.RECENZII_TRANZACTII_FK) violated - child record found", deoarece tranzactia este FK pentru tabelul recenzii
--------------------------------------------------------------------------------------------------------------------