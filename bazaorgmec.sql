CREATE database projekat_2026_NebojsaMatic
GO
USE projekat_2026_NebojsaMatic
GO

CREATE TABLE Korisnik (
    id INT PRIMARY KEY IDENTITY(1,1),
    email NVARCHAR(50) NOT NULL UNIQUE,
    loz NVARCHAR(100) NOT NULL,
    uloga INT NOT NULL
);

CREATE TABLE Liga (
    id INT PRIMARY KEY IDENTITY(1,1),
    naziv NVARCHAR(100) NOT NULL,
    zemlja NVARCHAR(50),
    sezona NVARCHAR(20)
);

CREATE TABLE Klub (
    id INT PRIMARY KEY IDENTITY(1,1),
    naziv NVARCHAR(50) NOT NULL,
    grad NVARCHAR(50) NOT NULL,
    godina_osnivanja INT,
    liga_id INT NULL,
    CONSTRAINT FK_Klub_Liga FOREIGN KEY (liga_id) REFERENCES Liga(id)
);

CREATE TABLE Menadzer (
    id INT PRIMARY KEY IDENTITY(1,1),
    ime NVARCHAR(50) NOT NULL,
    prezime NVARCHAR(50) NOT NULL
);

CREATE TABLE Igrac (
    id INT PRIMARY KEY IDENTITY(1,1),
    ime NVARCHAR(50) NOT NULL,
    prezime NVARCHAR(50) NOT NULL,
    pozicija NVARCHAR(50),
    godine INT
);

CREATE TABLE Tim_Igrac (
    id INT PRIMARY KEY IDENTITY(1,1),
    igrac_id INT NOT NULL,
    klub_id INT NOT NULL,
    datum_potpisivanja DATE NOT NULL,
    datum_isteka DATE NULL,
    CONSTRAINT FK_TimIgrac_Igrac FOREIGN KEY (igrac_id) REFERENCES Igrac(id),
    CONSTRAINT FK_TimIgrac_Klub FOREIGN KEY (klub_id) REFERENCES Klub(id),
    CONSTRAINT Provera_Datum_Igrac CHECK (datum_isteka IS NULL OR datum_isteka > datum_potpisivanja)
);

CREATE TABLE Tim_Menadzer (
    id INT PRIMARY KEY IDENTITY(1,1),
    menadzer_id INT NOT NULL,
    klub_id INT NOT NULL,
    datum_pocetka DATE NOT NULL,
    datum_zavrsetka DATE NULL,
    CONSTRAINT FK_TimMenadzer_Menadzer FOREIGN KEY (menadzer_id) REFERENCES Menadzer(id),
    CONSTRAINT FK_TimMenadzer_Klub FOREIGN KEY (klub_id) REFERENCES Klub(id),
    CONSTRAINT Provera_Datum_Menadzer CHECK (datum_zavrsetka IS NULL OR datum_zavrsetka > datum_pocetka)
);

CREATE TABLE Mec (
    id INT PRIMARY KEY IDENTITY(1,1),
    domaci_klub INT NOT NULL,
    gostujuci_klub INT NOT NULL,
    datum_meca DATE NOT NULL,
    stadion NVARCHAR(100),
    golovi_domaci INT DEFAULT 0,
    golovi_gostujuci INT DEFAULT 0,
    liga_id INT NULL,
    odigran BIT DEFAULT 0,
    CONSTRAINT FK_Mec_Domaci FOREIGN KEY (domaci_klub) REFERENCES Klub(id),
    CONSTRAINT FK_Mec_Gostujuci FOREIGN KEY (gostujuci_klub) REFERENCES Klub(id),
    CONSTRAINT FK_Mec_Liga FOREIGN KEY (liga_id) REFERENCES Liga(id),
    CONSTRAINT Provera_Razliciti_Klubovi CHECK (domaci_klub <> gostujuci_klub)
);

CREATE TABLE Dogadjaj (
    id INT PRIMARY KEY IDENTITY(1,1),
    naziv_dogadjaja NVARCHAR(100) NOT NULL,
    sezona NVARCHAR(20),
    opis NVARCHAR(200)
);

CREATE TABLE Mec_Dogadjaj (
    id INT PRIMARY KEY IDENTITY(1,1),
    mec_id INT NOT NULL,
    dogadjaj_id INT NOT NULL,
    CONSTRAINT FK_MecDogadjaj_Mec FOREIGN KEY (mec_id) REFERENCES Mec(id),
    CONSTRAINT FK_MecDogadjaj_Dogadjaj FOREIGN KEY (dogadjaj_id) REFERENCES Dogadjaj(id)
);
GO

