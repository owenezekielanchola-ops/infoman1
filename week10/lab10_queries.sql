USE infoman1_bookstore;

INSERT INTO products (product_name, sku, price, stock_quantity, status)
VALUES ('Scientific Calculator', 'CALC-SCI-001', 850.00, 20, 'Active');

SELECT * FROM products WHERE sku = 'CALC-SCI-001';

INSERT INTO products (product_name, sku, price, stock_quantity, status)
VALUES ('Compass', 'CMP-001', 120.00, 50, 'Active');

SELECT * FROM products WHERE sku = 'CMP-001';

INSERT INTO products (product_name, sku, price, stock_quantity, status)
VALUES ('Marker', 'MK-001', 'free', 10, 'Active');

SELECT product_id, product_name, price FROM products WHERE product_id = 6;
UPDATE products SET price = 875.00 WHERE product_id = 6;
SELECT product_id, product_name, price FROM products WHERE product_id = 6;

SELECT product_id, product_name, sku FROM products WHERE product_id = 5;
DELETE FROM products WHERE product_id = 5;
SELECT product_id, product_name, sku FROM products WHERE product_id = 5;

SELECT e.employee_name AS employee, m.employee_name AS manager
FROM employees AS e
LEFT JOIN employees AS m ON e.manager_id = m.employee_id;

SELECT c.color_name, s.size_name
FROM colors c
CROSS JOIN sizes s;
