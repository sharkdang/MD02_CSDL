create database ss11;
use ss11;

-- Bài 1

create table accounts (
	account_id int auto_increment primary key,
    customer_name varchar(100),
    balance decimal(10,2) 
);

INSERT INTO accounts (customer_name, balance) 
VALUES ('Nguyễn Văn Mão', 30000),
('Lê Thị Hà',60000),
('Đỗ Thị Hà',90000),
('Minh Ánh',10000),
('Dung',1020000),
('Quỳnh Như',120000),
('Quỳnh Thu',420000),
('Lê Thị Hà',10000),
('Thu Phương',150000),
('Hoa Hồng ',5000000)
;
SELECT * FROM accounts WHERE account_id =10;
START TRANSACTION ;

UPDATE accounts SET balance = balance +1000000
WHERE account_id =10;

COMMIT;
SELECT * FROM accounts WHERE account_id = 10;

-- Bài2

DELIMITER //

CREATE PROCEDURE withdraw_money (
	IN p_account_id int,
    IN p_amount decimal
) 
BEGIN
	-- Khai báo biến để lưu trữ số dư 
    declare v_new_balance decimal(15,2);
    -- Bắt đầu giao dịch
    START TRANSACTION;
    -- THực hiện trừ tiền 
    UPDATE accounts
    SET balance = balance-p_amount
    WHERE account_id = p_account_id;
    -- Lấy số dư mới nhất gán vào biến kiểm tra
    SELECT balance INTO v_new_balance 
    FROM accounts
    WHERE account_id=p_account_id;
    -- logic kiểm tra điều kiện
    IF v_new_balance <0 THEN 
		-- Tiền bị âm -> lỗi ->Hủy giao dịch
        ROLLBACK;
        SELECT CONCAT('Giao dịch thất bại!,Số dư ko đủ. Tài khoản vẫn còn: ',
        (v_new_balance + p_amount)) AS message;
	ELSE 
		-- Tiền dương -> lưu giao dịch
        COMMIT;
        SELECT CONCAT('Rút tiền thành công! Số dư mới là: ', v_new_balance ) AS message;
        END IF;
END //
DELIMITER ;

CALL withdraw_money(2,50000);

CALL withdraw_money(5,100000);

SELECT * FROM accounts WHERE account_id = 5;

-- Bài3 
CREATE TABLE transactions (
	transaction_id int auto_increment primary key,
    account_id int,
    amount decimal (15,2),
    log_message varchar(255),
    transaction_date datetime default current_timestamp,
    foreign key (account_id) references accounts(account_id)
);
-- Tạo procedure 
DELIMITER //
CREATE PROCEDURE deposit_with_logging (
	IN p_account_id int,
    IN p_amount decimal(15,2)
    )
BEGIN
	-- Khai báo biến xử lí lỗi : Nếu gặp lỗi sql thì rollback
	declare exit handler for sqlexception
    BEGIN
	ROLLBACK;
    SELECT 'Đã xảy ra lỗi !Giao dịch bị hủy ' AS message;
	END;
		-- Bắt đầu giao dịch
        START TRANSACTION ;
        -- Thao tác 1 : Cộng tiền 
        UPDATE accounts
        SET balance = balance + p_amount
        WHERE account_id = p_account_id;
        -- Thao tác 2 :Ghi lịch sử 
        INSERT INTO transactions (account_id,amount,log_message)
        VALUES (p_account_id,p_amount,'Nạp tiền vào tài khoản');
        -- Nếu chạy đến đây mà không lỗi gì thì commit 
        COMMIT;
        SELECT 'Nạp tiền và ghi log thành công' AS status;
END //
DELIMITER ;

-- KIểm thử
-- Kiểm tra trước khi nạp
SELECT*FROM accounts WHERE account_id =3;
SELECT*FROM transactions;

-- THỰc hiện nạp 1tr
CAll deposit_with_logging(3,1000000);

-- Kiểm tra
SELECT*FROM accounts WHERE account_id =3;
SELECT*FROM transactions;

-- Bài 4
-- Thêm dữ liệu mẫu
INSERT INTO accounts (customer_name, balance) -- id :11,12
VALUES ('Văn Dũng',2000000),('Văn Tich',0);

DELIMITER //
CREATE PROCEDURE transfer_money(
		IN p_sender_id INT ,
        IN p_receiver_id INT,
        IN p_amount decimal(15,2)
)
BEGIN
	-- Khai báo biến kiểm tra số dư
    declare v_sender_balance decimal(15,2);
    -- Sử lí lỗi
    declare exit handler for sqlexception
		BEGIN
		ROLLBACK;
        SELECT 'Giao dịch thất bại : Lỗi hệ thống ' AS message ;
        END;
	-- Bắt đầu giao dịch 
	START TRANSACTION ;
    -- Kiểm tra ng dùng có đủ tiền ko
    SELECT balance INTO v_sender_balance
    FROM accounts
    WHERE account_id = p_sender_id
    FOR UPDATE; --  sử dụng FOR UPDATE, các hàng được chọn sẽ bị khóa,
				-- ngăn không cho các giao dịch khác thay đổi hoặc xóa chúng cho đến khi giao dịch hiện tại được commit hoặc rollback.
    -- Kiểm tra điều kiện logic 
    IF v_sender_balance >= p_amount THEN
		-- Trừ tiền người gửi
        UPDATE accounts
        SET balance = balance - p_amount
        WHERE account_id = p_sender_id;
        
        -- Cộng tiền người nhận 
        UPDATE accounts
        SET balance = balance + p_amount
        WHERE account_id = p_receiver_id;
        -- XÁC nhận thành công 
        COMMIT;
        SELECT 'Chuyển tiền thành công' AS message;
	ELSE
		-- Tiền không đủ -> Hủy
        Rollback;
        SELECT ' Giao dịch thất bại: Số dư không đủ' AS message;
    END IF;
    
