use ss07;

create table employees (
	emp_id int primary key,
    full_name varchar(100),
    department varchar(100),
    salary int
);

create index idx_emp_department 
ON employees(department);

