CREATE TABLE employees (
	emp_id INT PRIMARY KEY,
    full_name VARCHAR(100),
    salary DECIMAL(10,2)
);
INSERT INTO employees (emp_id,full_name,salary) 
VALUES (1,'Đỗ Văn An',10000000),
(2,'Phạm Phương',5000000),
(3,'Hoa Hồng',16000000),
(4,'Mai Linh',4000000),
(5,'Ánh',8000000),
(6,'Linh Phạm',10000000);

DELIMITER //

CREATE PROCEDURE sp_get_avg_salary()
BEGIN 
	-- khai báo biến
	DECLARE avg_salary DECIMAL (10,2);
    -- Gán gtri cho biến
    SElECT AVG(salary) INTO avg_salary
    FROM employees ;
    -- Hiển thị gtrị biến ra màn hình
    SELECT avg_salary AS avg_salary;
END //
DELIMITER ;

CALl sp_get_avg_salary();