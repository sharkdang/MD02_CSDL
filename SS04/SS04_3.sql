use ss04;
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