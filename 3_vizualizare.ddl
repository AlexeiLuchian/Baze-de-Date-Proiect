-- afisare produse disponibile cu informatii despre vanzator
SELECT
    p.titlu AS "Produs",
    p.pret AS "Pret (RON)",
    d.categorie AS "Categorie",
    d.stare AS "Stare",
    u.prenume || ' ' || u.nume AS "Vanzator",
    pr.nr_telefon AS "Contact"
FROM produse p
JOIN detalii d ON p.id_produs = d.id_produs
JOIN utilizatori u on p.id_utilizator = u.id_utilizator
JOIN profil pr on u.id_utilizator = pr.id_utilizator
WHERE p.status = 'disponibil' AND p.pret <= 10000;

-- afisare produse pe care utilizatorul le-a salvat in cosul de cumparaturi
SELECT 
    u.prenume || ' ' || u.nume AS "Utilizator",
    p.titlu AS "Produs salvat",
    p.pret AS "Pret",
    v.prenume || ' ' || v.nume AS "Vanzator"
FROM cos_cumparaturi cc
JOIN utilizatori u ON cc.id_utilizator = u.id_utilizator
JOIN produse p ON cc.id_produs = p.id_produs
JOIN utilizatori v ON p.id_utilizator = v.id_utilizator;

-- afisare istoric tranzactii
SELECT 
    t.data_tranzactie AS "Data",
    c.prenume || ' ' || c.nume AS "Cumparator",
    v.prenume || ' ' || v.nume AS "Vanzator",
    p.titlu AS "Produs",
    t.pret_final AS "Pret final"
FROM tranzactii t
JOIN utilizatori c ON t.id_cumparator = c.id_utilizator
JOIN utilizatori v ON t.id_vanzator = v.id_utilizator
JOIN produse p ON t.id_produs = p.id_produs;

-- afisare numarul de produse active (disponibile) si numarul de tranzactii pentru fiecare utilizator
SELECT 
    u.prenume || ' ' || u.nume AS "Utilizator",
    pr.bio AS "Descriere",
    COUNT(DISTINCT CASE WHEN p.status = 'disponibil' THEN p.id_produs END) AS "Produse active",
    COUNT(DISTINCT t.id_tranzactie) AS "Nr vanzari"
FROM utilizatori u
JOIN profil pr ON u.id_utilizator = pr.id_utilizator
LEFT JOIN produse p ON u.id_utilizator = p.id_utilizator
LEFT JOIN tranzactii t ON u.id_utilizator = t.id_vanzator
GROUP BY u.prenume, u.nume, pr.bio;