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