use ss06;

-- Bài 3

-- Tìm các sản phẩm có giá nằm trong một khoảng cụ thể 5tr-15tr
SELECT product_id,product_name,price
FROM products
WHERE price
BETWEEN 5000000 AND 15000000;

-- Tìm các sản phẩm có tên chứa một chuỗi ký tự nhất định 'h'
SELECT product_id,product_name,price
FROM products
WHERE product_name LIKE '%h%';
-- Tính giá trung bình của sản phẩm cho mỗi danh mục
SELECT c.category_name,
		AVG(p.price) AS avg_price
FROM categories c
JOIN products p
ON c.category_id = p.category_id
GROUP BY c.category_name;
-- Tìm những sản phẩm có giá cao hơn mức giá trung bình của toàn bộ sản phẩm
SELECT product_id,product_name,price
FROM products
WHERE price > (
	SELECT AVG(price)
    FROM products
);
-- Tìm sản phẩm có giá thấp nhất cho từng danh mục
-- Phone → sp rẻ nhất
-- Laptop → sp rẻ nhất
-- Watch → sp rẻ nhất

SELECT p.product_id,p.product_name,p.price,c.category_name
FROM products p
JOIN categories c
ON p.category_id=c.category_id
WHERE p.price = (
	SELECT MIN(t.price)
    FROM products t
    WHERE t.category_id = p.category_id
);