CREATE database ss07;
use ss07;

create table students(
	student_id INT primary key,
    full_name varchar(100),
    birth_year int,
    class_name varchar(100),
    address varchar(255)
    
);

create view v_student_basic AS
SELECT student_id,full_name,class_name
FROM students;

SELECT * FROM v_student_basic;