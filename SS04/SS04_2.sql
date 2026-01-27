use SS04;
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