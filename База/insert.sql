use ketering_sluzba;

INSERT INTO `ketering_sluzba`.`podesavanja_sistema`
(`vreme_narucivanja`, `vreme_placanja`, `vreme_placanja_firme`, `period_cuvanja_narudzbina`, `period_cuvanja_menija`, `period_cuvanja_uplata`)
VALUES
(5, 3, 10, 100, 100, 100);

INSERT INTO `ketering_sluzba`.`korisnik`
(`ime`, `prezime`, `jmbg`, `email`, `lozinka`, `aktivan`)
VALUES
('Pera', 'Peric', 1234567890123, 'pera@gmail.com', 'pera', true),
('Milos', 'Nikolic', 2345678901234, 'milos@gmail.com', 'milos', true),
('Stefan', 'Ilic', 3456789012345, 'stefan@gmail.com', 'stefan', true),
('Dragan', 'Dragic', 4567890123456, 'dragan@gmail.com', 'dragan', true),
('Marija', 'Marinkovic', 5678901234567, 'marija@gmail.com', 'marija', true),
('Ivana', 'Ivanovic', 6789012345678, 'ivana@gmail.com', 'ivana', true),
('Marko', 'Markovic', 7890123456789, 'marko@gmail.com', 'marko', true),
('Dusan', 'Savic', 8901234567890, 'dusan@gmail.com', 'dusan', true),
('Goran', 'Jovanovic', 9012345678901, 'goran@gmail.com', 'goran', true),
('Nikola', 'Milosevic', 0123456789012, 'nikola@gmail.com', 'nikola', true);

INSERT INTO `ketering_sluzba`.`pojedinacni_korisnik`
(`id_korisnik`, `telefon`, `adresa`)
VALUES
(1, 011123456, 'Ulica 1'),
(2, 011234567, 'Ulica 5'),
(3, 011345678, 'Ulica 10'),
(4, 011456789, 'Ulica 15'),
(5, 011567890, 'Ulica 20');

INSERT INTO `ketering_sluzba`.`firma`
(`naziv`, `adresa`, `telefon`, `popust`, `ugovor_istice`)
VALUES
('MTS',  'Ulica 25', 011321654,  5, '2016-04-01'),
('Vip',  'Ulica 30', 011432765,  10, '2016-09-01');

INSERT INTO `ketering_sluzba`.`korisnik_firme`
(`id_korisnik`, `id_firme`)
VALUES
(6, 1),
(7, 1),
(8, 2),
(9, 2),	
(10, 2);

INSERT INTO `ketering_sluzba`.`zaposleni`
(`id_zaposleni`, `pozicija`, `ime`, `prezime`, `jmbg`, `email`, `lozinka`, `aktivan`)
VALUES
(1, 'Admin', 'Zoran', 'Zoric', 9876543210987, 'zoran@gmail.com', 'zoran', true),
(2, 'Menadzer', 'Filip', 'Filipovic', 8765432109876, 'filip@gmail.com', 'filip', true),
(3, 'Menadzer', 'Svetlana', 'Svetic', 7654321098765, 'svetlana@gmail.com', 'svetlana', true);

INSERT INTO `ketering_sluzba`.`jelo`
(`id_jela`, `naziv`, `opis`, `tip_jela`, `cena`)
VALUES
(1, 'Prsuta', 'Prsuta isecena na listove', 'predjelo', 150),
(2, 'Sremski sir', 'Sremski sir u maslinovom ulju', 'predjelo', 120),
(3, 'Kupus salata', 'Sitno iseckan kupus', 'salata', 100),
(4, 'Zelena salata', 'Zelena salata sa dresingom', 'salata', 90),
(5, 'Pileca supa', 'Pileca supa sa koskom', 'supa', 170),
(6, 'Govedja supa', 'Govedja supa sa rinflajsom', 'supa', 180),
(7, 'Sarma', 'Domaca sarma', 'glavno jelo', 400),
(8, 'Karadjordjeva snicla', 'Tradicionalna karadjordjena snicla sa tartar sosom', 'glavno jelo', 500),
(9, 'Baklave', 'Baklave na orijentalni nacin', 'desert', 250),
(10, 'Palacinke', 'Palacinke sa orasima i cokoladom', 'desert', 220);

INSERT INTO `ketering_sluzba`.`meni`
(`id_jela`, `datum`)
VALUES
(1, '2016-05-01'),
(3, '2016-05-01'),
(5, '2016-05-01'),
(7, '2016-05-01'),
(9, '2016-05-01');

INSERT INTO `ketering_sluzba`.`ocena_jela`
(`id_korisnik`, `id_jela`, `ocena`, `komentar`)
VALUES
(1, 1, 5, 'Jelo je bilo odlicno'),
(2, 1, 3, 'Jelo je bilo osrednje, slabo peceno'),
(1, 2, 5, 'Jelo je bilo savrseno'),
(3, 7, 4, 'Jelo je bilo prilicno dobro'),
(4, 9, 2, 'Jelo nije bilo dovoljno zacinjeno');

INSERT INTO `ketering_sluzba`.`narudzbina`
(`id_jela`, `id_korisnik`, `datum`, `kolicina`)
VALUES
(2, 1, '2016-08-11', 1),
(4, 1, '2016-08-11', 1),
(5, 1, '2016-08-11', 3),
(8, 6, '2016-10-30', 1),
(9, 6, '2016-10-30', 2),
(8, 9, '2016-10-11', 1),
(9, 10, '2016-10-11', 1);

INSERT INTO `ketering_sluzba`.`specijalna_narudzbina`
(`id_narudzbine`, `id_korisnik`, `datum`, `opis_narudzbine`)
VALUES
(1, 1, '2016-08-11', 'Zelim pljeskavicu');

INSERT INTO `ketering_sluzba`.`anketa`
(`naziv`, `datum_pocetak`, `datum_kraj`)
VALUES
('Anketa - Izbor jela', '2016-01-01', '2016-12-01'),
('Anketa - Dostava', '2016-03-01', '2016-09-01');

INSERT INTO `ketering_sluzba`.`anketno_pitanje`
(`id_pitanja`, `id_anketa`, `tekst`, `rezultati`)
VALUES
(1, 1, 'Koliko ste zadovoljni izborom predjela?', 0),
(2, 1, 'Koliko ste zadovoljni izborom salata?', 0),
(3, 1, 'Koliko ste zadovoljni izborom supa?', 0),
(4, 1, 'Koliko ste zadovoljni izborom glavnih jela?', 0),
(5, 1, 'Koliko ste zadovoljni izborom deserta?', 0),
(6, 2, 'Koliko ste zadovoljni rokom isporuke?', 0),
(7, 2, 'Koliko ste zadovoljni brzinom dostave?', 0),
(8, 2, 'Koliko ste zadovoljni stanjem isporucene robe?', 0);

INSERT INTO `ketering_sluzba`.`popunili_anketu`
(`id_anketa`, `id_korisnik`, `id_pitanja`, `odgovor`)
VALUES
(1, 5, 1, 3),
(1, 3, 1, 5),
(2, 8, 8, 4);
