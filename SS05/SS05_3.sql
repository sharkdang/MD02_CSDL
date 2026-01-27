use ss05;
-- Bài3
create table products (
	product_id int primary key,
    product_name varchar(150) ,
    category varchar(100) ,
    price int
);

INSERT INTO products (product_id,product_name, category, price)
 VALUES
('1','Laptop Dell', 'Laptop', '12000000'),
('2','Laptop Asus', 'Laptop', '15000000'),
('3','iPhone 13', 'Phone', '24000000'),
('4','Samsung Galaxy Tab', 'Tablet', '9000000'),
('5','Samsung Galaxy S21', 'Phone', '14000000');
SELECT * FROM products;
-- Hiển thị các sản phẩm có: giá cao hơn giá trung bình của tất cả sản phẩm
SELECT * 
FROM
products
WHERE price >(
	SELECT AVG(price)
    FROM products
);
-- Hiển thị sản phẩm có: giá cao nhất trong từng loại sản phẩm
-- SELECT *
-- FROM products
-- WHERE MAX(price)=(
-- SELECT *
-- FROM products
-- GROUP BY category 
-- );

-- Hiển thị các sản phẩm thuộc loại: có ít nhất một sản phẩm giá trên 20.000.000
SELECT *
FROM products 
WHERE category IN (
	SELECT category
    FROM products 
    WHERE price > 20000000
);
SELECT * FROM products;
