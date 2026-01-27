use ss03;

-- Bai1
create table classes (
	class_id int primary key,
    class_name varchar(50) not null
);
create table students (
	student_id int primary key,
    student_name varchar(50) not null,
    dob date not null,
    class_id int not null,
    
    Foreign key (class_id) references classes(class_id)
);
-- Bai2
create table books (
	book_id int primary key,
    book_name varchar(50) not null
);

create table readers (
	reader_id int primary key,
    reader_name varchar(50) not null
);

create table borrowings (
	borrowing_id int primary key,
    book_id int,
    reader_id int,
    borrow_date date,
    return_date date,
    
    foreign key (book_id ) references books(book_id),
    foreign key (reader_id ) references readers(reader_id)
);

alter table borrowings 
modify borrow_date date not null;

-- Bai3
create table orders (
	order_id int primary key ,
    order_name varchar(50) not null
);
create table products (
	product_id int primary key,
    product_name varchar(50) not null
);
create table order_items(
	order_id int not null,
    product_id int not null,
    quantity int not null,
    
    primary key (order_id, product_id),
    
    foreign key (order_id) references orders(order_id),
    foreign key (product_id) references products(product_id)
);
-- Bai4
create table users(
	users_id int primary key,
    users_name varchar(50) unique,
    users_email varchar(50) unique,
    users_password varchar(50) not null,
    users_status varchar(50) default 'active'
    
);

alter table users
ADD CONSTRAINT chk_users_status
CHECK (users_status IN ('active','inactive'));

-- DROP TABLE users;

-- Bai5
create table courses_b5(
	course_id int primary key,
    course_name varchar(50) not null,
    course_describe varchar(150) not null,
    course_price int not null
);
create table teachers_b5(
	teacher_id int primary key,
    teacher_name varchar (50) not null,
    teacher_email varchar (50) not null
);
create table students_b5(
	student_id int primary key,
    student_name varchar(50) not null,
    student_email varchar(50) not null
);
create table enrollments_b5(
	enrollment_id int primary key,
    student_id int,
    course_id int,
    
    foreign key (student_id) references  students_b5(student_id),
    foreign key (course_id) references courses_b5(course_id)
);

alter table courses_b5 
add constraint chk_course_price CHECK (price>0);

-- drop table enrollments_b5;

