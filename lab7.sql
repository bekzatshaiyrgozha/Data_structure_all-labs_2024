create  database  lab7;


CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2)
);


CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100)
);


CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    order_total DECIMAL(10, 2)
);


CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    product_id INT REFERENCES products(product_id),
    quantity INT
);



INSERT INTO products (product_name, price) VALUES
('Product A', 10.00),
('Product B', 20.00),
('Product C', 15.00);

INSERT INTO customers (first_name, last_name, email) VALUES
('John', 'Doe', 'john.doe@example.com'),
('Jane', 'Smith', 'jane.smith@example.com'),
('Alice', 'Brown', 'alice.brown@example.com');

INSERT INTO orders (customer_id, order_total) VALUES
(1, 50.00),
(2, 75.00),
(3, 60.00);

INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 2),
(1, 2, 1),
(2, 3, 4),
(3, 2, 2);


-----1-----
CREATE INDEX idx_products_product_name
ON products (product_name);
SELECT * FROM products WHERE product_name = 'Product A';

-----2-----
CREATE INDEX idx_customers_first_last_name
ON customers (first_name, last_name);
SELECT * FROM customers WHERE first_name = 'John' AND last_name = 'Doe';

-------3----
CREATE UNIQUE INDEX idx_orders_order_total
ON orders (order_total);
SELECT * FROM orders WHERE order_total BETWEEN 50.00 AND 100.00;

-----4----
CREATE INDEX idx_customers_lower_email
ON customers (email);
SELECT * FROM customers WHERE LOWER(email) = 'john.doe@example.com';

-----5---
CREATE INDEX idx_orders_items_order_total_quantity
ON orders (order_total);

CREATE INDEX idx_order_items_quantity
ON order_items (quantity);


SELECT * FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_total > 50.00 AND oi.quantity < 3;