INSERT INTO Korisnik(email, loz, uloga) VALUES ('admin@sport.rs', 'admin123', 1);
INSERT INTO Korisnik(email, loz, uloga) VALUES ('korisnik@sport.rs', 'korisnik123', 0);
INSERT INTO Liga(naziv, zemlja, sezona) VALUES ('Superliga Srbije', 'Srbija', '2025/26');
INSERT INTO Liga(naziv, zemlja, sezona) VALUES ('Prva liga Srbije', 'Srbija', '2025/26');
INSERT INTO Liga(naziv, zemlja, sezona) VALUES ('Kup Srbije', 'Srbija', '2025/26');
INSERT INTO Klub(naziv, grad, godina_osnivanja, liga_id) VALUES ('FK Crvena zvezda', 'Beograd', 1945, 1);
INSERT INTO Klub(naziv, grad, godina_osnivanja, liga_id) VALUES ('FK Partizan', 'Beograd', 1946, 1);
INSERT INTO Klub(naziv, grad, godina_osnivanja, liga_id) VALUES ('FK Vojvodina', 'Novi Sad', 1914, 1);
INSERT INTO Klub(naziv, grad, godina_osnivanja, liga_id) VALUES ('FK Radnicki Nis', 'Nis', 1923, 1);
INSERT INTO Klub(naziv, grad, godina_osnivanja, liga_id) VALUES ('FK Spartak', 'Subotica', 1945, 2);
INSERT INTO Menadzer(ime, prezime) VALUES ('Dragan', 'Stojkovic');
INSERT INTO Menadzer(ime, prezime) VALUES ('Vladan', 'Milojevic');
INSERT INTO Menadzer(ime, prezime) VALUES ('Savo', 'Milosevic');
INSERT INTO Igrac(ime, prezime, pozicija, godine) VALUES ('Marko', 'Arnautovic', 'Napadac', 37);
INSERT INTO Igrac(ime, prezime, pozicija, godine) VALUES ('Vanja', 'Milinkovic-Savic', 'Golman', 29);
INSERT INTO Igrac(ime, prezime, pozicija, godine) VALUES ('Nemanja', 'Radonjic', 'Krilo', 30);
INSERT INTO Igrac(ime, prezime, pozicija, godine) VALUES ('Sergej', 'Milinkovic-Savic', 'Vezni red', 31);
INSERT INTO Tim_Igrac(igrac_id, klub_id, datum_potpisivanja, datum_isteka) VALUES (1, 1, '2023-07-01', NULL);
INSERT INTO Tim_Igrac(igrac_id, klub_id, datum_potpisivanja, datum_isteka) VALUES (2, 2, '2022-01-15', NULL);
INSERT INTO Tim_Igrac(igrac_id, klub_id, datum_potpisivanja, datum_isteka) VALUES (3, 1, '2024-01-10', NULL);
INSERT INTO Tim_Igrac(igrac_id, klub_id, datum_potpisivanja, datum_isteka) VALUES (4, 3, '2025-06-30', NULL);
INSERT INTO Tim_Menadzer(menadzer_id, klub_id, datum_pocetka, datum_zavrsetka) VALUES (1, 1, '2021-06-10', NULL);
INSERT INTO Tim_Menadzer(menadzer_id, klub_id, datum_pocetka, datum_zavrsetka) VALUES (2, 2, '2022-03-20', NULL);
INSERT INTO Mec(domaci_klub, gostujuci_klub, datum_meca, stadion, golovi_domaci, golovi_gostujuci, liga_id, odigran)
VALUES (1, 2, '2025-03-01', 'Rajko Mitic', 2, 0, 1, 1);
INSERT INTO Mec(domaci_klub, gostujuci_klub, datum_meca, stadion, golovi_domaci, golovi_gostujuci, liga_id, odigran)
VALUES (2, 3, '2025-04-08', 'JNA', 1, 1, 1, 1);
INSERT INTO Mec(domaci_klub, gostujuci_klub, datum_meca, stadion, golovi_domaci, golovi_gostujuci, liga_id, odigran)
VALUES (1, 3, '2026-05-20', 'Rajko Mitic', 0, 0, 1, 0);
INSERT INTO Dogadjaj(naziv_dogadjaja, sezona, opis) VALUES ('Crveni karton', '2025/26', 'Igrac iskljucen sa terena');
INSERT INTO Dogadjaj(naziv_dogadjaja, sezona, opis) VALUES ('Penal', '2025/26', 'Dosudjen penal');
INSERT INTO Dogadjaj(naziv_dogadjaja, sezona, opis) VALUES ('Hat-trick', '2025/26', 'Igrac postigao tri gola');
INSERT INTO Mec_Dogadjaj(mec_id, dogadjaj_id) VALUES (1, 1);
INSERT INTO Mec_Dogadjaj(mec_id, dogadjaj_id) VALUES (1, 3);
INSERT INTO Mec_Dogadjaj(mec_id, dogadjaj_id) VALUES (2, 2);
GO
 
