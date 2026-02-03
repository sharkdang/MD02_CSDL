use ss06;

-- Bài4
-- Thêm một đơn hàng mới vào bảng orders và chi tiết của đơn hàng đó vào bảng order_details.
INSERT INTO  orders(order_id,customer_id,order_date)
VALUES (4,11,'2024-04-02');

INSERT INTO order_details(order_id,product_id,quantity,price)
VALUES 
(4,1,1,20000000),
(4,3,2,1000000);
-- Tính tổng doanh thu của toàn bộ cửa hàng.(doanh thu = số lượng * giá bán)
SELECT 
	SUM( quantity * price ) AS total_revenue
FROM order_details;
-- Tính doanh thu trung bình của mỗi đơn hàng.
SELECT AVG(order_revenue) AS avg_revenue
FROM (
	SELECT order_id,SUM(quantity * price) AS order_revenue
    FROM order_details
    GROUP BY order_id) t;
-- Tìm và hiển thị thông tin của đơn hàng có doanh thu cao nhất.
SELECT 
	o.order_id,
    o.customer_id,
    o.order_date,
    SUM(od.quantity * od.price) AS order_revenue
FROM orders o
JOIN order_details od
ON o.order_id = od.order_id
GROUP BY o.order_id,o.customer_id,o.order_date
ORDER BY order_revenue DESC LIMIT 1;
-- Tìm và hiển thị danh sách 3 sản phẩm bán chạy nhất dựa trên tổng số lượng đã bán.
SELECT p.product_id,p.product_name,SUM(od.quantity) AS total_sold
FROM order_details od
JOIN products p
ON od.product_id=p.product_id
GROUP BY p.product_id,p.product_name
ORDER BY total_sold DESC LIMIT 3;