create database ss10;

use ss10;
-- Bài1
create table products(
	product_id int auto_increment primary key,
    product_name varchar(255) not null,
    quantity int  not null
);
create table inventoryChanges(
	change_id int auto_increment primary key,
    product_id int not null,
    oldQuantity int not null,
    newQuantity int not null,
    changeDate datetime default current_timestamp,
    
    foreign key (product_id)references products(product_id)
);
-- Tạo trigger 
DELIMITER //

CREATE TRIGGER AfterProductUpdate
AFTER UPDATE ON Products
FOR EACH ROW
BEGIN
    -- Ghi lại thông tin thay đổi vào bảng InventoryChanges
    INSERT INTO InventoryChanges (product_id, oldQuantity, newQuantity)
    VALUES (NEW.product_id, OLD.quantity, NEW.quantity);
END //

DELIMITER ;

-- Thêm dữ liệu vào bảng products
INSERT INTO products(product_id,product_name,quantity) VALUES 
('1','product A',100),
('2','product B',300),
('3','product C',200),
('4','product D',50),
('5','product E',100);

-- Cập nhật số lượng cho products 
UPDATE products SET quantity = 150 WHERE product_id = '1';
-- Cập nhật số lượng cảu product B
UPDATE products SET quantity = 200 WHERE product_id = '2';

SELECT*FROM inventorychanges;

-- Bài2 

INSERT INTO products(product_name,quantity) VALUES 
('Iphone 15', 5),
('Iphone 16', 15),
('Iphone 17', 8),
('Iphone 18', 12);

DELIMITER //
CREATE TRIGGER BeforeProductDelete
BEFORE DELETE ON products
FOR EACH ROW
BEGIN
	-- Kiểm tra số lượng sản phẩm
    IF OLD.quantity >10 THEN
    signal sqlstate '45000'
    SET message_text ='Không thể xóa sản phẩm có số lượng lớn hơn 10.';
    END IF;
END //
DELIMITER ;

DELETE FROM products WHERE product_name='Iphone 15'; -- Thành công

DELETE FROM Products WHERE name = 'Iphone 16';  -- Sẽ bị lỗi

-- Bài3 

DELIMITER //
CREATE trigger BeforeInsertProduct
before insert on products
for each row
BEGIN
	if new.quantity <0
    then signal sqlstate '45000'
    set message_text ='Không thể thêm mới';
    end if;
END//
DELIMITER ;

insert into products (product_name,quantity) VALUES
('iphone 20',-10) ;
-- Bài4

create table employees (
	id int auto_increment primary key ,
    first_name varchar(50),
    last_name varchar(50),
    salary decimal(10,2),
    email varchar(100) unique,
    phone_number varchar(15)
);
create table salary_log (
	log_id int auto_increment primary key,
    employee_id int ,
    old_salary decimal(10,2),
    new_salary decimal(10,2),
    change_date datetime default current_timestamp,
    foreign key (employee_id) references employees(id)
);
INSERT INTO employees (first_name, last_name, salary, email, phone_number) VALUES
('Alice', 'Smith', 5000.00, 'alice@example.com', '1234567890'),
('Bob', 'Johnson', 6000.00, 'bob@example.com', '1234567891'),
('Charlie', 'Williams', 5500.00, 'charlie@example.com', '1234567892'),
('Diana', 'Brown', 4500.00, 'diana@example.com', '1234567893'),
('Edward', 'Jones', 7000.00, 'edward@example.com', '1234567894'),
('Fiona', 'Garcia', 4800.00, 'fiona@example.com', '1234567895'),
('George', 'Martinez', 5200.00, 'george@example.com', '1234567896'),
('Hannah', 'Davis', 6000.00, 'hannah@example.com', '1234567897'),
('Ian', 'Miller', 5800.00, 'ian@example.com', '1234567898'),
('Jane', 'Wilson', 7500.00, 'jane@example.com', '1234567899');

-- Tạo trigger 
DELIMITER //
CREATE TRIGGER trg_after_update_salary 
	AFTER UPDATE ON employees
    FOR EACH ROW 
BEGIN	
	-- Ghi lại thông tin thay đổi 
    INSERT INTO salary_log(employee_id,old_salary,new_salary)
    VALUES (OLD.id,OLD.salary,NEW.salary);
END //
DELIMITER ;
DROP TRIGGER IF EXISTS trg_after_update_salary;
-- kiểm tra trigger
update employees SET salary = 60000.00 WHERE id=1;
update employees SET salary = 100000.00 WHERE id=4;

SELECT * FROM salary_log;

-- Bài5 
create table orders (
	id int primary key auto_increment,
    customer_name varchar(100),
    total_amount decimal(10,2),
    order_date datetime default current_timestamp,
    status varchar(50)
);
drop table orders;
drop table order_logs;
create table order_logs (
	log_id int primary key auto_increment,
    order_id int ,
    old_status varchar(50),
    new_status varchar(50),
    log_date timestamp default current_timestamp,
    foreign key (order_id) references orders(id)
);

DELIMITER //
CREATE TRIGGER after_order_status_update 
	AFTER UPDATE ON orders
	FOR EACH ROW
BEGIN
	-- CHỉ log khi status thay đổi
	if OLD.status <> NEW.status THEN
		INSERT INTO order_logs(order_id,old_status,new_status )
        VALUES (OLD.id,OLD.status,NEW.status);
        END IF;
END //
DELIMITER ;

INSERT INTO orders (customer_name, total_amount, status)
VALUES ('Lq Đăng', 500000, 'Pending');

-- Đổi trạng thái
UPDATE orders
SET status = 'Shipping'
WHERE id = 1;
-- Sửa lên khách hàng 
UPDATE orders
SET customer_name = 'Lê Quang Đăng'
WHERE id = 1; 
SELECT * FROM order_logs;

-- Bài6
CREATE TABLE cart_items (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
DELIMITER //
CREATE TRIGGER before_cart_add
BEFORE INSERT ON cart_items
FOR EACH ROW
BEGIN
	declare stock_quantity int;
    
    -- Lấy số lượng tồn kho của sản phẩm
    SELECT quantity INTO stock_quantity
    FROM products
    WHERE product_id = NEW.product_id;
    
    -- KIểm tra nếu số lượng mua lớn hơn tồn kho
    IF NEW.quantity > stock_quantity THEN
		signal sqlstate '45000'
        SET message_text = 'Số lượng hàng không đủ';
        END iF;
END //
DELIMITER ;

INSERT INTO products(product_name,quantity)
VALUES ('Iphone 15',5); 
INSERT INTO cart_items (product_id, quantity)
VALUES (1, 2);

INSERT INTO cart_items (product_id, quantity)
VALUES (1, 10);
SELECT * FROM products WHERE product_id = 1;
INSERT INTO cart_items (product_id, quantity)
VALUES (1, 40);
SELECT * FROM cart_items;