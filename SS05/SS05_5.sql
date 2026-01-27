use ss05;

-- Bài5
create table scores (
	student_id int primary key,
    subject varchar(100) ,
    score int
);
INSERT INTO scores(student_id,subject,score)
VALUES
 ('1','Toán','10'),
 ('2','Lý','8'),
 ('3','Hóa','6'),
 ('4','Sinh','10'),
 ('5','Văn','5');
-- Tính điểm trung bình của mỗi sinh viên
SELECT
    student_id,
    AVG(score) AS avg_score
FROM scores
GROUP BY student_id;

-- Chỉ hiển thị các sinh viên có: điểm trung bình ≥ 7.0
SELECT
    student_id,
    AVG(score) AS avg_score
FROM scores
GROUP BY student_id
HAVING avg_score >=7;
-- Hiển thị sinh viên có: điểm trung bình cao nhất trong toàn bộ danh sách
SELECT student_id,AVG(score) AS avg_score
FROM scores 
GROUP BY student_id
HAVING avg_score = (
	SELECT MAX(avg_score)
    FROM (
    SELECT AVG(score) AS avg_score
    FROM scores
    GROUP BY student_id
    ) t
);
-- Hiển thị các sinh viên có: điểm trung bình cao hơn điểm trung bình chung của tất cả sinh viên  


SELECT student_id ,AVG(score) AS avg_score
FROM scores 
GROUP BY student_id
HAVING avg_score >(
	SELECT AVG(score)
    FROM scores
);



