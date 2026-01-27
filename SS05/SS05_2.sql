use ss05;
-- Bài2
create table employees (
	emp_id int primary key,
    full_name varchar(150) ,
    department varchar(150),
    salary int 
);
INSERT INTO  employees(emp_id,full_name,department,salary)
VALUES
('1','Trần văn đông','IT','10000000'),
('2','Lê THị Lan','HR','15000000'),
('3','Nguyễn Thị Nga','IT','7000000'),
('4','Trần văn Khoa','HR','10000000'),
('5','Trần văn phú','HR','3000000'),
('6','Lê Văn Tú','IT','18000000'),
('7','Lê Văn Việt','IT','11000000');
-- Thống kê: mỗi phòng ban có bao nhiêu nhân viên
SELECT department, COUNT(emp_id) AS total_emp
FROM
employees
GROUP BY department ;
-- Tính: mức lương trung bình của từng phòng ban
SELECT department, AVG(salary) AS avg_salary
FROM
employees 
GROUP BY department;
-- Chỉ hiển thị: các phòng ban có trên 3 nhân viên
SELECT department,COUNT(emp_id) AS total_emp
FROM
employees
GROUP BY department 
HAVING COUNT(emp_id)>3;
-- Chỉ hiển thị: các phòng ban có lương trung bình lớn hơn 10.000.000
SELECT department,AVG(salary) AS avg_salary
FROM
employees
GROUP BY department
HAVING AVG(salary)>10000000;
