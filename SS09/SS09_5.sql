
CREATE TABLE orders(
	order_id int primary key auto_increment,
    customer_id int ,
    product_id int ,
    quantity int not null check(quantity>0),
    total_amount decimal(10,2) not null check(total_amount>0),
    status enum('pending','success','cancel') default 'pending',
    
    foreign key (customer_id) references customers(customer_id),
	foreign key (product_id) references products(product_id)
);

INSERT INTO orders (customer_id, product_id, quantity, total_amount, status) VALUES
(1,1,2,200000,'Success'),
(1,2,1,150000,'Success'),
(2,1,3,300000,'Success'),
(2,3,1,100000,'Pending'),
(3,2,2,250000,'Success'),
(3,4,1,120000,'Cancel'),
(4,1,1,100000,'Success'),
(4,5,2,400000,'Success'),
(5,3,2,220000,'Pending'),
(5,2,1,130000,'Success'),
(6,4,1,80000,'Success'),
(6,1,2,210000,'Cancel'),
(7,5,1,50000,'Success'),
(7,2,3,330000,'Success'),
(8,1,2,200000,'Success'),
(8,3,1,110000,'Pending'),
(9,4,2,260000,'Success'),
(9,5,1,140000,'Success'),
(10,2,1,90000,'Success'),
(10,3,2,180000,'Cancel');

CREATE VIEW view_custoner_spending AS
SELECT 
	c.customer_id,
    c.customer_name,
    COUNT (o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o
	ON c.customer_id = o.customer_id
WHERE o.status = 'success'
GROUP BY c.customer_id,c.customer_name;