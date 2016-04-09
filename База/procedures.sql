use ketering_sluzba;

delimiter //
create procedure na_meniju(in datum date)
begin
	select j.*
    from meni m 
		join jelo j 
			on m.id_jela = j.id_jela
    where m.datum = datum;
end //
delimiter ;

delimiter //
create procedure uplate_korisnika(in id_korisnik int)
begin
	select * 
    from uplata_korisnika uk
    where uk.id_korisnik = id_korisnik;
end //
delimiter ;

delimiter //
create procedure uplate_firme(in id_firme int)
begin
	select * 
    from uplata_firme uk
    where uk.id_firme = id_firme;
end //
delimiter ;

delimiter //
create procedure narudzbine_firme(in id_firme int)
begin
	select kf.id_korisnik, k.ime, k.prezime, n.id_jela, n.datum, j.cena
    from firma f
		join korisnik_firme kf
			on f.id_firme = kf.id_firme
		join korisnik k
			on k.id_korisnik = kf.id_korisnik
		join narudzbina n
			on n.id_korisnik = kf.id_korisnik
		join jelo j
			on n.id_jela = j.id_jela;
end //
delimiter ;

delimiter //
create procedure ispostava_racuna(in id_firme int)
begin
	declare suma int;
    declare ukupno float;
	set suma = (
    select sum(j.cena)
    from firma f
		join korisnik_firme kf
			on f.id_firme = kf.id_firme
		join korisnik k
			on k.id_korisnik = kf.id_korisnik
		join narudzbina n
			on n.id_korisnik = kf.id_korisnik
		join jelo j
			on n.id_jela = j.id_jela
	where f.id_firme = id_firme);
	set foreign_key_checks = 0;
    insert into `ketering_sluzba`.`uplata_firme`
	(`id_firme`, `mesec`, `godina`, `iznos`, `uplaceno`, `datum_uplate`) values
	(id_firme, month(current_date()), year(current_date()), suma - suma * (select popust
																		   from firma f
																		   where f.id_firme = id_firme)/ 100.0, false, null);
end //
delimiter ;

delimiter //
create procedure pojedinacni_korisnik(in id_korisnik int)
begin
	select k.id_korisnik, k.ime, k.prezime, k.email, (case when k.aktivan = 1 then 'true' else 'false' end) as aktivan
    from korisnik k
    where k.id_korisnik = id_korisnik;
end //
delimiter ;

delimiter //
create procedure korisnik_firme(in id_firme int)
begin
	select k.id_korisnik, k.ime, k.prezime, kf.oznaka, k.email, (case when k.aktivan = 1 then 'true' else 'false' end) as aktivan
    from firma f
		join korisnik_firme kf
			on f.id_firme = kf.id_firme
		join korisnik k
			on k.id_korisnik = kf.id_korisnik
	where f.id_firme = id_firme;
end //
delimiter ;

delimiter //
create procedure pojedinacno_jelo(in id_jela int)
begin
	select naziv, opis, tip_jela, cena, slika
    from jelo j
    where j.id_jela = id_jela;
end //
delimiter ;

delimiter //
create procedure jela_po_kategoriji(in tip_jela varchar(45))
begin
	select naziv, opis, tip_jela, cena, slika, ocena, komentar
    from jelo j
		join ocena_jela oj
			on j.id_jela = oj.id_jela
    where j.tip_jela = tip_jela;
end //
delimiter ;

delimiter //
create procedure pojedinacna_narudzbina(in id_korisnik int)
begin
	select *
    from narudzbina n
    where n.id_korisnik = id_korisnik
    union all
	select distinct(naziv), tip_jela, cena, n.datum
	from narudzbina n
		join korisnik k
			on n.id_korisnik = k.id_korisnik
		join pojedinacni_korisnik pk
			on k.id_korisnik = pk.id_korisnik
		join specijalna_narudzbina sn
			on pk.id_korisnik = sn.id_korisnik
	where sn.prihvacena = true;
end //
delimiter ;

delimiter //
create procedure rezultati_ankete(in id_anketa int)
begin
	select id_pitanja, tekst, rezultati
    from anketno_pitanje ap
    where ap.id_anketa = id_anketa;
end //
delimiter ;

delimiter //
create procedure spisak_kuhinja_korisnik(in datum date)
begin
	select n.id_korisnik, ime, prezime, n.id_jela, naziv, sum(kolicina) as kolicina
	from narudzbina n
		join jelo j
			on n.id_jela = j.id_jela
		join korisnik k
			on k.id_korisnik = n.id_korisnik
		join pojedinacni_korisnik pk
			on k.id_korisnik = pk.id_korisnik
	where n.datum = datum
	group by id_korisnik, ime, prezime, id_jela, naziv
	union all
	select distinct(n.id_korisnik), ime, prezime, n.id_jela, sn.naziv, 1
	from narudzbina n
		join korisnik k
			on n.id_korisnik = k.id_korisnik
		join pojedinacni_korisnik pk
			on k.id_korisnik = pk.id_korisnik
		join specijalna_narudzbina sn
			on pk.id_korisnik = sn.id_korisnik
	where sn.prihvacena = true and n.datum = datum;
end //
delimiter ;

delimiter //
create procedure spisak_kuhinja_firma(in datum date)
begin
	select n.id_korisnik, n.id_jela, j.naziv, sum(kolicina) as kolicina
	from narudzbina n
		join jelo j
			on n.id_jela = j.id_jela
		join korisnik k
			on k.id_korisnik = n.id_korisnik
		join korisnik_firme kf
			on k.id_korisnik = kf.id_korisnik
		join firma f
			on f.id_firme = kf.id_firme
	where n.datum = datum
	group by n.id_korisnik, n.id_jela, naziv;
end //
delimiter ;

delimiter //
create procedure spisak_dostava_korisnici(in datum date)
begin
	select n.id_korisnik, n.id_jela, ime, prezime, pk.adresa, pk.telefon
	from narudzbina n
		join jelo j
			on n.id_jela = j.id_jela
		join korisnik k
			on k.id_korisnik = n.id_korisnik
		join pojedinacni_korisnik pk
			on pk.id_korisnik = k.id_korisnik
	where n.datum = datum
	union all
	select distinct(n.id_korisnik), 0, ime, prezime, pk.adresa, pk.telefon
	from narudzbina n
		join korisnik k
			on n.id_korisnik = k.id_korisnik
		join pojedinacni_korisnik pk
			on k.id_korisnik = pk.id_korisnik
		join specijalna_narudzbina sn
			on pk.id_korisnik = sn.id_korisnik
	where sn.prihvacena = true and sn.datum = datum;
end //
delimiter ;

delimiter //
create procedure spisak_dostava_firme(in datum date)
begin
	select kf.oznaka, n.id_jela
	from narudzbina n
		join jelo j
			on n.id_jela = j.id_jela
		join korisnik k
			on k.id_korisnik = n.id_korisnik
		join korisnik_firme kf
			on kf.id_korisnik = k.id_korisnik
		join firma f
			on f.id_firme = kf.id_firme
	where n.datum = datum;
end //
delimiter ;
