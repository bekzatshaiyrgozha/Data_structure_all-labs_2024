create database lab2;
create table if not exists employees(
    employees_key serial primary key,
    first_name varchar default 'Jhon',
    last_name varchar,
    department_id integer,
    salary integer
);

select * from employees;


insert into employees(first_name, last_name, department_id, salary)
values ('Bekzat','Shaiyrgozha','23031482','1000000');

insert into employees(first_name,last_name)
values ('Beknur','Ualikhanuly');

INSERT INTO employees (first_name, last_name, department_id, salary)
VALUES ('Almas', 'Saty', NULL, 400000);

INSERT INTO employees (first_name, last_name, department_id, salary)
VALUES
('David', 'Clark', 2, 60000),
('Eve', 'Taylor', 3, 70000),
('Frank', 'Wright', 1, 55000),
('Grace', 'Hall', 2, 65000),
('Henry', 'Scott', 3, 48000);



ALTER TABLE employees
ALTER COLUMN first_name SET DEFAULT 'John';

insert into employees(last_name, department_id, salary)
values ('Kein','1234567','234543');

INSERT INTO employees (first_name, last_name, department_id, salary)
VALUES (DEFAULT, DEFAULT, DEFAULT, DEFAULT);

create table employees_archive (like employees including all);

INSERT INTO employees_archive
select * from employees;

update employees
set department_id = 1
where department_id = null;

select * from employees;

UPDATE employees
SET salary = salary * 1.15
RETURNING first_name, last_name, salary AS "Updated Salary";

DELETE FROM employees
WHERE salary < 50000
RETURNING *;


DELETE FROM employees_archive
WHERE employees_key IN (SELECT employees_key FROM employees)
RETURNING *;

delete from employees
returning *;




