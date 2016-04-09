use ketering_sluzba;

DELIMITER $$
CREATE EVENT `brisanje_event` ON SCHEDULE EVERY 1 DAY STARTS TIMESTAMP(CURRENT_DATE,'02:00:00')  ON COMPLETION PRESERVE ENABLE DO
BEGIN
    DELETE FROM meni 
    WHERE datum < CURRENT_DATE - INTERVAL (SELECT period_cuvanja_menija FROM podesavanja_sistema) DAY;
    
    DELETE FROM narudzbine 
    WHERE datum < CURRENT_DATE - INTERVAL (SELECT period_cuvanja_narudzbina FROM podesavanja_sistema) DAY;
    
	DELETE FROM uplata_korisnika
    WHERE datum < CURRENT_DATE - INTERVAL (SELECT period_cuvanja_uplata FROM podesavanja_sistema) DAY;    
    
	DELETE FROM uplata_firme 
    WHERE datum < CURRENT_DATE - INTERVAL (SELECT period_cuvanja_uplata FROM podesavanja_sistema) DAY;  
END$$
DELIMITER ;