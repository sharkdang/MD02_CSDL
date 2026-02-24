use ss07;

create view v_employee_public as
select emp_id,
		full_name,
        department
from employees;