use ss04;

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
