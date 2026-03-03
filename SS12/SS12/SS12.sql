create database SS12;
use SS12;
-- BÀi1 

-- 1. Bảng customers (Khách hàng)
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Bảng orders (Đơn hàng)
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2) DEFAULT 0,
    status ENUM('Pending', 'Completed', 'Cancelled') DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);

-- 3. Bảng products (Sản phẩm)
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. Bảng order_items (Chi tiết đơn hàng)
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 5. Bảng inventory (Kho hàng)
CREATE TABLE inventory (
    product_id INT PRIMARY KEY,
    stock_quantity INT NOT NULL CHECK (stock_quantity >= 0),
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);

-- 6. Bảng payments (Thanh toán)
CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10,2) NOT NULL,
    payment_method ENUM('Credit Card', 'PayPal', 'Bank Transfer', 'Cash') NOT NULL,
    status ENUM('Pending', 'Completed', 'Failed') DEFAULT 'Pending',
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE
);


-- Tạo trigger kiểm tra tồn kho và trừ kho 
-- tạo  TRIGGER before insert 
DELIMITER //
CREATE TRIGGER trg_before_insert_order_items
BEFORE INSERT ON order_items
FOR EACH ROW
BEGIN	
		-- Khai báo biến lưu số lượng tồn kho 
		declare stock int;
        
        -- Lấy số lượng tồn kho của sản phẩm 
        SELECT stock_quantity INTO stock
        FROM inventory
        WHERE product_id = NEW.product_id;
        -- Kiểm tra nếu tồn kho nhỏ hơn số lượng đặt 
        IF stock < NEW.quantity THEN 
        SIGNAL sqlstate '45000'
        SET message_text ='Không đủ số lượng tồn kho';
        END IF;
        -- Trừ tồn kho
        UPDATE inventory 
        SET stock_quantity = stock - NEW.quantity
        WHERE product_id = NEW.product_id;
END //
DELIMITER ;


-- Cập nhật tổng tiền đơn 
-- Trigger AFTER INSERT
DELIMITER //
	-- Tạo trigger sau khi insert item 
    CREATE TRIGGER ai_order_items
    AFTER INSERT ON order_items
    FOR EACH ROW
    BEGIN
		-- Cập nhật tổng tiền đơn hàng
        UPDATE orders
        SET total_amount = (
        -- Tính tổng tiền tất cả sản phẩm trong đơn
			SELECT SUM(quantity * price)
			FROM order_items
			WHERE order_id = NEW.order_id
        )
        -- Xác định đúng đơn cần cập nhật
        WHERE order_id = NEW.order_id;
    END //
DELIMITER ;


-- Trigger BEFORE UPDATE: kiểm tra kho khi sửa số lượng
DELIMITER //
CREATE TRIGGER bu_order_items
BEFORE UPDATE ON order_items
FOR EACH ROW
BEGIN 
	-- BIến lưu tồn kho
    declare stock INT;
    -- Biến lưu chênh lệch só lượng
    declare diff INT;
    -- Tính số lượng thay đổi
    SET diff = NEW.quantity - OLD.quantity;
    -- Lấy tồn kho hiện tại
    SELECT stock_quantity INTO stock
    FROM inventory
    WHERE product_id =NEW.product_id;
    -- Nếu số lượng tăng mà kho không đủ
    IF stock <diff THEN
		-- báo lỗi
        signal sqlstate '45000'
        SET message_text= 'Không đủ kho để cập nhật';
      END IF;
      -- Cập nhật tồn kho
      UPDATE inventory
      SET stock_quantity = stock-diff
      WHERE product_id = NEW.product_id;
      
END//
DELIMITER ;

-- Tạo trigger AFTER UPDATE — cập nhật tổng tiền
use ss12;
DELIMITER //
CREATE trigger au_order_items 
AFTER UPDATE ON order_items
FOR EACH ROW
BEGIN
	-- Cập nhật tổng tiền 
    UPDATE orders
    SET total_amount = (
		-- Tính lại tổng tiền
        SELECT SUM(quantity * price)
        FROM order_items
        WHERE order_id = NEW.order_id
    )
    -- Xác định đơn cần cập nhật 
    WHERE order_id = NEW.order_id;
END //
DELIMITER ;


-- Tạo trigger BEFORE DELETE — chặn xoá đơn hoàn thành
DELIMITER //
CREATE trigger bd_orders
before delete ON orders
FOR EACH ROW
BEGIN
	IF OLD.status = 'Completed' THEN
    -- báo lỗi ko cho xóa
    signal sqlstate '45000'
    SET message_text ='Không thể xóa đơn đã thanh toán';
    END if;
END //
DELIMITER ;
-- Tạo trigger AFTER DELETE — hoàn kho khi xoá item
DELIMITER //
CREATE TRIGGER ad_order_items
AFTER DELETE ON order_items
FOR EACH ROW
BEGIN
		-- CỘng lại số lượng vào kho 
        UPDATE inventory
        SET stock_quantity = stock_quantity + OLD.quantity
        WHERE product_id = OLD.product_id;
END //
DELIMITER ;

-- Customers
INSERT INTO customers (name,email,phone,address) VALUES
('Lê Thu Phương','phuong@gmail.com','0901111111','Ha Noi'),
('Lê Tú','tu@gmail.com','0902222222','Da Nang');

-- Products
INSERT INTO products (name,price,description) VALUES
('Laptop',1500,'Gaming laptop'),
('Mouse',20,'Wireless mouse'),
('Keyboard',50,'Mechanical keyboard');

-- Inventory
INSERT INTO inventory VALUES
(1,10,NOW()),
(2,100,NOW()),
(3,50,NOW());

-- Orders
INSERT INTO orders (customer_id,status) VALUES
(1,'Pending'),
(2,'Pending');

-- Kiểm tra tồn kho
INSERT INTO order_items(order_id,product_id,quantity,price)
VALUES(1,1,2,1500);

SELECT*FROM order_items;

-- Test UPDATE số lượng
UPDATE order_items
SET quantity = 5
WHERE order_item_id = 1;