use ss04;

-- Bài1
CREATE TABLE students (
    student_id VARCHAR(10) PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    birth_date DATE,
    gender VARCHAR(10),
    email VARCHAR(100)
);
INSERT INTO students (student_id, full_name, birth_date, gender, email)
VALUES
('SV001', 'Nguyễn Văn An', '2002-03-15', 'Nam', 'an.nguyen@gmail.com'),
('SV002', 'Phạm Quỳnh Thu', '2003-04-23', 'Nữ', 'thupham@gmail.com'),
('SV003', 'Lê Hoàng Cường', '2003-01-10', 'Nam', NULL),
('SV004', 'Phạm Thu Dung', '2002-11-05', 'Nữ', 'dung.pham@gmail.com'),
('SV005', 'Võ Minh Đức', '2001-09-18', 'Nam', NULL);

-- Hiển thị toàn bộ danh sách sinh viên
SELECT * FROM students;

-- Chỉ hiển thị các cột: mã sinh viên, họ tên, email
SELECT student_id, full_name, email
FROM students;
-- Bài2
-- Cập nhật email cho sinh viên chưa có email
UPDATE students
SET email = 'cuongle@gmail.com'
WHERE student_id = 'SV003';
UPDATE students
SET email = 'voduc@gmail.com'
WHERE student_id = 'SV005';

SELECT * FROM students;
-- Cập nhật giới tính cho sinh viên có mã sinh viên là SV005
UPDATE students
SET gender = 'Nữ'
WHERE student_id = 'SV005';
-- Kiểm tra
SELECT * FROM students
WHERE student_id = 'SV005';

-- Xóa sinh viên có mã sinh viên là SV003
DELETE FROM students
WHERE student_id = 'SV003';
-- Kiểm tra
SELECT * FROM students;
-- Bai3
-- Hiển thị sinh viên có năm sinh từ 2003 đến 2005
SELECT * FROM students WHERE birth_date BETWEEN '2003-01-01' AND '2005-01-01';
-- Hiển thị sinh viên có giới tính là Nam hoặc Nữ
SELECT * FROM students WHERE gender='Nam' OR gender='Nữ';
-- Hiển thị sinh viên có mã sinh viên thuộc một trong các mã: SV001, SV004, SV005
SELECT *
FROM students
WHERE student_id IN ('SV001', 'SV004', 'SV005');

-- Chỉ hiển thị: mã sinh viên,họ tên,ngày sinh
SELECT student_id,full_name,birth_date FROM students;
-- Bài4
-- Hiển thị sinh viên chưa có email
SELECT * 
FROM students 
WHERE email IS NULL;
-- Hiển thị sinh viên đã có email
SELECT * 
FROM students 
WHERE email IS NOT NULL;
-- Hiển thị sinh viên có họ tên bắt đầu bằng chữ “Ng”
SELECT * 
FROM students 
WHERE full_name LIKE  'Ng%';

-- Hiển thị sinh viên không phải giới tính Nam
SELECT *
FROM students
WHERE gender <> 'Nam';

-- Bai5
create table employees (
	emp_id INT PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    birth_year INT NOT NULL,
    department VARCHAR(150) NOT NULL,
    salary INT NOT NULL,
    phone INT NULL
);

INSERT INTO employees (emp_id,full_name,birth_year,department,salary,phone)
 VALUES 
 ('001','NGuyễn Văn Tùng','2000','Bảo vệ','4000000','098765432'),
 ('002','NGuyễn Văn Anh','2000','IT','20000000','098765431'),
 ('003','NGuyễn Văn Tùng','2006','IT','9000000',NULL),
 ('004','NGuyễn Thị Trang','2005','HR','18000000','098785432'),
 ('005','NGuyễn Lan ANh','2000','HR','15000000','088765432'),
 ('006','Phạm Quỳnh Thu','2003','HR','3000000',NULL),
 ('007','Trần Minh An', '1999', 'IT', '12000000', '091234567'),
 ('008','Lê Thị Hạnh', '2001', 'Kế toán', '8000000', NULL),
 ('009','Hoàng Văn Nam', '1998', 'IT', '22000000', '090998877'),
 ('0010','Đặng Thu Anh', '2002', 'HR', '14000000', NULL);
 
 SELECT * FROM employees;
 
-- Hiển thị danh sách nhân viên có mức lương từ 10.000.000 đến 20.000.000
SELECT * FROM employees WHERE salary BETWEEN 10000000 AND 20000000;
-- Hiển thị nhân viên thuộc phòng ban IT hoặc HR
SELECT * FROM employees WHERE department='IT' OR department='HR';
-- Hiển thị nhân viên có họ tên chứa chữ “Anh”
SELECT * FROM employees WHERE full_name LIKE '%Anh%';
-- Hiển thị nhân viên chưa có số điện thoại
SELECT * FROM employees WHERE phone IS NULL;

-- Cập nhật lương tăng thêm 10% cho nhân viên phòng IT
 SELECT emp_id, full_name, salary FROM employees WHERE department = 'IT';

UPDATE employees SET salary = salary * 1.1 WHERE department = 'IT';
SELECT * FROM employees WHERE department = 'IT';
SET SQL_SAFE_UPDATES = 0;
-- Cập nhật số điện thoại cho nhân viên chưa có số điện thoại

UPDATE  employees SET  phone = '09999999' WHERE emp_id ='3';
UPDATE  employees SET  phone = '09999777' WHERE emp_id ='6';
UPDATE  employees SET  phone = '09966699' WHERE emp_id ='8';
UPDATE  employees SET  phone = '09999988' WHERE emp_id ='10';  
-- Xóa nhân viên có mức lương thấp hơn 5.000.000
DELETE FROM employees WHERE salary <5000000;
-- Bai6
CREATE TABLE products (
    product_id INT  PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price INT NOT NULL,
    quantity INT NOT NULL
);
INSERT INTO products (product_id,product_name, category, price, quantity)
 VALUES
('1','Laptop Dell', 'Laptop', '12000000', '10'),
('2','Laptop Asus', 'Laptop', '15000000', '5'),
('3','iPhone 13', 'Phone', '18000000','8'),
('4','Samsung Galaxy Tab', 'Tablet', '9000000', '3'),
('5','Samsung Galaxy S21', 'Phone', '14000000', '0');
-- Hiển thị sản phẩm có giá từ 5.000.000 đến 15.000.000
SELECT * 
FROM products
WHERE price BETWEEN 5000000 AND 15000000;

-- Hiển thị sản phẩm thuộc loại Laptop hoặc Tablet
SELECT * 
FROM products
WHERE category IN ('Laptop', 'Tablet');

-- Hiển thị sản phẩm có tên bắt đầu bằng “Sam”
SELECT * 
FROM products
WHERE product_name LIKE 'Sam%';

-- Hiển thị sản phẩm không thuộc loại Phone
SELECT * 
FROM products
WHERE category <> 'Phone';

SELECT * FROM products;
-- Giảm giá 5% cho các sản phẩm thuộc loại Laptop
UPDATE products
SET price = price * 0.95
WHERE category = 'Laptop';
SET SQL_SAFE_UPDATES = 0;
SELECT * FROM products;
-- Xóa các sản phẩm có số lượng tồn kho bằng 0
DELETE FROM products
WHERE quantity = 0;

SELECT * FROM products;