END //
DELIMITER ;

-- Kiểm thử
-- Kiểm tra tài khoản trước khi chuyển
SELECT * FROM accounts wHERE account_id IN (11,12);

-- Thực hiện chuyển 300.000
CALL transfer_money (11,12,300000);
-- Kiểm tra
SELECT * FROM accounts wHERE account_id IN (11,12);

-- Kiểm tra chuyển tiền thất bại
CALL transfer_money (11,12,30000000);


-- Bài 5
CREATE table products(
	product_id int auto_increment primary key,
    product_name varchar(100),
    price decimal(10,2),
    stock Int 
);
create table orders(
	order_id int auto_increment primary key,
    product_id int ,
    quantity int,
    total_price decimal(10,2),
    order_date datetime default current_timestamp,
    foreign key (product_id)references products(product_id)
);
INSERT INTO products(product_name,price,stock) VALUES ('LapTop DELl ',20000000 ,10);
DELIMITER //
CREATE PROCEDURE place_order(
	IN p_product_id INT, -- Mã sản phẩm 
    IN p_quantity INT   -- Số lượng mua 
)
BEGIN
	-- Khai báo biến 
    declare v_stock INT;
    declare v_price decimal (10,2);
    -- Khai báo handler : Gặp lỗi thì rollback
    declare exit handler for sqlexception
    BEGIN
		ROLLBACK;
        SELECT 'Gặp lỗi hệ thống' AS message;
    END;
	-- Bắt đầu transaction 
    START TRANSACTION ;
		-- 1. Kiểm tra số lượng tồn kho 
		SELECT stock,price INTO v_stock,v_price  FROM products
		WHERE product_id = p_product_id
		FOR UPDATE ;
		--  sử dụng FOR UPDATE, các hàng được chọn sẽ bị khóa,
		-- ngăn không cho các giao dịch khác thay đổi hoặc xóa chúng cho đến khi giao dịch hiện tại được commit hoặc rollback.
		-- 2. Kiểm tra điều kiện 
        IF v_stock >= p_quantity THEN
			-- TRừ tồn kho
            UPDATE products
            SET stock = stock - p_quantity
            WHERE product_id = p_product_id;
            -- Tạo đơn hàng
            INSERT INTO orders(product_id,quantity,total_price)
            VALUES (p_product_id,p_quantity,v_price*p_quantity);
            -- Chốt giao dịch
            COMMIT;
            SELECT 'Đặt hàng thành công' AS message;
        ELSE
			-- Hàng không đủ -> HỦY
            ROLLBACK;
            SELECT 'Đặt hàng thất bại: Kho không đủ hàng! ' AS message;
        END IF;
END//
DELIMITER ;

-- KIểm thử
-- TRước khi mua
SELECT * FROM products;
-- Mua thành công
CALL place_order (1,2);
-- Mua thất bại 
CALL place_order (1,20);

-- Sau khi mua
SELECT * FROM products;

-- Bài 6
ALTER TABLE orders ADD COLUMN status VARCHAR(20) default 'completed';
-- RESET lại dữ liệu 
-- UPDATE products SET stock =10 WHERE product_id=1;
-- TRUNCATE TABLE orders;

DELIMITER //
CREATE PROCEDURE cancel_order(
	IN p_order_id INT 
)
BEGIN
	-- Khai báo biến để lưu thông tin 
		declare v_product_id int; -- mã sản phẩm
        declare v_quantity int;	-- số lượng 
        declare v_current_status varchar(20);	-- 
        -- Handler xử lí lỗi hệ thống 
        declare exit handler for sqlexception
        BEGIN
			rollback;
            SELECT 'Lỗi hệ thống! Đã rollback. ' AS message;
		END;
        
	-- Bắt đầu transaction 
	START TRANSACTION;
    -- 1 Lấy thông tin đơn hàng
    SELECT product_id,quantity,status
    INTO v_product_id, v_quantity,v_current_status
    FROM orders
    WHERE order_id = p_order_id
    FOR UPDATE;
    -- 2 Kiểm tra điều kiện
    IF v_product_id IS NUll THEN 
		-- Không tìm thấy đơn hàng
        ROLLBACK;
        SELECT 'Đơn hàng không tồn tại !'AS message;
	ELSEIF v_current_status ='Cancelled' THEN 
		-- Đơn đã hủy rồi thì thôi
        ROllBACK;
        SELECT 'Đơn hàng này đã bị hủy trước đó' AS message;
	ELSE 
		-- TIến hành hủy
			-- 1.Cập nhật trạng thái đơn hàng
            UPDATE orders
            SET status = 'Cancelled'
            WHERE order_id = p_order_id;
            -- 2. Hoàn trả tồn kho
            UPDATE products
            SET stock = stock + v_quantity
            WHERE product_id = v_product_id;
            -- 3. Xác nhận
            COMMIT;
            SELECT 'Hủy đơn hàng thành công ! Đã hoàn tồn kho' AS message ; 
	END IF ;
END//
DELIMITER ;


-- Kiểm thử
-- Tạo đơn hàng 
CALL place_order(1, 3); 
CALL place_order(1, 2); 

SELECT*FROM orders;
SELECT*FROM products;

SELECT * FROM orders ORDER BY order_id DESC LIMIT 1;
SELECT * FROM products WHERE product_id = 1; -- Mong đợi: Stock = 7

-- Hủy đơn hàng vừa tạo 
CALl cancel_order(1);