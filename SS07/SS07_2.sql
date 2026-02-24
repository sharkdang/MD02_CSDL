use ss07;

create table customers(
	customer_id int primary key,
    customer_name varchar(100)
);
create table orders (
	order_id int primary key,
    order_date date,
    customer_id int,
    foreign key (customer_id) references customers(customer_id)
);

INSERT INTO customers (customer_id, customer_name) VALUES
(1, 'Nguyễn Văn An'),
(2, 'Phạm Thu'),
(3, 'Lê Văn Dũng');

INSERT INTO orders (order_id, order_date, customer_id) VALUES
(101, '2025-01-10', 1),
(102, '2025-01-12', 2),
(103, '2025-01-15', 1);

create view v_order_info AS
SELECT o.order_id,o.order_date,c.customer_name
FROM orders o
JOIN customers c
ON o.customer_id=c.customer_id;

SELECT * FROM v_order_info;





