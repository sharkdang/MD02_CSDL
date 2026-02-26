

DELIMITER //
CREATE procedure insert_customer(in_customer_name VARCHAR(50),in_email varchar(100),in_phone varchar(15),in_address varchar(255))
BEGIN
	INSERT INTO customers(customer_name,email,phone,address)
    VALUES (in_customer_name,in_email,in_phone,in_address);
    SELECT 'Thêm mới khách hàng thành công!' AS mesage ;
END //
DELIMITER ;

CALL insert_customer('Lê Quang Đăng ','dang@gmail.com','09000000','Hà Nội');