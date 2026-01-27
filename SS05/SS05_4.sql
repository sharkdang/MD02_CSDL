create database ss05;

use ss05;

-- Bài4

create table customers(
	customer_id int primary key,
    customer_name varchar(100) 
);
create table orders(
	order_id int primary key,
    order_date date,
    customer_id int
);
create table order_items(
	order_id int ,
    customer_id int,
    product_name varchar(100) ,
    quantity int ,
    price int
);
INSERT INTO customers(customer_id,customer_name)
VALUES
('1','Lê Thị Nga'),
('2','Lê Thị Trang'),
('3','Nguyễn Thị Thu'),
('4','Lê Thị Thảo');


INSERT INTO orders(order_id,order_date,customer_id)
VALUES
('100','2020-03-01','1'),
('101','2021-03-01','3'),
('102','2023-03-01','1'),
('103','2024-03-01','2');
INSERT INTO order_items (order_id,customer_id,product_name,quantity,price)
VALUES 
-- ĐƠn 100
('100','1','Sách','4','1200000'),
('100','1','cốc','1','800000'),
-- Đơn 101
('101','3','tai nghe','1','500000'),
('101','3','cốc','1','80000'),
 -- Đơn 102 
('102','4','BÚt','3','5000000'),
('102','4','Điện thoại','2','700000'),
-- Đơn 103
('103','2','Vở','7','1100000'),
('103','2','iphone','7','1100000');

-- Hiển thị: mã đơn hàng ngày đặt hàng tên khách hàng

SELECT 
    o.order_id,
    o.order_date,
    c.customer_name
FROM Orders o
INNER JOIN  Customers c
ON o.customer_id = c.customer_id;

-- Hiển thị: danh sách sản phẩm trong mỗi đơn hàng
SELECT
    o.order_id,
    oi.product_name,
    oi.quantity,
    oi.price
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
ORDER BY o.order_id;

-- Tính: tổng tiền của mỗi đơn hàng
SELECT
    o.order_id,
    SUM(oi.quantity * oi.price) AS total_amount
FROM Orders o
JOIN Order_items oi
ON o.order_id = oi.order_id
GROUP BY o.order_id;

-- Hiển thị: các đơn hàng có tổng tiền lớn hơn 10.000.000
SELECT
    o.order_id,
    o.order_date,
    c.customer_name,
    SUM(oi.quantity * oi.price) AS total_amount
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN Order_items oi ON o.order_id = oi.order_id
GROUP BY o.order_id, o.order_date, c.customer_name
HAVING total_amount > 10000000;

