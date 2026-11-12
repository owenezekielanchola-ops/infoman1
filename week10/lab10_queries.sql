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

ALTER TABLE products ADD COLUMN contact_number VARCHAR(20);

ALTER TABLE products MODIFY COLUMN product_name VARCHAR(100) NOT NULL;
INSERT INTO products (product_name, sku, price, stock_quantity, status)
VALUES ('Highlighter', 'HL-001', 35.00, 40, 'Active');
INSERT INTO products (product_name, sku, price, stock_quantity, status)
VALUES (NULL, 'HL-002', 35.00, 40, 'Active');

ALTER TABLE products ADD CONSTRAINT uq_products_sku UNIQUE (sku);
INSERT INTO products (product_name, sku, price, stock_quantity, status)
VALUES ('Folder', 'FD-001', 12.00, 60, 'Active');
INSERT INTO products (product_name, sku, price, stock_quantity, status)
VALUES ('Duplicate Notebook', 'NB-001', 45.00, 10, 'Active');

ALTER TABLE products ADD CONSTRAINT chk_products_price CHECK (price > 0);
INSERT INTO products (product_name, sku, price, stock_quantity, status)
VALUES ('Correction Tape', 'CT-001', 28.00, 30, 'Active');
INSERT INTO products (product_name, sku, price, stock_quantity, status)
VALUES ('Free Pen', 'FP-001', 0.00, 10, 'Active');
