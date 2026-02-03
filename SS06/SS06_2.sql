use ss06;

-- Bài2
create table customers (
	customer_id int primary key,
    customer_name varchar(255),
    email varchar(255)
);
create table orders(
	order_id int primary key,
    customer_id int ,
    order_date date
);
create table order_details (
	order_id int,
    product_id int,
    quantity int,
    price double
);


INSERT INTO orders (order_id, customer_id, order_date)
VALUES
(1, 11, '2024-01-10'),
(2, 11, '2024-01-15'),
(3, 12, '2024-01-20');
INSERT INTO order_details (order_id, product_id, quantity, price)
VALUES
(1, 1, 1, 20000000),   -- iphone
(1, 4, 2, 15000000),   -- sam sung 
(2, 2, 1, 15000000),   -- dell
(3, 3, 2, 9000000),    -- hp
(3, 7, 1, 5000000);    -- nokia
INSERT INTO customers (customer_id, customer_name, email)
VALUES
(13, 'Nguyễn Văn An', 'an@gmail.com'),
(14, 'Trần Thị Hoa', 'hoa@gmail.com'),
(15, 'Phạm Minh Đức', 'duc@gmail.com'),
(16, 'Lê Thu Trang', 'trang@gmail.com');

-- Thêm 2 khách hàng mới vào bảng customers
INSERT INTO customers (customer_id,customer_name,email)
VALUES 
(11,'Lê Văn TÚ','tule@gmail.com'),
(12,'Đỗ Xuân Bách','dobach@gmail.com');
-- Liệt kê những khách hàng đã có ít nhất một đơn hàng
SELECT DISTINCT c.customer_id, c.customer_name, c.email
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id;

-- Tìm những khách hàng chưa từng đặt đơn hàng nào
SELECT c.customer_id, c.customer_name, c.email
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- Tính toán tổng doanh thu mà mỗi khách hàng đã mang lại
SELECT 
    c.customer_id,
    c.customer_name,
    SUM(od.quantity * od.price) AS total_price
FROM customers c
 JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_details od
ON o.order_id = od.order_id
GROUP BY c.customer_id, c.customer_name;

-- Xác định khách hàng đã mua sản phẩm có giá cao nhất
SELECT DISTINCT c.customer_id, c.customer_name
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_details od
ON o.order_id = od.order_id
WHERE od.price = (
    SELECT MAX(price) FROM order_details
);
