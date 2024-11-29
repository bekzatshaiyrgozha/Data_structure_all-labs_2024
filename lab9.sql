create database lab9;

--1
CREATE TABLE Reviewer(
    reviewerID INT PRIMARY KEY ,
    name VARCHAR(20)
);

INSERT INTO Reviewer (reviewerID, name) VALUES
        (301,'Alex Johnson'),
        (302,'Maria Gomez'),
        (310,'John Doe'),
        (304,'Linda Brown'),
        (305,'Michael Thompson'),
        (306,'Emily Davis'),
        (307,'Daniel White'),
        (308,'Sophia Lee');



CREATE TABLE Review(
    reviewerID INT,
    movieID INT,
    rating INT,
    reviewDate DATE,
    PRIMARY KEY (reviewerID,movieID),
    FOREIGN KEY (reviewerID) REFERENCES Reviewer(reviewerID),
    FOREIGN KEY (movieID) REFERENCES Movie(movieID)


);

INSERT INTO Review (reviewerID, movieID, rating, reviewDate) VALUES
    (301,401,5,'10-02-24'),
    (301,402,4,'11-02-24'),
    (302,403,5,'11-01-24'),
    (303,404,3,'09-01-24'),
    (304,405,4,'08-01-24'),
    (305,406,2,'01-03-24'),
    (306,407,5,'05-02-24'),
    (307,408,4,'12-03-24');

CREATE TABLE Movie(
    movieID INT PRIMARY KEY ,
    title VARCHAR(100),
    releaseYear INT,
    director VARCHAR(50)
);

INSERT INTO Movie (movieID, title, releaseYear, director) VALUES
        (401,'Future World',2024,'Alice Smith'),
        (402,'The Last Adventure',2024,'John Black'),
        (403,'New Horizons',2024,'Maria Johnson'),
        (404,'Time Capsule',2024,'Chris Martin'),
        (405,'Beyond the Stars',2024,null),
        (406,'The Silent Valley',2024,'Laura Green'),
        (407,'Lost in the Echo',2024,'Daniel White'),
        (408,'Shadow of Destiny',2024,'James Clarke');

---2----

create view more_r_4 as
    select  Movie.releaseYear
from Movie

join Review R on Movie.movieID = R.movieID
where rating >= 4
order by releaseYear;

select *
from more_r_4;

---3---

create index move_id on Movie(movieID);

--4---

create role role_creator with login createrole ;

--5--

grant connect on database lab9 to role_creator;
grant usage on schema public to role_creator;
grant select,insert,update on all tables in schema public to role_creator;

--6
ALTER TABLE public.Review OWNER TO role_creator;
ALTER TABLE public.Movie OWNER TO role_creator;
ALTER TABLE public.Reviewer OWNER TO role_creator;


--7
CREATE VIEW movies_reviewed_2024_rating_5 AS
SELECT
    m.title AS movie_title,
    r.name AS reviewer_name
FROM
    Movie m
JOIN
    Review rv ON m.movieID = rv.movieID
JOIN
    Reviewer r ON rv.reviewerID = r.reviewerID
WHERE
    EXTRACT(YEAR FROM rv.reviewDate) = 2024
    AND rv.rating = 5
ORDER BY
    m.title;