create database ss08;

DELIMITER //
CREATE PROCEDURE sp_get_all_students()
BEGIN
	SELECT * FROM students;
END//
DELIMITER ;

CALL sp_get_all_students();