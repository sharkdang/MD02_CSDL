create database ss02;
use ss02;

-- Bài3
create table students_constraint (
	student_id int primary key,
    full_name varchar(150) not null,
    email varchar(100) unique,
    age int check (age>=18)
);
-- Bài4
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    username VARCHAR(100) UNIQUE,
    user_password VARCHAR(150) NOT NULL,
    status VARCHAR(10) DEFAULT 'ACTIVE',
    CHECK (status IN ('ACTIVE', 'INACTIVE'))
);
-- Bài5
CREATE TABLE classes (
    class_id INT PRIMARY KEY,
    class_name VARCHAR(100) NOT NULL,
    academic_year VARCHAR(20) NOT NULL
);
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(150) NOT NULL,
    birth_date DATE NOT NULL,
    gender VARCHAR(10) NOT NULL,
    class_id INT NOT NULL,
    FOREIGN KEY (class_id) REFERENCES classes(class_id)
);
-- Bài6
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    order_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL
);
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    price DECIMAL(10,2) NOT NULL
);
CREATE TABLE order_items (
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,

    PRIMARY KEY (order_id, product_id),

    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

