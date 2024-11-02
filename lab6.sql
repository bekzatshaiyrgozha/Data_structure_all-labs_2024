CREATE DATABASE lab6_courses1;


CREATE TABLE courses_lab61 (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(50),
    course_code VARCHAR(10),
    credits INTEGER
);


CREATE TABLE professors_lab61 (
    professor_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50)
);


CREATE TABLE students_lab61 (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    major VARCHAR(50),
    year_enrolled INTEGER
);


CREATE TABLE enrollments_lab61 (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INTEGER REFERENCES students_lab6(student_id),
    course_id INTEGER REFERENCES courses_lab6(course_id),
    professor_id INTEGER REFERENCES professors_lab6(professor_id),
    enrollment_date DATE
);


INSERT INTO courses_lab61 (course_name, course_code, credits) VALUES
('Mathematics', 'MATH101', 3),
('Physics', 'PHYS201', 4),
('Computer Science', 'CS301', 3),
('Chemistry', 'CHEM101', 4),
('History', 'HIST105', 2);


INSERT INTO professors_lab61 (first_name, last_name, department) VALUES
('Alice', 'Johnson', 'Mathematics'),
('Bob', 'Smith', 'Physics'),
('Carol', 'White', 'Computer Science'),
('David', 'Brown', 'Chemistry'),
('Eve', 'Davis', 'History');


INSERT INTO students_lab61 (first_name, last_name, major, year_enrolled) VALUES
('John', 'Doe', 'Computer Science', 2022),
('Jane', 'Roe', 'Mathematics', 2021),
('Mike', 'Lee', 'Physics', 2023),
('Anna', 'Kim', 'Chemistry', 2022),
('Tom', 'Green', 'History', 2020);

INSERT INTO enrollments_lab61 (student_id, course_id, professor_id, enrollment_date) VALUES
(1, 3, 3, '2023-09-01'),
(2, 1, 1, '2022-09-01'),
(3, 2, 2, '2024-01-15'),
(4, 4, 4, '2023-09-01'),
(5, 5, 5, '2023-01-10'),
(1, 1, 1, '2022-09-01'),
(4, 5, 5, '2023-09-01');


---1---
SELECT
    students_lab61.first_name AS student_first_name,
    students_lab61.last_name AS student_last_name,
    courses_lab61.course_name,
    professors_lab61.last_name AS professor_last_name
FROM
    enrollments_lab61
JOIN
    students_lab61 ON enrollments_lab61.student_id = students_lab61.student_id
JOIN
    courses_lab61 ON enrollments_lab61.course_id = courses_lab61.course_id
JOIN
    professors_lab61 ON enrollments_lab61.professor_id = professors_lab61.professor_id;

----2----
SELECT
    students_lab61.first_name,
    students_lab61.last_name
FROM
    enrollments_lab61
JOIN
    students_lab61 ON enrollments_lab61.student_id = students_lab61.student_id
JOIN
    courses_lab61 ON enrollments_lab61.course_id = courses_lab61.course_id
WHERE
    courses_lab61.credits > 3;


--3---
SELECT
    courses_lab61.course_name,
    COUNT(enrollments_lab61.student_id) AS num_students
FROM
    courses_lab61
LEFT JOIN
    enrollments_lab61 ON courses_lab61.course_id = enrollments_lab61.course_id
GROUP BY
    courses_lab61.course_name;



----4----
SELECT DISTINCT
    professors_lab61.first_name,
    professors_lab61.last_name
FROM
    professors_lab61
JOIN
    enrollments_lab61 ON professors_lab61.professor_id = enrollments_lab61.professor_id;



----5---
SELECT
    students_lab61.first_name,
    students_lab61.last_name
FROM
    enrollments_lab61
JOIN
    students_lab61 ON enrollments_lab61.student_id = students_lab61.student_id
JOIN
    professors_lab61 ON enrollments_lab61.professor_id = professors_lab61.professor_id
WHERE
    professors_lab61.department = 'Computer Science';



----6----
SELECT
    courses_lab61.course_name,
    professors_lab61.last_name,
    courses_lab61.credits
FROM
    courses_lab61
JOIN
    enrollments_lab61 ON courses_lab61.course_id = enrollments_lab61.course_id
JOIN
    professors_lab61 ON enrollments_lab61.professor_id = professors_lab61.professor_id
WHERE
    professors_lab61.last_name LIKE 'S%';


----7---
SELECT
    students_lab61.first_name,
    students_lab61.last_name
FROM
    enrollments_lab61
JOIN
    students_lab61 ON enrollments_lab61.student_id = students_lab61.student_id
