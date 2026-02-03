use ss06;

-- Bài5
-- Liệt kê sản phẩm cùng với tên danh mục tương ứng.
SELECT p.product_id,p.product_name,category_name
FROM products p
JOIN categories c
ON p.category_id=c.category_id;
-- Đếm số đơn hàng của từng khách hàng.
SELECT c.customer_id,c.customer_name, COUNT(order_id) AS COUNT_orders
FROM customers c
LEFT JOIN orders o
ON c.customer_id=o.customer_id
GROUP BY c.customer_id,c.customer_name;
-- Xác định 5 khách hàng có tổng doanh thu chi tiêu cao nhất.
SELECT c.customer_id,c.customer_name,SUM(od.quantity*od.price) AS total_spent
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_details od
ON o.order_id=od.order_id
GROUP BY c.customer_id,c.customer_name
ORDER BY total_spent DESC
LIMIT 5;

-- Tìm các sản phẩm chưa từng xuất hiện trong bất kỳ đơn hàng nào.
SELECT p.product_id,p.product_name
FROM products p
JOIN order_details od
ON p.product_id = od.product_id
WHERE od.product_id IS NOT  NULL;
-- Tìm những khách hàng đã mua sản phẩm thuộc danh mục có số lượng sản phẩm lớn nhất.
SELECT DISTINCT
    c.customer_id,
    c.customer_name
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_details od
ON o.order_id = od.order_id
JOIN products p
ON od.product_id = p.product_id
WHERE p.category_id = 
(SELECT category_id
FROM products
GROUP BY category_id
ORDER BY COUNT(product_id) DESC LIMIT 1);
 


