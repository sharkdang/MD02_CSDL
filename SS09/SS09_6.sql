
DELIMITER //
CREATE PROCEDURE add_order (
	IN _customer_id INT ,
    IN _product_id INT,
    IN _quantity INT ,
    OUT _message VARCHAR(100)
)
BEGIN
	-- Khai báo biến	
	declare current_stock int;
    declare product_price decimal(10,2);
	-- Lấy tồn kho và gtri sản phẩm 
    SELECT stock,price
    INTO current_stock,product_price
    FROM products
    WHERE product_id = _product_id;
    -- Kiểm tra số lượng tồn kho
    IF current_stock <_quantity THEN 
		SET _message = 'Không đủ số lượng sản phẩm để đặt hàng';
	ELSE 
		-- Thêm đơn hàng 
        INSERT INTO orders(customer_id,product_id,quantity,total_amount,status)
        VALUES(_customer_id,_product_id,_quantity,product_price*_quantity,'success');
        -- Trừ tồn kho
        UPDATE products
        SET stock = stock-_quantity
        WHERE product_id = _product_id;
        SET _message ='Thêm đơn hàng thành công!';
        END IF;
END //
DELIMITER ;


-- GỌi stored procedure để kiểm tra 
-- Thêm đơn hàng thành công
SET @message='';
CALL add_order(1,1,2,@message);
SELECT @message AS result_message;

-- Thêm đơn hàng thất bại
SET @message='';
CALL add_order(1,1,500,@message);
SELECT @message AS result_message;