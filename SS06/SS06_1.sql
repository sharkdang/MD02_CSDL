create database ss06;

use ss06;
-- Bài1

create table products(
	product_id int primary key,
    product_name varchar (255) ,
    price double ,
    category_id int
);
create table categories(
	category_id int primary key,
    category_name varchar (255)
);
INSERT INTO products(product_id,product_name,price,category_id)
VALUES
('1','iphone','20000000','100'),
('2','dell','15000000','101'),
('3','hp','9000000','101'),
('4','sam sung','1000000','100'),
('5','watch seri 3','800000','102'),
('6','orient','1400000','102'),
('7','nokia','5000000','100');

INSERT INTO categories(category_id,category_name)
VALUES 
('100','phone'),
('101','laptop'),
('102','watch');

-- Thêm 3 sản phẩm mới vào bảng products
INSERT INTO products(product_id,product_name,price,category_id)
VALUES
('8','legion','11000000','101'),
('9','casio','300000','102'),
('10','biphone','5000000','100');
-- Cập nhật giá của một sản phẩm đã có
UPDATE products  SET price='15000000' WHERE product_id='4';

SELECT*FROM products;
-- Xóa một sản phẩm
DELETE FROM products WHERE product_id='5';

SELECT*FROM products;
-- Hiển thị tất cả sản phẩm, sắp xếp theo giá
SELECT product_name,price
FROM products 
ORDER BY price
 ASC;
-- Thống kê số lượng sản phẩm cho từng danh mục
SELECT 
c.category_id,
c.category_name,
 COUNT(p.product_id) AS total_products
FROM categories c
LEFT JOIN products p
ON c.category_id = p.category_id
GROUP BY 
c.category_id, c.category_name;





