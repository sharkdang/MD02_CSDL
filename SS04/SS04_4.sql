use ss04;
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
