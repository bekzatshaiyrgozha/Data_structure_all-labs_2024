create database lab4;

CREATE TABLE Warehouses (
    code INTEGER PRIMARY KEY,
    location VARCHAR(255),
    capacity INTEGER
);

CREATE TABLE Boxes (
    code CHAR(4) PRIMARY KEY,
    contents VARCHAR(255),
    value REAL,
    warehouse INTEGER,
    FOREIGN KEY (warehouse) REFERENCES Warehouses(code)
);





INSERT INTO Warehouses(code, location, capacity) VALUES(1, 'Chicago', 3);
INSERT INTO Warehouses(code, location, capacity) VALUES(2, 'Rocks', 4);
INSERT INTO Warehouses(code, location, capacity) VALUES(3, 'New York', 7);
INSERT INTO Warehouses(code, location, capacity) VALUES(4, 'Los Angeles', 2);
INSERT INTO Warehouses(code, location, capacity) VALUES(5, 'San Francisko', 8);

INSERT INTO Boxes(code, contents, value, warehouse) VALUES ('0MN7', 'Rocks', 180, 3);
INSERT INTO Boxes(code, contents, value, warehouse) VALUES ('4H8P', 'Rocks', 250, 1);
INSERT INTO Boxes(code, contents, value, warehouse) VALUES ('4RT3', 'Scissors', 190, 4);
INSERT INTO Boxes(code, contents, value, warehouse) VALUES ('7G3H', 'Rocks', 200, 1);
INSERT INTO Boxes(code, contents, value, warehouse) VALUES ('8JN6', 'Papers', 75, 1);
INSERT INTO Boxes(code, contents, value, warehouse) VALUES ('8Y6U', 'Papers', 50, 3);
INSERT INTO Boxes(code, contents, value, warehouse) VALUES ('9J6F', 'Papers', 175, 2);
INSERT INTO Boxes(code, contents, value, warehouse) VALUES ('LL08', 'Rocks', 140, 4);
INSERT INTO Boxes(code, contents, value, warehouse) VALUES ('P0H6', 'Scissors', 125, 1);
INSERT INTO Boxes(code, contents, value, warehouse) VALUES ('P2T6', 'Scissors', 150, 2);
INSERT INTO Boxes(code, contents, value, warehouse) VALUES ('TUSS', 'Papers', 90, 5);

select * from Warehouses;

select * from boxes
where value>150;

SELECT DISTINCT contents FROM Boxes;

select Boxes.warehouse , count(*) number_warehouse from boxes
group by warehouse;

select Boxes.warehouse,count(*) number_box from boxes
group by warehouse
having count(*)>2;

insert into warehouses(code, location, capacity) VALUES
                                                     (6,'New York',3);

insert into boxes(code, contents, value, warehouse) VALUES
                                                        ('H5RT','Papers',200,2);

update boxes
set value = value - value*15/100
where code =(
    select code from boxes
                order by value desc
                limit 1 offset 2
    );

DELETE FROM Boxes
WHERE value < 150;

DELETE FROM Boxes
USING Warehouses
WHERE Boxes.warehouse = Warehouses.code AND Warehouses.location = 'New York'
RETURNING boxes.*;
