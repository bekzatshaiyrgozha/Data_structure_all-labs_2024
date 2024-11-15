create database lab8;

CREATE TABLE librarians_lab8 (
    librarian_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50),
    commission DECIMAL(3, 2)
);

INSERT INTO librarians_lab8 (librarian_id, name, city, commission) VALUES
(2001, 'Michael Green', 'New York', 0.15),
(2002, 'Anna Blue', 'California', 0.13),
(2003, 'Chris Red', 'London', 0.12),
(2004, 'Emma Yellow', 'Paris', 0.14),
(2005, 'David Purple', 'Berlin', 0.12),
(2006, 'Laura Orange', 'Rome', 0.13);

CREATE TABLE members_lab8 (
    member_id INT PRIMARY KEY,
    member_name VARCHAR(50),
    city VARCHAR(50),
    membership_level INT,
    librarian_id INT,
    FOREIGN KEY (librarian_id) REFERENCES librarians(librarian_id)
);

INSERT INTO members_lab8 (member_id, member_name, city, membership_level, librarian_id) VALUES
(1001, 'John Doe', 'New York', 1, 2001),
(1002, 'Alice Johnson', 'California', 2, 2002),
(1003, 'Bob Smith', 'London', 1, 2003),
(1004, 'Sara Green', 'Paris', 3, 2004),
(1005, 'David Brown', 'New York', 1, 2001),
(1006, 'Emma White', 'Berlin', 2, 2005),
(1007, 'Olivia Black', 'Rome', 3, 2006);

CREATE TABLE borrowings_lab8 (
    borrowing_id INT PRIMARY KEY,
    borrow_date DATE,
    return_date DATE,
    member_id INT,
    librarian_id INT,
    book_id INT,
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (librarian_id) REFERENCES librarians(librarian_id)
);

INSERT INTO borrowings_lab8 (borrowing_id, borrow_date, return_date, member_id, librarian_id, book_id) VALUES
(30001, '2023-01-05', '2023-01-10', 1002, 2002, 5001),
(30002, '2022-07-10', '2022-07-17', 1003, 2003, 5002),
(30003, '2021-05-12', '2021-05-20', 1001, 2001, 5003),
(30004, '2020-04-08', '2020-04-15', 1006, 2005, 5004),
(30005, '2024-02-20', '2024-02-12', 1007, 2006, 5005),
(30006, '2023-06-02', '2023-06-12', 1005, 2001, 5001);


select * from librarians_lab8;
select * from members_lab8;
select * from borrowings_lab8;


----3-----
create view libraryants_in_New_York as
select *
from librarians_lab8
where city = 'New York';

select *
from libraryants_in_New_York;

---4------

CREATE VIEW borrowing_records AS
SELECT b.borrowing_id, b.borrow_date, b.return_date, m.member_name, l.name AS librarian_name
FROM borrowings b
JOIN members m ON b.member_id = m.member_id
JOIN librarians l ON b.librarian_id = l.librarian_id;

select * from borrowing_records;

CREATE ROLE library_user LOGIN PASSWORD 'securepassword';


GRANT SELECT ON borrowing_records TO library_user;


----55-----
CREATE VIEW highest_membership_members AS
SELECT * FROM members
WHERE membership_level = (SELECT MAX(membership_level) FROM members);

GRANT SELECT ON highest_membership_members TO library_user;


---6----
CREATE VIEW librarian_count_per_city AS
SELECT city, COUNT(*) AS librarian_count
FROM librarians
GROUP BY city;


---7---
CREATE VIEW librarian_with_multiple_members AS
SELECT l.librarian_id, l.name, COUNT(m.member_id) AS member_count
FROM librarians l
JOIN members m ON l.librarian_id = m.librarian_id
GROUP BY l.librarian_id, l.name
HAVING COUNT(m.member_id) > 1;

---8---
CREATE ROLE intern;
GRANT library_user TO intern;



-------------
CREATE TABLE employeessssss (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    position VARCHAR(50),
    salary DECIMAL(10, 2)
);

INSERT INTO employeessssss (id, name, position, salary) VALUES
(1, 'Bekzat', 'Manager', 5000.00),
(2, 'Aliya', 'Developer', 4000.00),
(3, 'Diana', 'Designer', 3500.00),
(4, 'Askar', 'Manager', 5500.00),
(5, 'Aida', 'Developer', 4500.00);

create role devoloper;
grant select on employeessssss to devoloper;

set role devoloper;
select * from employeessssss;

grant insert on employeessssss to devoloper;
set role devoloper;
SET ROLE devoloper;

GRANT ALL PRIVILEGES ON employeessssss TO devoloper;



