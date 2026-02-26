CREATE DATABASE SS09;
use ss09;

CREATE TABLE customers(
	customer_id INT auto_increment primary key,
    customer_name varchar(50) not null,
    email varchar(100) not null,
    phone varchar(15) not null,
    address varchar(255) not null
);
INSERT INTO customers(customer_name,email,phone,address) 
VALUES 
('Alice','alice@gmail.com','0900000001','HN'),
('Bob','bob@gmail.com','0900000002','HP'),
('Carol','carol@gmail.com','0900000003','DN'),
('David','david@gmail.com','0900000004','HCM'),
('Eva','eva@gmail.com','0900000005','CT'),
('Frank','frank@gmail.com','0900000006','HN'),
('Grace','grace@gmail.com','0900000007','HP'),
('Hannah','hannah@gmail.com','0900000008','DN'),
('Ivan','ivan@gmail.com','0900000009','HCM'),
('Jack','jack@gmail.com','0900000010','CT');
-- Kiểm tra chỉ mục
EXPLAIN SELECT * FROM customers WHERE email = 'a@gmail.com';
EXPLAIN SELECT * FROM customers WHERE phone = '0901234567';
-- Tạo unique index cho cột email 
CREATE UNIQUE INDEX idx_email ON customers(email);
-- Tạo Non-unique index cho cột phone
CREATE INDEX idx_phone ON customers(phone);