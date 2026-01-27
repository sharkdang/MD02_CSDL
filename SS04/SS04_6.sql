
use ss04;
-- Bai6
CREATE TABLE products (
    product_id INT  PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price INT NOT NULL,
    quantity INT NOT NULL
);
INSERT INTO products (product_id,product_name, category, price, quantity)
 VALUES
('1','Laptop Dell', 'Laptop', '12000000', '10'),
('2','Laptop Asus', 'Laptop', '15000000', '5'),
('3','iPhone 13', 'Phone', '18000000','8'),
('4','Samsung Galaxy Tab', 'Tablet', '9000000', '3'),
('5','Samsung Galaxy S21', 'Phone', '14000000', '0');
-- Hiển thị sản phẩm có giá từ 5.000.000 đến 15.000.000
SELECT * 
FROM products
WHERE price BETWEEN 5000000 AND 15000000;

-- Hiển thị sản phẩm thuộc loại Laptop hoặc Tablet
SELECT * 
FROM products
WHERE category IN ('Laptop', 'Tablet');

-- Hiển thị sản phẩm có tên bắt đầu bằng “Sam”
SELECT * 
FROM products
WHERE product_name LIKE 'Sam%';

-- Hiển thị sản phẩm không thuộc loại Phone
SELECT * 
FROM products
WHERE category <> 'Phone';

SELECT * FROM products;
-- Giảm giá 5% cho các sản phẩm thuộc loại Laptop
UPDATE products
SET price = price * 0.95
WHERE category = 'Laptop';
SET SQL_SAFE_UPDATES = 0;
SELECT * FROM products;
-- Xóa các sản phẩm có số lượng tồn kho bằng 0
DELETE FROM products
WHERE quantity = 0;

SELECT * FROM products;