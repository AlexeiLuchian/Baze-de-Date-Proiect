-- Auto-incrementul pentru toate id-urile este gestionat de trigger-urile create la assignment 4
-- Prin urmare putem insera valori in utilizatori, produse, tranzactii, recenzii, cos_cumparaturi fara a specifica id-ul

-- inserare utilizatori
INSERT INTO utilizatori (nume, prenume, email, parola)
VALUES ('Popescu', 'Ion Alexandru', 'ion.popescu@email.com', 'Parola123456');

INSERT INTO utilizatori (nume, prenume, email, parola) 
VALUES ('Ionescu', 'Maria-Elena', 'maria.ionescu@email.com', 'SecurePass789');

INSERT INTO utilizatori (nume, prenume, email, parola) 
VALUES ('Dumitrescu', 'Andrei', 'andrei.dumitrescu@email.com', 'MyPassword2024');

INSERT INTO utilizatori (nume, prenume, email, parola) 
VALUES ('Georgescu', 'Ana Maria', 'ana.georgescu@email.com', 'StrongPass456');

INSERT INTO utilizatori (nume, prenume, email, parola) 
VALUES ('Popa', 'Mihai', 'mihai.popa@email.com', 'SecretKey9876');

-- inserare profiluri
INSERT INTO profil (bio, nr_telefon, id_utilizator)
VALUES ('Pasionat de tehnologie si gadgeturi noi', '+40721234567', 1);

INSERT INTO profil (bio, nr_telefon, id_utilizator) 
VALUES ('Iubitor de carti si literatura clasica', '+40732345678', 2);

INSERT INTO profil (bio, nr_telefon, id_utilizator) 
VALUES ('Sportiv dedicat, vand echipament second-hand', '+40743456789', 3);

INSERT INTO profil (bio, nr_telefon, id_utilizator) 
VALUES ('Designer de interior, ofer mobilier vintage', '+40754567890', 4);

INSERT INTO profil (bio, nr_telefon, id_utilizator) 
VALUES ('Colectionar de obiecte rare si diverse', '+40765678901', 5);

-- inserare produse
INSERT INTO produse (titlu, pret, status, data_postare, id_utilizator) 
VALUES ('Laptop Dell XPS 15', 3500.00, 'disponibil', TO_DATE('2026-01-02', 'YYYY-MM-DD'), 1);

INSERT INTO produse (titlu, pret, status, data_postare, id_utilizator) 
VALUES ('Set carti Mihai Eminescu', 150.00, 'vandut', TO_DATE('2026-01-03', 'YYYY-MM-DD'), 2);

INSERT INTO produse (titlu, pret, status, data_postare, id_utilizator) 
VALUES ('Gantere set complet 50kg', 450.00, 'rezervat', TO_DATE('2026-01-01', 'YYYY-MM-DD'), 3);

INSERT INTO produse (titlu, pret, status, data_postare, id_utilizator) 
VALUES ('Canapea vintage', 400.00, 'disponibil', TO_DATE('2026-01-04', 'YYYY-MM-DD'), 4);

INSERT INTO produse (titlu, pret, status, data_postare, id_utilizator) 
VALUES ('Tablou pictat manual', 550.00, 'disponibil', TO_DATE('2026-01-03', 'YYYY-MM-DD'), 5);

-- inserare detalii produse
INSERT INTO detalii (descriere, categorie, stare, id_produs) 
VALUES ('Laptop performant, procesor i7, 16GB RAM, SSD 512GB', 'electronice', 'folosit', 1);

INSERT INTO detalii (descriere, categorie, stare, id_produs) 
VALUES ('Editie completa opere Eminescu, coperta dura, stare foarte buna', 'carti', 'folosit', 2);

INSERT INTO detalii (descriere, categorie, stare, id_produs) 
VALUES ('Set complet gantere reglabile cu bara si discuri', 'sport', 'folosit', 3);

INSERT INTO detalii (descriere, categorie, stare, id_produs) 
VALUES ('Canapea stil retro anii 60', 'mobilier', 'folosit', 4);

INSERT INTO detalii (descriere, categorie, stare, id_produs) 
VALUES ('Tablou peisaj montan, pictura in ulei, dimensiuni 60x80cm', 'diverse', 'nou', 5);

-- inserare cos cumparaturi
INSERT INTO cos_cumparaturi (id_utilizator, id_produs) 
VALUES (5, 1);

INSERT INTO cos_cumparaturi (id_utilizator, id_produs) 
VALUES (1, 5);

INSERT INTO cos_cumparaturi (id_utilizator, id_produs) 
VALUES (2, 4);

-- inserare tranzactii
INSERT INTO tranzactii (pret_final, data_tranzactie, id_cumparator, id_vanzator, id_produs) 
VALUES (140.00, TO_DATE('2026-01-03', 'YYYY-MM-DD'), 4, 2, 2);

INSERT INTO tranzactii (pret_final, data_tranzactie, id_cumparator, id_vanzator, id_produs) 
VALUES (420.00, TO_DATE('2026-01-02', 'YYYY-MM-DD'), 1, 3, 3);

-- inserare recenzii
INSERT INTO recenzii (rating, comentariu, id_tranzactie, id_autor, id_destinatar) 
VALUES (5, 'Vanzator excelent, cartile in stare perfecta!', 1, 4, 2);

INSERT INTO recenzii (rating, comentariu, id_tranzactie, id_autor, id_destinatar) 
VALUES (4, 'Echipament de calitate!', 2, 1, 3);