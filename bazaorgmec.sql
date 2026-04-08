create database projekat_2026_NebojsaMatic
use projekat_2026_NebojsaMatic
create table Korisnik (
    id INT PRIMARY KEY IDENTITY(1,1),
    email NVARCHAR(50) NOT NULL UNIQUE,
    loz NVARCHAR(100) NOT NULL,
uloga INT NOT NULL
);
create table Klub (
    id INT PRIMARY KEY IDENTITY(1,1),
    naziv NVARCHAR(50) NOT NULL,
    grad NVARCHAR(50) NOT NULL,
    godina_osnivanja INT
);
create table Menadzer (
    id INT PRIMARY KEY IDENTITY(1,1),
    ime NVARCHAR(50) NOT NULL,
    prezime NVARCHAR(50) NOT NULL
);
create table Igrac (
    id INT PRIMARY KEY IDENTITY(1,1),
    ime NVARCHAR(50) NOT NULL,
    prezime NVARCHAR(50) NOT NULL,
    pozicija NVARCHAR(50),
    godine INT
);
create table Tim_Igrac (
    id INT PRIMARY KEY IDENTITY(1,1),
    igrac_id INT NOT NULL,
    klub_id INT NOT NULL,
    datum_potpisivanja DATE NOT NULL,
    datum_isteka DATE NULL,

    Constraint FK_TimIgrac_Igrac
        FOREIGN KEY (igrac_id) REFERENCES Igrac(id),

    Constraint FK_TimIgrac_Klub
        FOREIGN KEY (klub_id) REFERENCES Klub(id),

    Constraint Provera_Datum_Igrac
        CHECK (datum_isteka IS NULL OR datum_isteka > datum_potpisivanja)
);
create table Tim_Menadzer (
    id INT PRIMARY KEY IDENTITY(1,1),
    menadzer_id INT NOT NULL,
    klub_id INT NOT NULL,
    datum_pocetka DATE NOT NULL,
    datum_zavrsetka DATE NULL,

    Constraint FK_TimMenadzer_Menadzer
        FOREIGN KEY (menadzer_id) REFERENCES Menadzer(id),

    Constraint FK_TimMenadzer_Klub
        FOREIGN KEY (klub_id) REFERENCES Klub(id),

    Constraint Provera_Datum_Menadzer
        CHECK (datum_zavrsetka IS NULL OR datum_zavrsetka > datum_pocetka)
);
create table Mec (
    id INT PRIMARY KEY IDENTITY(1,1),
    domaci_klub INT NOT NULL,
    gostujuci_klub INT NOT NULL,
    datum_meca DATE NOT NULL,
    stadion NVARCHAR(50),
    golovi_domaci INT DEFAULT 0,
    golovi_gostujuci INT DEFAULT 0,

    Constraint FK_Mec_Domaci
        FOREIGN KEY (domaci_klub) REFERENCES Klub(id),

    Constraint FK_Mec_Gostujuci
        FOREIGN KEY (gostujuci_klub) REFERENCES Klub(id),

    Constraint Provera_Razliciti_Klubovi
        CHECK (domaci_klub <> gostujuci_klub)
);
create table Dogadjaj (
    id INT PRIMARY KEY IDENTITY(1,1),
    naziv_dogadjaja NVARCHAR(100) NOT NULL,
    sezona NVARCHAR(20),
    opis NVARCHAR(200)
);
create table Mec_Dogadjaj (
    id INT PRIMARY KEY IDENTITY(1,1),
    mec_id INT NOT NULL,
    dogadjaj_id INT NOT NULL,

    Constraint FK_MecDogadjaj_Mec
        FOREIGN KEY (mec_id) REFERENCES Mec(id),

    Constraint FK_MecDogadjaj_Dogadjaj
        FOREIGN KEY (dogadjaj_id) REFERENCES Dogadjaj(id)
); 
