create  database lab3;

-- 2. Create table for Students
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    email VARCHAR(100) UNIQUE,
    city VARCHAR(50)
);

-- 3. Create table for Courses
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_code VARCHAR(10) UNIQUE,
    course_name VARCHAR(100),
    credits INT
);

-- 4. Create table for Registration (link between students and courses)
CREATE TABLE registration (
    registration_id SERIAL PRIMARY KEY,
    student_id INT,
    course_id INT,
    registration_date DATE,
    grade VARCHAR(2),
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE
);

-- 5. Insert sample data into students table
INSERT INTO students (first_name, last_name, date_of_birth, email, city) VALUES
('Alice', 'Johnson', '2001-05-14', 'alice.johnson@example.com', 'Almaty'),
('Bob', 'Smith', '2000-09-20', 'bob.smith@example.com', 'New York'),
('Cathy', 'Williams', '2002-01-10', 'cathy.williams@example.com', 'Almaty'),
('David', 'Brown', '1999-03-22', 'david.brown@example.com', 'Los Angeles');

-- 6. Insert sample data into courses table
INSERT INTO courses (course_code, course_name, credits) VALUES
('CS101', 'Introduction to Computer Science', 4),
('MATH201', 'Calculus I', 3),
('PHYS301', 'General Physics', 3),
('HIST101', 'World History', 2);

-- 7. Insert sample data into registration table
INSERT INTO registration (student_id, course_id, registration_date, grade) VALUES
(1, 1, '2023-09-01', NULL),  -- Alice registered for CS101
(2, 2, '2023-09-01', NULL),  -- Bob registered for MATH201
(3, 3, '2023-09-01', NULL),  -- Cathy registered for PHYS301
(4, 1, '2023-09-01', NULL),  -- David registered for CS101
(1, 4, '2023-09-01', NULL);  -- Alice registered for HIST101

select * from students;
select * from courses;
select * from registration;

select students.last_name from students;

select distinct students.last_name from students;

insert into students(first_name, last_name, date_of_birth, email, city)
VALUES ('Bekzat','Shaiyrgozha','2005-05-05','beriktas2006@gmail.com','Almaty');

insert into students(first_name, last_name, date_of_birth, email, city)
VALUES ('Ali','Shaiyrgozha','2005-05-05','beriktas2005@gmail.com','Almaty');

select students.last_name from students
where last_name in('Johnson') ;

select students.last_name from students
where last_name in ('Johnson','Smith');

select * from students
where student_id in(
    select student_id from registration
                      where students.student_id in(select course_id from courses
                                                                    where course_code = 'CS101')
    );

select * from students
where student_id in(
    select student_id from registration
                      where registration.course_id in(
                          select courses.course_id from courses
                                                     where course_code in ('MATH201','PHYS301')
                          )
    );


select courses.credits from courses;

SELECT course_id, COUNT(*) AS student_count
FROM registration
GROUP BY course_id;

select registration.course_id
from  registration
group by course_id
having count(*)>2;

select courses.course_name from courses
order by credits desc
limit 1 offset 1 ;



SELECT first_name, last_name
FROM students
WHERE city = 'Almaty';

SELECT *
FROM courses
WHERE credits > 3
ORDER BY credits , course_id DESC;


UPDATE courses
SET credits = credits - 1
WHERE course_id = (
    SELECT course_id
    FROM courses
    ORDER BY credits
    LIMIT 1
);

select distinct students.last_name from students;

select students.last_name from students
where last_name in ('Smith', 'Johnson');

select * from students
where student_id in (select student_id from registration
                                       where students.student_id in(select course_id
                                                          from courses
                                                          where course_code in('CS101')
                                           ));



select * from students
where student_id in(select student_id from registration
                                      where students.student_id in(
                                          select courses.course_id from courses
                                                                     where course_code in( 'PHYS301','MATH201')
                                          ));

select courses.credits from courses;

select registration.course_id,count(*) as student_total from registration
group by course_id;




select registration.course_id from registration
group by course_id
having count(*)>2;

select courses.credits from courses
order by credits desc
limit 1 offset 1;

select * from courses;




select students.first_name,students.last_name from students
where city = 'Almaty';


select * from courses
where credits>3
order by credits,course_id desc ;

UPDATE courses
SET credits = credits - 1
WHERE course_id = (
    SELECT course_id
    FROM courses
    ORDER BY credits
    LIMIT 1
);

update courses
set credits = credits-1
where course_id in(
    select course_id from courses
                     order by credits
                     limit 1
    );

update courses
set credits = credits -1
where course_id in(select course_id from courses
                                    order by credits
                                    limit 1);

select * from courses;

UPDATE registration
SET course_id = (SELECT course_id FROM courses WHERE course_code = 'CS101')
WHERE course_id = (SELECT course_id FROM courses WHERE course_code = 'MATH201');

select * from  registration;

DELETE FROM students
WHERE student_id IN (
    SELECT student_id
    FROM registration
    WHERE course_id = (SELECT course_id FROM courses WHERE course_code = 'CS101')
);

DELETE FROM students;


SELECT first_name, last_name
FROM students
WHERE student_id IN (
    SELECT student_id
    FROM registration
    WHERE course_id = (
        SELECT course_id
        FROM courses
        ORDER BY credits
        LIMIT 1
    )
);














------------------------------
--7exercise-


select * from students
where student_id in (select student_id from registration
                                       where student_id in(select course_id from courses
                                                                           where course_code = 'CS101'));

---8--

select * from students
where student_id in(select student_id from registration
                                      where students.student_id in(select course_id from courses
                                                                                    where course_code in('MATH201','PHYS301')));
---10--

select  registration.course_id,count(*) as student_total
from registration
group by course_id;

---11---

select student_id from registration
group by student_id
having count(*)>=2;

---12--

select courses.course_name from courses
where credits>3
order by credits desc
limit 1 offset 1;

--13--



select students.first_name,students.last_name from students
where student_id in(select student_id from registration
                                      where course_id in(select course_id from courses
                                                                          order by credits
                                                                          limit 1));





 