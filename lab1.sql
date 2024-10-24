CREATE DATABASE  lab1;

CREATE TABLE clients (
    client_id serial PRIMARY KEY,
    firstname varchar(60),
    lastname varchar(60),
    email varchar(100),
    date_joined date
);

alter table clients
    add column status int CHECK (status IN (0, 1));

ALTER TABLE clients
DROP CONSTRAINT clients_status_check ;

ALTER TABLE clients
ALTER COLUMN status TYPE BOOLEAN
USING status::BOOLEAN;

ALTER TABLE clients
ALTER COLUMN status SET DEFAULT TRUE;

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    order_name VARCHAR(100),
    client_id INTEGER,
    FOREIGN KEY (client_id) REFERENCES clients(client_id)
);

drop table orders;

drop database lab1;





