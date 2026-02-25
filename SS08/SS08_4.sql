
CREATE TABLE orders(
	order_id INT PRIMARY KEY,
    total DECIMAL(10,2)
);

INSERT INTO orders (order_id,total )
 VALUES (11,20000000),
 (12,12000000),
 (13,23000000),
 (14,2100000),
 (15,12000000),
 (16,18000000);
 
 DELIMITER //
 CREATE PROCEDURE sp_check_order_value (
 IN p_total_amount DECIMAL (10,2)
 )
 BEGIN
	IF p_total_amount >=15000000 THEN
    SELECT 'Đơn hàng giá trị cao ' AS Message;
    ELSE 
    SELECT 'Đơn hàng bình thường ' AS Message;
    END IF;
 END//
 DELIMITER ;
 
 CALL sp_check_order_value(20000000);