CREATE TABLE students (
    student_id INT PRIMARY KEY,
    full_name VARCHAR(100),
    average_score DECIMAL(3,1)
);
INSERT INTO students (student_id, full_name, average_score)
 VALUES
(1, 'Nguyễn ANh', 8.5),
(2, 'Trần Nguyễn', 7.2),
(3, 'Lê Thị Hà', 6.0),
(4, 'Pham Dung', 4.8),
(5, 'Đỗ Tú', 9.1);

DELIMITER //
CREATE PROCEDURE sp_classify_student(
IN p_avg_score DECIMAL(3,1),
OUT p_classify VARCHAR(100)
)
BEGIN
	-- Khai báo biến trung gian
	DECLARE result VARCHAR(100);
    SET result = 
    CASE 
		WHEN p_avg_score >=8.0 THEN 'Giỏi'
        WHEN p_avg_score >=6.5 THEN 'Khá'
        WHEN p_avg_score >=5.0 THEN 'Trung Bình'
        ELSE 'Yếu'
        END;
        -- Gán kq cho tham số out
        SET p_classify = result;
END //
DELIMITER ;
CALL sp_classify_student(6.0,@result);
SELECT @result;