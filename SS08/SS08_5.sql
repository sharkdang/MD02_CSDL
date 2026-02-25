CREATE TABLE emp (
	emp_id INT PRIMARY KEY,
    full_name VARCHAR(100),
    salary DECIMAL(10,2),
    deparment VARCHAR(255)
);
INSERT INTO emp(emp_id,full_name,salary,deparment) 
VALUES (1,'AN',5000000,'HR'),
(2,'ANH',6000000,'IT'),
(3,'Thu',8000000,'HR'),
(4,'HOa',3000000,'Bảo vệ'),
(5,'Dương',9000000,'HR'),
(6,'Tú',5000000,'Bảo vệ'),
(7,'AN',15000000,'IT');
SELECT *FROM emp;

DELIMITER //
CREATE PROCEDURE sp_check_emp_income(
IN p_name VARCHAR(255),
IN p_salary DECIMAL(10,2)
)
BEGIN 
	DECLARE income_level VARCHAR(50);
    IF p_salary >=15000000 THEN 
    SET income_level ='Thu nhập cao';
    ELSEIF p_salary >=8000000 THEN
    SET income_level ='Thu nhập trung bình';
    ELSE
    SET income_level ='Thu nhập thấp';
    END IF ;
    SELECT p_name AS emp__name,
    income_level AS income_type;
END //
DELIMITER ;

CALL sp_check_emp_income('Dương',10000000);