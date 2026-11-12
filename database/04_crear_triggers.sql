USE fitsyncmanager;

DELIMITER //

CREATE TRIGGER trg_socio_edad_insert
BEFORE INSERT ON SOCIO
FOR EACH ROW
BEGIN
    IF NEW.fecha_nacimiento > CURDATE() - INTERVAL 16 YEAR
       OR NEW.fecha_nacimiento IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Edad minima: 16 años';
    END IF;
END//

CREATE TRIGGER trg_socio_edad_update
BEFORE UPDATE ON SOCIO
FOR EACH ROW
BEGIN
    IF NEW.fecha_nacimiento > CURDATE() - INTERVAL 16 YEAR
       OR NEW.fecha_nacimiento IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Edad minima: 16 años';
    END IF;
END//

DELIMITER ;