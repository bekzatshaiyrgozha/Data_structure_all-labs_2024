create database library_db;

CREATE TABLE members (
    member_id INT PRIMARY KEY,
    member_name VARCHAR(100),
    city VARCHAR(100),
    membership_level INT,
    librarian_id INT,
    FOREIGN KEY (librarian_id) REFERENCES librarians(librarian_id)
);


CREATE TABLE librarians (
    librarian_id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(100),
    commission DECIMAL(5,2)
);


CREATE TABLE borrowings (
    borrowing_id INT PRIMARY KEY,
    borrow_date DATE,
    return_date DATE,
    member_id INT,
    librarian_id INT,
    book_id INT,
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (librarian_id) REFERENCES librarians(librarian_id)
);


INSERT INTO librarians (librarian_id, name, city, commission) VALUES
(2001, 'Michael Green', 'New York', 0.15),
(2002, 'Anna Blue', 'California', 0.13),
(2003, 'Chris Red', 'London', 0.12),
(2004, 'Emma Yellow', 'Paris', 0.14),
(2005, 'David Purple', 'Berlin', 0.12),
(2006, 'Laura Orange', 'Rome', 0.13);

INSERT INTO members (member_id, member_name, city, membership_level, librarian_id) VALUES
(1001, 'John Doe', 'New York', 1, 2001),
(1002, 'Alice Johnson', 'California', 2, 2002),
(1003, 'Bob Smith', 'London', 1, 2003),
(1004, 'Sara Green', 'Paris', 3, 2004),
(1005, 'David Brown', 'New York', 1, 2001),
(1006, 'Emma White', 'Berlin', 2, 2005),
(1007, 'Olivia Black', 'Rome', 3, 2006);

INSERT INTO borrowings (borrowing_id, borrow_date, return_date, member_id, librarian_id, book_id) VALUES
(30001, '2023-01-05', '2023-01-10', 1002, 2002, 5001),
(30002, '2022-07-10', '2022-07-17', 1003, 2003, 5002),
(30003, '2021-05-12', '2021-05-20', 1001, 2001, 5003),
(30004, '2020-04-08', '2020-04-15', 1006, 2005, 5004),
(30005, '2024-02-20', '2024-02-20', 1007, 2006, 5005),
(30006, '2023-06-02', '2023-06-12', 1005, 2001, 5001);


SELECT COUNT(*) AS total_borrowings
FROM borrowings
WHERE borrow_date BETWEEN '2020-01-01' AND '2024-12-31';

SELECT AVG(membership_level) AS avg_membership_level
FROM members;

SELECT COUNT(*) AS members_in_new_york
FROM members
WHERE city = 'New York';

SELECT MIN(borrow_date) AS earliest_borrowing_date
FROM borrowings;

SELECT member_name, city
FROM members
WHERE member_name LIKE '%n';

SELECT b.borrowing_id, b.borrow_date, b.return_date, b.member_id, b.book_id, l.name AS librarian_name
FROM borrowings b
JOIN librarians l ON b.librarian_id = l.librarian_id
WHERE l.city = 'Paris'
AND b.borrow_date BETWEEN '2021-01-01' AND '2023-12-31';

SELECT *
FROM borrowings
WHERE borrow_date > '2023-01-01';

SELECT member_id, COUNT(*) AS total_books_borrowed
FROM borrowings
GROUP BY member_id;

SELECT *
FROM members
WHERE membership_level = 3;

SELECT name, commission
FROM librarians
ORDER BY commission DESC
LIMIT 1;
