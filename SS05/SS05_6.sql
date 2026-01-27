use ss05;

-- Bài6
-- Hiển thị: mã đơn hàng, tên khách hàng, tổng tiền của đơn hàng
SELECT  o.order_id,
		c.customer_name,
		SUM(oi.quantity * oi.price) AS total_order
FROM orders o
JOIN customers c 
		ON o.customer_id = c.customer_id
JOIN order_items oi
		ON o.order_id = oi.order_id
GROUP BY 
		o.order_id,c.customer_name;
        
        SELECT * FROM order_items;
        SELECT * FROM orders;
-- Tính: tổng doanh thu của mỗi khách hàng
SELECT 
    c.customer_id,
    c.customer_name,
    SUM(oi.quantity * oi.price) AS total_orders
FROM customers c
JOIN Orders o 
    ON c.customer_id = o.customer_id
JOIN Order_items oi 
    ON o.order_id = oi.order_id
GROUP BY 
    c.customer_id, c.customer_name;

-- Chỉ hiển thị: các khách hàng có tổng doanh thu lớn hơn 20.000.000
SELECT 
    c.customer_id,
    c.customer_name,
    SUM(oi.quantity * oi.price) AS total_orders
FROM customers c
JOIN Orders o 
    ON c.customer_id = o.customer_id
JOIN Order_items oi 
    ON o.order_id = oi.order_id
GROUP BY 
    c.customer_id, c.customer_name
HAVING 
    SUM(oi.quantity * oi.price) > 20000000;

-- Hiển thị: khách hàng có doanh thu cao nhất
SELECT 
    c.customer_id,
    c.customer_name,
    SUM(oi.quantity * oi.price) AS total_revenue
FROM customers c
JOIN Orders o 
    ON c.customer_id = o.customer_id
JOIN Order_items oi 
    ON o.order_id = oi.order_id
GROUP BY 
    c.customer_id, c.customer_name
ORDER BY 
    total_revenue DESC
LIMIT 1;
