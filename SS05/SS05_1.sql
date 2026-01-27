create database ss05;

use ss05;
-- bài1
create table students (
	student_id int primary key,
    full_name varchar(100) ,
    birth_year int ,
    gender varchar(10),
    score decimal(4,2)
);
INSERT INTO students (student_id, full_name, birth_year, gender, score)
VALUES
('1', 'Nguyễn Văn An', '2002', 'Nam', '8.8'),
('2', 'Phạm Quỳnh Thu', '2003', 'Nữ', '9.0'),
('3', 'Lê Hoàng Cường', '2003', 'Nam', '5.25'),
('4', 'Phạm Thu Dung', '2002', 'Nữ', '6.5'),
('5', 'Võ Minh Đức', '2001', 'Nam','7.5' );
-- Hiển thị: mã sinh viên ,họ tên (viết hoa toàn bộ) , Ban đầu chưa in hoa hết
SELECT 
student_id,
UPPER(full_name) AS full_name_upper
FROM students;

-- Hiển thị: họ tên,số tuổi của sinh viên (dựa vào năm hiện tại)
SELECT 
full_name,
YEAR(CURDATE()) - birth_year AS age
FROM students;

-- Hiển thị: điểm trung bình được làm tròn 1 chữ số thập phân
SELECT 
full_name,
ROUND(score, 1) AS rounded_score
FROM students;

-- Hiển thị: tổng số sinh viên,điểm cao nhất,điểm thấp nhất
SELECT
COUNT(*) AS total_student,
MAX(score) AS highest_score,
MIN(score) AS lowest_score
FROM students;
