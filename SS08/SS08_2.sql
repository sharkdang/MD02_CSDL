use ss08;
CREATE TABLE products(
	product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL (10,2),
    category VARCHAR(100)
);
INSERT INTO products (product_id,product_name,price,category)
VALUE (1,'Laptop DELL',12000000,'LapTop'),
(2,'Laptop ASUS',20000000,'LapTop'),
(3,'Iphone 13 promax',19000000,'Phone'),
(4,'Samsung',10000000,'Phone')
;

DELIMITER //
CREATE PROCEDURE sp_get_products_by_category (
IN p_category VARCHAR(100))   -- p_category là tham số đầu vào 
BEGIN 
SELECT * FROM products 
WHERE category = p_category;
END //
DELIMITER ;

CALL sp_get_products_by_category('LapTop');