WHERE
    EXTRACT(YEAR FROM enrollments_lab61.enrollment_date) < 2022;

---8---
SELECT
    courses_lab61.course_name
FROM
    courses_lab61
LEFT JOIN
    enrollments_lab61 ON courses_lab61.course_id = enrollments_lab61.course_id
WHERE
    enrollments_lab61.course_id IS NULL;


---



select
    students_lab61.first_name as student_first_name,
    students_lab61.last_name as student_last_name,
    courses_lab61.course_name,
    professors_lab61.last_name as professor_last_name
from enrollments_lab61

join students_lab61 on enrollments_lab61.student_id = students_lab61.student_id
join courses_lab61  on enrollments_lab61.course_id = courses_lab61.course_id
join professors_lab61 on enrollments_lab61.professor_id = professors_lab61.professor_id;



select
    students_lab61.first_name,
    students_lab61.last_name,
    courses_lab61.course_name
from enrollments_lab61
join students_lab61 on enrollments_lab61.student_id = students_lab61.student_id
join courses_lab61 on enrollments_lab61.course_id = courses_lab61.course_id
where credits > 3;



select

    courses_lab61.course_name,
    count(enrollments_lab61.student_id)
from courses_lab61
left join enrollments_lab61 on courses_lab61.course_id = enrollments_lab61.course_id
group by courses_lab61.course_name ;


select distinct
    first_name,
    last_name
from professors_lab61

join enrollments_lab61 on professors_lab61.professor_id = enrollments_lab61.professor_id;


select
    students_lab61.first_name,
    students_lab61.last_name
from enrollments_lab61
join students_lab61 on enrollments_lab61.student_id = students_lab61.student_id
join professors_lab61 on enrollments_lab61.professor_id = professors_lab61.professor_id
where professors_lab61.department = 'Computer Science';


select
    courses_lab61.course_name,
    professors_lab61.last_name,
    courses_lab61.credits
from courses_lab61

join professors_lab61 on courses_lab61.course_id = professor_id
join enrollments_lab61 on courses_lab61.course_id = enrollments_lab61.course_id
where last_name like 'S%';

select
    students_lab61.first_name,
    students_lab61.last_name
from enrollments_lab61

join students_lab61 on enrollments_lab61.student_id = students_lab61.student_id
where year_enrolled < 2022;

select
    courses_lab61.course_name
from courses_lab61

left join enrollments_lab61 on courses_lab61.course_id = enrollments_lab61.course_id

where enrollments_lab61.course_id = null;
















select
    students_lab61.first_name,
    students_lab61.last_name,
    courses_lab61.course_id,
    professors_lab61.last_name
from enrollments_lab61

join courses_lab61 on enrollments_lab61.course_id = courses_lab61.course_id
join professors_lab61 on enrollments_lab61.professor_id = professors_lab61.professor_id
join students_lab61 on enrollments_lab61.student_id = students_lab61.student_id;


select
    students_lab61.first_name,
    students_lab61.last_name
from enrollments_lab61

join courses_lab61 on enrollments_lab61.course_id = courses_lab61.course_id
join students_lab61 on enrollments_lab61.student_id = students_lab61.student_id
where courses_lab61.credits >3;


select
    courses_lab61.course_name,
    count(students_lab61.student_id)
from enrollments_lab61
join courses_lab61 on enrollments_lab61.course_id = courses_lab61.course_id
join students_lab61 on enrollments_lab61.student_id = students_lab61.student_id
group by courses_lab61.course_name ;





























select
    courses_lab61.course_name,
    count(students_lab61.student_id)
from enrollments_lab61
join students_lab61 on enrollments_lab61.student_id = students_lab61.student_id
join courses_lab61 on enrollments_lab61.course_id = courses_lab61.course_id

group by courses_lab61.course_name ;


select
    courses_lab61.course_name,
    professors_lab61.last_name
from enrollments_lab61

join courses_lab61 on enrollments_lab61.course_id = courses_lab61.course_id
join professors_lab61 on enrollments_lab61.professor_id = professors_lab61.professor_id

where last_name like 'S%';


SELECT
    courses_lab61.course_name
FROM
    courses_lab61
LEFT JOIN
    enrollments_lab61 ON courses_lab61.course_id = enrollments_lab61.course_id
WHERE
    enrollments_lab61.course_id IS NULL;






select
    students_lab61.first_name,
    students_lab61.last_name
from enrollments_lab61
join students_lab61 on enrollments_lab61.student_id = students_lab61.student_id
where year_enrolled < 2022;
