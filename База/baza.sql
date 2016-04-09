-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema ketering_sluzba
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `ketering_sluzba` ;

-- -----------------------------------------------------
-- Schema ketering_sluzba
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ketering_sluzba` DEFAULT CHARACTER SET utf8 ;
USE `ketering_sluzba` ;

-- -----------------------------------------------------
-- Table `ketering_sluzba`.`korisnik`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ketering_sluzba`.`korisnik` ;

CREATE TABLE IF NOT EXISTS `ketering_sluzba`.`korisnik` (
  `id_korisnik` INT NOT NULL AUTO_INCREMENT,
  `ime` VARCHAR(45) NOT NULL,
  `prezime` VARCHAR(45) NOT NULL,
  `jmbg` VARCHAR(13) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `lozinka` VARCHAR(45) NOT NULL,
  `aktivan` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id_korisnik`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ketering_sluzba`.`firma`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ketering_sluzba`.`firma` ;

CREATE TABLE IF NOT EXISTS `ketering_sluzba`.`firma` (
  `id_firme` INT NOT NULL AUTO_INCREMENT,
  `naziv` VARCHAR(45) NOT NULL,
  `adresa` VARCHAR(100) NOT NULL,
  `telefon` VARCHAR(45) NOT NULL,
  `popust` INT NOT NULL,
  `ugovor_istice` DATE NOT NULL,
  PRIMARY KEY (`id_firme`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ketering_sluzba`.`korisnik_firme`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ketering_sluzba`.`korisnik_firme` ;

CREATE TABLE IF NOT EXISTS `ketering_sluzba`.`korisnik_firme` (
  `id_korisnik` INT NOT NULL,
  `id_firme` INT NOT NULL,
  `oznaka` VARCHAR(4) NULL,
  PRIMARY KEY (`id_korisnik`),
  INDEX `fk_Korisnik_firme_Firme1_idx` (`id_firme` ASC),
  CONSTRAINT `fk_Korisnik_firme_Korisnik`
    FOREIGN KEY (`id_korisnik`)
    REFERENCES `ketering_sluzba`.`korisnik` (`id_korisnik`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Korisnik_firme_Firme1`
    FOREIGN KEY (`id_firme`)
    REFERENCES `ketering_sluzba`.`firma` (`id_firme`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ketering_sluzba`.`pojedinacni_korisnik`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ketering_sluzba`.`pojedinacni_korisnik` ;

CREATE TABLE IF NOT EXISTS `ketering_sluzba`.`pojedinacni_korisnik` (
  `id_korisnik` INT NOT NULL,
  `telefon` VARCHAR(45) NOT NULL,
  `adresa` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_korisnik`),
  CONSTRAINT `fk_Pojedinacni_korisnik_Korisnik1`
    FOREIGN KEY (`id_korisnik`)
    REFERENCES `ketering_sluzba`.`korisnik` (`id_korisnik`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ketering_sluzba`.`zaposleni`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ketering_sluzba`.`zaposleni` ;

CREATE TABLE IF NOT EXISTS `ketering_sluzba`.`zaposleni` (
  `id_zaposleni` INT NOT NULL AUTO_INCREMENT,
  `pozicija` VARCHAR(10) NOT NULL,
  `ime` VARCHAR(45) NOT NULL,
  `prezime` VARCHAR(45) NOT NULL,
  `jmbg` VARCHAR(13) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `lozinka` VARCHAR(45) NOT NULL,
  `aktivan` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_zaposleni`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ketering_sluzba`.`jelo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ketering_sluzba`.`jelo` ;

CREATE TABLE IF NOT EXISTS `ketering_sluzba`.`jelo` (
  `id_jela` INT NOT NULL AUTO_INCREMENT,
  `naziv` VARCHAR(45) NOT NULL,
  `opis` VARCHAR(350) NULL,
  `tip_jela` VARCHAR(45) NOT NULL,
  `cena` INT NOT NULL,
  `slika` BLOB(1024) NULL DEFAULT NULL,
  PRIMARY KEY (`id_jela`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ketering_sluzba`.`meni`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ketering_sluzba`.`meni` ;

CREATE TABLE IF NOT EXISTS `ketering_sluzba`.`meni` (
  `id_jela` INT NOT NULL,
  `datum` DATE NOT NULL,
  PRIMARY KEY (`id_jela`),
  CONSTRAINT `fk_Meni_Jela1`
    FOREIGN KEY (`id_jela`)
    REFERENCES `ketering_sluzba`.`jelo` (`id_jela`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ketering_sluzba`.`narudzbina`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ketering_sluzba`.`narudzbina` ;

CREATE TABLE IF NOT EXISTS `ketering_sluzba`.`narudzbina` (
  `id_jela` INT NOT NULL,
  `id_korisnik` INT NOT NULL,
  `datum` DATE NOT NULL,
  `kolicina` INT NOT NULL,
  PRIMARY KEY (`id_jela`, `id_korisnik`, `datum`),
  INDEX `fk_Naruzbine_Korisnci1_idx` (`id_korisnik` ASC),
  CONSTRAINT `fk_Naruzbine_Jela1`
    FOREIGN KEY (`id_jela`)
    REFERENCES `ketering_sluzba`.`jelo` (`id_jela`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Naruzbine_Korisnci1`
    FOREIGN KEY (`id_korisnik`)
    REFERENCES `ketering_sluzba`.`korisnik` (`id_korisnik`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ketering_sluzba`.`specijalna_narudzbina`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ketering_sluzba`.`specijalna_narudzbina` ;

CREATE TABLE IF NOT EXISTS `ketering_sluzba`.`specijalna_narudzbina` (
  `id_narudzbine` INT NOT NULL AUTO_INCREMENT,
  `id_korisnik` INT NOT NULL,
  `datum` DATE NOT NULL,
  `opis_narudzbine` VARCHAR(350) NOT NULL,
  `prihvacena` TINYINT(1) NULL DEFAULT 0,
  `cena` INT NULL DEFAULT NULL,
  `naziv` VARCHAR(45) NULL DEFAULT 'null',
  `tip_jela` VARCHAR(45) NULL DEFAULT 'null',
  PRIMARY KEY (`id_narudzbine`),
  INDEX `fk_Specijalne_narudzbine_Pojedinacni_korisnici1_idx` (`id_korisnik` ASC),
  CONSTRAINT `fk_Specijalne_narudzbine_Pojedinacni_korisnici1`
    FOREIGN KEY (`id_korisnik`)
    REFERENCES `ketering_sluzba`.`pojedinacni_korisnik` (`id_korisnik`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ketering_sluzba`.`uplata_firme`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ketering_sluzba`.`uplata_firme` ;

CREATE TABLE IF NOT EXISTS `ketering_sluzba`.`uplata_firme` (
  `id_firme` INT NOT NULL,
  `mesec` INT NOT NULL,
  `godina` INT NOT NULL,
  `iznos` FLOAT NOT NULL,
  `uplaceno` TINYINT(1) NOT NULL,
  `datum_uplate` DATE NULL,
  PRIMARY KEY (`mesec`, `godina`, `id_firme`),
  INDEX `fk_Uplate_firmi_Firme1_idx` (`id_firme` ASC),
  CONSTRAINT `fk_Uplate_firmi_Firme1`
    FOREIGN KEY (`id_firme`)
    REFERENCES `ketering_sluzba`.`firma` (`id_firme`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ketering_sluzba`.`uplata_korisnika`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ketering_sluzba`.`uplata_korisnika` ;

CREATE TABLE IF NOT EXISTS `ketering_sluzba`.`uplata_korisnika` (
  `id_korisnik` INT NOT NULL,
  `datum` DATE NOT NULL,
  `uplata_do` DATE NOT NULL,
  `iznos` FLOAT NOT NULL,
  `uplaceno` TINYINT(1) NOT NULL,
  `datum_uplate` DATE NULL,
  INDEX `fk_Uplate_korisnika_Pojedinacni_korisnici1_idx` (`id_korisnik` ASC),
  PRIMARY KEY (`id_korisnik`, `datum`),
  CONSTRAINT `fk_Uplate_korisnika_Pojedinacni_korisnici1`
    FOREIGN KEY (`id_korisnik`)
    REFERENCES `ketering_sluzba`.`pojedinacni_korisnik` (`id_korisnik`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ketering_sluzba`.`anketa`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ketering_sluzba`.`anketa` ;

CREATE TABLE IF NOT EXISTS `ketering_sluzba`.`anketa` (
  `id_anketa` INT NOT NULL AUTO_INCREMENT,
  `naziv` VARCHAR(45) NOT NULL,
  `datum_pocetak` DATE NOT NULL,
  `datum_kraj` DATE NOT NULL,
  PRIMARY KEY (`id_anketa`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ketering_sluzba`.`anketno_pitanje`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ketering_sluzba`.`anketno_pitanje` ;

CREATE TABLE IF NOT EXISTS `ketering_sluzba`.`anketno_pitanje` (
  `id_pitanja` INT NOT NULL AUTO_INCREMENT,
  `id_anketa` INT NOT NULL,
  `tekst` VARCHAR(150) NULL,
  `rezultati` FLOAT NOT NULL,
  PRIMARY KEY (`id_pitanja`),
  INDEX `fk_Anketna_pitanja_Anketa1_idx` (`id_anketa` ASC),
  CONSTRAINT `fk_Anketna_pitanja_Anketa1`
    FOREIGN KEY (`id_anketa`)
    REFERENCES `ketering_sluzba`.`anketa` (`id_anketa`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ketering_sluzba`.`popunili_anketu`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ketering_sluzba`.`popunili_anketu` ;

CREATE TABLE IF NOT EXISTS `ketering_sluzba`.`popunili_anketu` (
  `id_anketa` INT NOT NULL,
  `id_korisnik` INT NOT NULL,
  `id_pitanja` INT NOT NULL,
  `odgovor` INT NOT NULL,
  PRIMARY KEY (`id_anketa`, `id_korisnik`, `id_pitanja`),
  INDEX `fk_Popunili_anketu_Korisnci1_idx` (`id_korisnik` ASC),
  INDEX `fk_Popunili_anketu_Anketno_pitanje1_idx` (`id_pitanja` ASC),
  CONSTRAINT `fk_Popunili_anketu_Anketa1`
    FOREIGN KEY (`id_anketa`)
    REFERENCES `ketering_sluzba`.`anketa` (`id_anketa`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Popunili_anketu_Korisnci1`
    FOREIGN KEY (`id_korisnik`)
    REFERENCES `ketering_sluzba`.`korisnik` (`id_korisnik`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Popunili_anketu_Anketno_pitanje1`
    FOREIGN KEY (`id_pitanja`)
    REFERENCES `ketering_sluzba`.`anketno_pitanje` (`id_pitanja`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ketering_sluzba`.`ocena_jela`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ketering_sluzba`.`ocena_jela` ;

CREATE TABLE IF NOT EXISTS `ketering_sluzba`.`ocena_jela` (
  `id_korisnik` INT NOT NULL,
  `id_jela` INT NOT NULL,
  `ocena` INT NULL,
  `komentar` VARCHAR(150) NULL,
  PRIMARY KEY (`id_korisnik`, `id_jela`),
  INDEX `fk_Ocena_jela_Jela1_idx` (`id_jela` ASC),
  CONSTRAINT `fk_Ocena_jela_Korisnci1`
    FOREIGN KEY (`id_korisnik`)
    REFERENCES `ketering_sluzba`.`korisnik` (`id_korisnik`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Ocena_jela_Jela1`
    FOREIGN KEY (`id_jela`)
    REFERENCES `ketering_sluzba`.`jelo` (`id_jela`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ketering_sluzba`.`podesavanja_sistema`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ketering_sluzba`.`podesavanja_sistema` ;

CREATE TABLE IF NOT EXISTS `ketering_sluzba`.`podesavanja_sistema` (
  `vreme_narucivanja` INT NOT NULL,
  `vreme_placanja` INT NOT NULL,
  `vreme_placanja_firme` INT NOT NULL,
  `period_cuvanja_narudzbina` INT NOT NULL,
  `period_cuvanja_menija` INT NOT NULL,
  `period_cuvanja_uplata` INT NOT NULL)
ENGINE = InnoDB;

USE `ketering_sluzba` ;

-- -----------------------------------------------------
-- Placeholder table for view `ketering_sluzba`.`aktivne_firme`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ketering_sluzba`.`aktivne_firme` (`id_firme` INT, `naziv` INT);

-- -----------------------------------------------------
-- Placeholder table for view `ketering_sluzba`.`deaktivirane_firme`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ketering_sluzba`.`deaktivirane_firme` (`id_firme` INT, `naziv` INT);

-- -----------------------------------------------------
-- Placeholder table for view `ketering_sluzba`.`aktivni_korisnici`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ketering_sluzba`.`aktivni_korisnici` (`ime` INT, `prezime` INT, `jmbg` INT);

-- -----------------------------------------------------
-- Placeholder table for view `ketering_sluzba`.`deaktivirani_korisnici`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ketering_sluzba`.`deaktivirani_korisnici` (`ime` INT, `prezime` INT, `jmbg` INT);

-- -----------------------------------------------------
-- Placeholder table for view `ketering_sluzba`.`pojedinacni_korisnici`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ketering_sluzba`.`pojedinacni_korisnici` (`ime` INT, `prezime` INT, `jmbg` INT);

-- -----------------------------------------------------
-- Placeholder table for view `ketering_sluzba`.`korisnici_firme`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ketering_sluzba`.`korisnici_firme` (`ime` INT, `prezime` INT, `jmbg` INT);

-- -----------------------------------------------------
-- Placeholder table for view `ketering_sluzba`.`jela`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ketering_sluzba`.`jela` (`naziv` INT, `opis` INT, `tip_jela` INT, `cena` INT, `slika` INT);

-- -----------------------------------------------------
-- Placeholder table for view `ketering_sluzba`.`meniji`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ketering_sluzba`.`meniji` (`naziv` INT, `opis` INT, `tip_jela` INT, `datum` INT);

-- -----------------------------------------------------
-- Placeholder table for view `ketering_sluzba`.`narudzbine`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ketering_sluzba`.`narudzbine` (`naziv` INT, `tip_jela` INT, `cena` INT, `datum` INT);

-- -----------------------------------------------------
-- Placeholder table for view `ketering_sluzba`.`specijalne_narudzbine`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ketering_sluzba`.`specijalne_narudzbine` (`ime` INT, `prezime` INT, `opis_narudzbine` INT, `datum` INT);

-- -----------------------------------------------------
-- Placeholder table for view `ketering_sluzba`.`kuhinja_spisak`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ketering_sluzba`.`kuhinja_spisak` (`id_korisnik` INT, `ime` INT, `prezime` INT, `id_jela` INT, `naziv` INT, `count(*)` INT);

-- -----------------------------------------------------
-- Placeholder table for view `ketering_sluzba`.`dostava_spisak`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ketering_sluzba`.`dostava_spisak` (`id_korisnik` INT, `ime` INT, `prezime` INT, `id_jela` INT);

-- -----------------------------------------------------
-- Placeholder table for view `ketering_sluzba`.`kuhinja_spisak_firme`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ketering_sluzba`.`kuhinja_spisak_firme` (`id_jela` INT, `naziv` INT, `count(*)` INT);

-- -----------------------------------------------------
-- Placeholder table for view `ketering_sluzba`.`sve_ankete`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ketering_sluzba`.`sve_ankete` (`naziv` INT, `datum_pocetak` INT, `datum_kraj` INT, `br_korisnika` INT);

-- -----------------------------------------------------
-- Placeholder table for view `ketering_sluzba`.`komentari_jela`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ketering_sluzba`.`komentari_jela` (`naziv` INT, `komentar` INT, `ime` INT, `prezime` INT);

-- -----------------------------------------------------
-- Placeholder table for view `ketering_sluzba`.`ocene_jela`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ketering_sluzba`.`ocene_jela` (`naziv` INT, `ocena` INT, `ime` INT, `prezime` INT);

-- -----------------------------------------------------
-- Placeholder table for view `ketering_sluzba`.`prosecne_ocene_jela`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ketering_sluzba`.`prosecne_ocene_jela` (`naziv` INT, `AVG(ocena)` INT);

-- -----------------------------------------------------
-- Placeholder table for view `ketering_sluzba`.`firme_neizmirene_obaveze`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ketering_sluzba`.`firme_neizmirene_obaveze` (`naziv` INT, `adresa` INT, `telefon` INT, `mesec` INT, `godina` INT, `iznos` INT);

-- -----------------------------------------------------
-- View `ketering_sluzba`.`aktivne_firme`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `ketering_sluzba`.`aktivne_firme` ;
DROP TABLE IF EXISTS `ketering_sluzba`.`aktivne_firme`;
USE `ketering_sluzba`;
CREATE  OR REPLACE VIEW `aktivne_firme` AS
SELECT distinct(f.id_firme), f.naziv 
FROM firma f 
	JOIN korisnik_firme kf
		ON f.id_firme = kf.id_firme
	JOIN korisnik k
		ON k.id_korisnik = kf.id_korisnik
WHERE k.aktivan = true;

-- -----------------------------------------------------
-- View `ketering_sluzba`.`deaktivirane_firme`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `ketering_sluzba`.`deaktivirane_firme` ;
DROP TABLE IF EXISTS `ketering_sluzba`.`deaktivirane_firme`;
USE `ketering_sluzba`;
CREATE  OR REPLACE VIEW `deaktivirane_firme` AS
SELECT distinct(f.id_firme), f.naziv 
FROM firma f 
	JOIN korisnik_firme kf
		ON f.id_firme = kf.id_firme
	JOIN korisnik k
		ON k.id_korisnik = kf.id_korisnik
WHERE k.aktivan = false;

-- -----------------------------------------------------
-- View `ketering_sluzba`.`aktivni_korisnici`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `ketering_sluzba`.`aktivni_korisnici` ;
DROP TABLE IF EXISTS `ketering_sluzba`.`aktivni_korisnici`;
USE `ketering_sluzba`;
CREATE  OR REPLACE VIEW `aktivni_korisnici` AS
SELECT ime, prezime, jmbg
FROM korisnik
WHERE aktivan = true;

-- -----------------------------------------------------
-- View `ketering_sluzba`.`deaktivirani_korisnici`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `ketering_sluzba`.`deaktivirani_korisnici` ;
DROP TABLE IF EXISTS `ketering_sluzba`.`deaktivirani_korisnici`;
USE `ketering_sluzba`;
CREATE  OR REPLACE VIEW `deaktivirani_korisnici` AS
SELECT ime, prezime, jmbg
FROM korisnik
WHERE aktivan = false;

-- -----------------------------------------------------
-- View `ketering_sluzba`.`pojedinacni_korisnici`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `ketering_sluzba`.`pojedinacni_korisnici` ;
DROP TABLE IF EXISTS `ketering_sluzba`.`pojedinacni_korisnici`;
USE `ketering_sluzba`;
CREATE  OR REPLACE VIEW `pojedinacni_korisnici` AS
SELECT ime, prezime, jmbg
FROM korisnik k
	JOIN pojedinacni_korisnik pk
		ON k.id_korisnik = pk.id_korisnik;

-- -----------------------------------------------------
-- View `ketering_sluzba`.`korisnici_firme`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `ketering_sluzba`.`korisnici_firme` ;
DROP TABLE IF EXISTS `ketering_sluzba`.`korisnici_firme`;
USE `ketering_sluzba`;
CREATE  OR REPLACE VIEW `korisnici_firme` AS
SELECT ime, prezime, jmbg
FROM korisnik k
	JOIN korisnik_firme kf
		ON k.id_korisnik = kf.id_korisnik;

-- -----------------------------------------------------
-- View `ketering_sluzba`.`jela`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `ketering_sluzba`.`jela` ;
DROP TABLE IF EXISTS `ketering_sluzba`.`jela`;
USE `ketering_sluzba`;
CREATE  OR REPLACE VIEW `jela` AS
SELECT naziv, opis, tip_jela, cena, slika
FROM jelo
GROUP BY tip_jela;

-- -----------------------------------------------------
-- View `ketering_sluzba`.`meniji`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `ketering_sluzba`.`meniji` ;
DROP TABLE IF EXISTS `ketering_sluzba`.`meniji`;
USE `ketering_sluzba`;
CREATE  OR REPLACE VIEW `meniji` AS
SELECT naziv, opis, tip_jela, datum
FROM meni m
	JOIN jelo j	
		ON m.id_jela = j.id_jela;

-- -----------------------------------------------------
-- View `ketering_sluzba`.`narudzbine`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `ketering_sluzba`.`narudzbine` ;
DROP TABLE IF EXISTS `ketering_sluzba`.`narudzbine`;
USE `ketering_sluzba`;
CREATE  OR REPLACE VIEW `narudzbine` AS
SELECT naziv, tip_jela, cena, n.datum
FROM narudzbina n
	JOIN jelo j
		ON n.id_jela = j.id_jela
UNION ALL
SELECT distinct(naziv), tip_jela, cena, n.datum
FROM narudzbina n
	JOIN korisnik k
		ON n.id_korisnik = k.id_korisnik
	JOIN pojedinacni_korisnik pk
		ON k.id_korisnik = pk.id_korisnik
	JOIN specijalna_narudzbina sn
		ON pk.id_korisnik = sn.id_korisnik
where sn.prihvacena = true;

-- -----------------------------------------------------
-- View `ketering_sluzba`.`specijalne_narudzbine`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `ketering_sluzba`.`specijalne_narudzbine` ;
DROP TABLE IF EXISTS `ketering_sluzba`.`specijalne_narudzbine`;
USE `ketering_sluzba`;
CREATE  OR REPLACE VIEW `specijalne_narudzbine` AS
SELECT ime, prezime, opis_narudzbine, datum
FROM korisnik k
	JOIN pojedinacni_korisnik pk
		ON k.id_korisnik = pk.id_korisnik
	JOIN specijalna_narudzbina sn
		ON pk.id_korisnik = sn.id_korisnik;

-- -----------------------------------------------------
-- View `ketering_sluzba`.`kuhinja_spisak`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `ketering_sluzba`.`kuhinja_spisak` ;
DROP TABLE IF EXISTS `ketering_sluzba`.`kuhinja_spisak`;
USE `ketering_sluzba`;
CREATE  OR REPLACE VIEW `kuhinja_spisak` AS
SELECT n.id_korisnik, ime, prezime, n.id_jela, naziv, count(*)
FROM narudzbina n
	JOIN jelo j
		ON n.id_jela = j.id_jela
	JOIN korisnik k
		ON k.id_korisnik = n.id_korisnik
	JOIN pojedinacni_korisnik pk
		ON k.id_korisnik = pk.id_korisnik
GROUP BY id_korisnik, ime, prezime, id_jela, naziv
UNION ALL
SELECT distinct(n.id_korisnik), ime, prezime, n.id_jela, sn.naziv, count(*)
FROM narudzbina n
	JOIN korisnik k
		ON n.id_korisnik = k.id_korisnik
	JOIN pojedinacni_korisnik pk
		ON k.id_korisnik = pk.id_korisnik
	JOIN specijalna_narudzbina sn
		ON pk.id_korisnik = sn.id_korisnik
where sn.prihvacena = true;

-- -----------------------------------------------------
-- View `ketering_sluzba`.`dostava_spisak`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `ketering_sluzba`.`dostava_spisak` ;
DROP TABLE IF EXISTS `ketering_sluzba`.`dostava_spisak`;
USE `ketering_sluzba`;
CREATE  OR REPLACE VIEW `dostava_spisak` AS
SELECT n.id_korisnik, ime, prezime, n.id_jela
FROM narudzbina n
	JOIN jelo j
		ON n.id_jela = j.id_jela
	JOIN korisnik k
		ON k.id_korisnik = n.id_korisnik
	JOIN pojedinacni_korisnik pk
		ON pk.id_korisnik = k.id_korisnik
UNION ALL
SELECT distinct(n.id_korisnik), ime, prezime, 0
FROM narudzbina n
	JOIN korisnik k
		ON n.id_korisnik = k.id_korisnik
	JOIN pojedinacni_korisnik pk
		ON k.id_korisnik = pk.id_korisnik
	JOIN specijalna_narudzbina sn
		ON pk.id_korisnik = sn.id_korisnik
where sn.prihvacena = true;

-- -----------------------------------------------------
-- View `ketering_sluzba`.`kuhinja_spisak_firme`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `ketering_sluzba`.`kuhinja_spisak_firme` ;
DROP TABLE IF EXISTS `ketering_sluzba`.`kuhinja_spisak_firme`;
USE `ketering_sluzba`;
CREATE  OR REPLACE VIEW `kuhinja_spisak_firme` AS
SELECT n.id_jela, naziv, count(*)
FROM narudzbina n
	JOIN jelo j
		ON n.id_jela = j.id_jela
GROUP BY n.id_jela, naziv;

-- -----------------------------------------------------
-- View `ketering_sluzba`.`sve_ankete`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `ketering_sluzba`.`sve_ankete` ;
DROP TABLE IF EXISTS `ketering_sluzba`.`sve_ankete`;
USE `ketering_sluzba`;
CREATE  OR REPLACE VIEW `sve_ankete` AS
SELECT naziv, datum_pocetak, datum_kraj, COUNT(id_korisnik) as br_korisnika
FROM anketa a 
	JOIN popunili_anketu pa 
		ON a.id_anketa = pa.id_anketa
GROUP BY a.id_anketa, naziv, datum_pocetak, datum_kraj;

-- -----------------------------------------------------
-- View `ketering_sluzba`.`komentari_jela`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `ketering_sluzba`.`komentari_jela` ;
DROP TABLE IF EXISTS `ketering_sluzba`.`komentari_jela`;
USE `ketering_sluzba`;
CREATE  OR REPLACE VIEW `komentari_jela` AS
SELECT naziv, komentar, ime, prezime
FROM ocena_jela o 
	JOIN jelo j 
		ON o.id_jela = j.id_jela
	JOIN korisnik k 
		ON o.id_korisnik = k.id_korisnik
WHERE komentar IS NOT NULL;

-- -----------------------------------------------------
-- View `ketering_sluzba`.`ocene_jela`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `ketering_sluzba`.`ocene_jela` ;
DROP TABLE IF EXISTS `ketering_sluzba`.`ocene_jela`;
USE `ketering_sluzba`;
CREATE  OR REPLACE VIEW `ocene_jela` AS
SELECT naziv, ocena, ime, prezime
FROM ocena_jela o 
	JOIN jelo j 
		ON o.id_jela = j.id_jela
	JOIN Korisnik k 
		ON o.id_korisnik = k.id_korisnik;

-- -----------------------------------------------------
-- View `ketering_sluzba`.`prosecne_ocene_jela`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `ketering_sluzba`.`prosecne_ocene_jela` ;
DROP TABLE IF EXISTS `ketering_sluzba`.`prosecne_ocene_jela`;
USE `ketering_sluzba`;
CREATE  OR REPLACE VIEW `prosecne_ocene_jela` AS
SELECT naziv, AVG(ocena)
FROM ocena_jela o 
	JOIN jelo j 
		ON o.id_jela = j.id_jela
GROUP BY j.id_jela, naziv;

-- -----------------------------------------------------
-- View `ketering_sluzba`.`firme_neizmirene_obaveze`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `ketering_sluzba`.`firme_neizmirene_obaveze` ;
DROP TABLE IF EXISTS `ketering_sluzba`.`firme_neizmirene_obaveze`;
USE `ketering_sluzba`;
CREATE  OR REPLACE VIEW `firme_neizmirene_obaveze` AS
SELECT f.naziv, f.adresa, f.telefon, uf.mesec, uf.godina, uf.iznos
FROM uplata_firme uf
	JOIN firma f
		ON uf.id_firme = f.id_firme
WHERE uplaceno = false;
USE `ketering_sluzba`;

DELIMITER $$

USE `ketering_sluzba`$$
DROP TRIGGER IF EXISTS `ketering_sluzba`.`Narudzbina_AFTER_INSERT` $$
USE `ketering_sluzba`$$
CREATE DEFINER = CURRENT_USER TRIGGER `ketering_sluzba`.`Narudzbina_AFTER_INSERT` AFTER INSERT ON `Narudzbina` FOR EACH ROW
BEGIN
	DECLARE id int;
    DECLARE suma int;
    SET id = (select id_korisnik 
			  from uplata_korisnika 
              where uplaceno = false and id_korisnik = NEW.id_korisnik
				and datum = NEW.datum);
    SET suma = (select sum(cena * kolicina) 
					from narudzbina n
						join jelo j
							on n.id_jela = j.id_jela
					where n.datum = NEW.datum and n.id_korisnik = NEW.id_korisnik);
    IF id IS NULL THEN
		set foreign_key_checks = 0;
		INSERT INTO `ketering_sluzba`.`uplata_korisnika`
		(`id_korisnik`, `datum`, `uplata_do`, `iznos`, `uplaceno`, `datum_uplate`)
		VALUES
		(NEW.id_korisnik, NEW.datum, NEW.datum + INTERVAL (select vreme_placanja from podesavanja_sistema) DAY, suma, false, null);
	ELSE 
		UPDATE `ketering_sluzba`.`uplata_korisnika`
		SET iznos = suma
        WHERE uplaceno = false and id_korisnik = NEW.id_korisnik and datum = NEW.datum;
	END IF;
END$$


USE `ketering_sluzba`$$
DROP TRIGGER IF EXISTS `ketering_sluzba`.`Narudzbina_AFTER_UPDATE` $$
USE `ketering_sluzba`$$
CREATE DEFINER = CURRENT_USER TRIGGER `ketering_sluzba`.`Narudzbina_AFTER_UPDATE` AFTER UPDATE ON `Narudzbina` FOR EACH ROW
BEGIN
    DECLARE suma int;
    SET suma = (select sum(cena * kolicina) 
					from narudzbina n
						join jelo j
							on n.id_jela = j.id_jela
					where n.datum = NEW.datum and n.id_korisnik = NEW.id_korisnik);
	UPDATE `ketering_sluzba`.`uplata_korisnika`
	SET iznos = suma
	WHERE uplaceno = false and id_korisnik = NEW.id_korisnik and datum = NEW.datum;
END$$


USE `ketering_sluzba`$$
DROP TRIGGER IF EXISTS `ketering_sluzba`.`Narudzbina_AFTER_DELETE` $$
USE `ketering_sluzba`$$
CREATE DEFINER = CURRENT_USER TRIGGER `ketering_sluzba`.`Narudzbina_AFTER_DELETE` AFTER DELETE ON `Narudzbina` FOR EACH ROW
BEGIN
	DECLARE suma int;
    SET suma = (select sum(cena * kolicina) 
					from narudzbina n
						join jelo j
							on n.id_jela = j.id_jela
					where n.datum = OLD.datum and n.id_korisnik = OLD.id_korisnik);
	IF suma IS NULL THEN
		DELETE FROM `ketering_sluzba`.`uplata_korisnika`
        WHERE id_korisnik = OLD.id_korisnik;
    ELSE
		UPDATE `ketering_sluzba`.`uplata_korisnika`
		SET iznos = suma
		WHERE uplaceno = false and id_korisnik = OLD.id_korisnik and datum = OLD.datum;
	END IF;
END$$


USE `ketering_sluzba`$$
DROP TRIGGER IF EXISTS `ketering_sluzba`.`Popunili_anketu_AFTER_INSERT` $$
USE `ketering_sluzba`$$
CREATE DEFINER = CURRENT_USER TRIGGER `ketering_sluzba`.`Popunili_anketu_AFTER_INSERT` AFTER INSERT ON `Popunili_anketu` FOR EACH ROW
BEGIN
    UPDATE `ketering_sluzba`.`anketno_pitanje`
    SET rezultati = (SELECT sum(pa.odgovor)
					 FROM popunili_anketu pa
                     WHERE pa.id_pitanja = NEW.id_pitanja and pa.id_anketa = NEW.id_anketa
                     GROUP BY id_pitanja, id_anketa) 
                     / 
                     (SELECT count(*)
					  FROM popunili_anketu pa
					  WHERE pa.id_pitanja = NEW.id_pitanja and pa.id_anketa = NEW.id_anketa
					  GROUP BY id_pitanja, id_anketa)
    WHERE id_pitanja = NEW.id_pitanja and id_anketa = NEW.id_anketa;
END$$


DELIMITER ;
SET SQL_MODE = '';
GRANT USAGE ON *.* TO Administrator;
 DROP USER Administrator;
SET SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';
CREATE USER 'Administrator' IDENTIFIED BY 'administrator';

GRANT ALL ON `ketering_sluzba`.* TO 'Administrator';
SET SQL_MODE = '';
GRANT USAGE ON *.* TO Menadzer;
 DROP USER Menadzer;
SET SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';
CREATE USER 'Menadzer' IDENTIFIED BY 'menadzer';

GRANT UPDATE, SELECT, INSERT, DELETE ON TABLE `ketering_sluzba`.`jelo` TO 'Menadzer';
GRANT UPDATE, SELECT, INSERT, DELETE ON TABLE `ketering_sluzba`.`meni` TO 'Menadzer';
GRANT UPDATE, SELECT, INSERT, DELETE ON TABLE `ketering_sluzba`.`anketa` TO 'Menadzer';
GRANT UPDATE, SELECT, DELETE, INSERT ON TABLE `ketering_sluzba`.`anketno_pitanje` TO 'Menadzer';
GRANT SELECT ON TABLE `ketering_sluzba`.`ocene_jela` TO 'Menadzer';
SET SQL_MODE = '';
GRANT USAGE ON *.* TO Korisnik;
 DROP USER Korisnik;
SET SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';
CREATE USER 'Korisnik' IDENTIFIED BY 'korisnik';

GRANT UPDATE, SELECT, INSERT, DELETE ON TABLE `ketering_sluzba`.`narudzbina` TO 'Korisnik';
GRANT INSERT ON TABLE `ketering_sluzba`.`ocena_jela` TO 'Korisnik';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
