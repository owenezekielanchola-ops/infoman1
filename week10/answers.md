# INFOMAN1 — Week 10 Lab Answers

Name: Owen Ezekiel A. Anchola
Student ID: 2511003
GitHub repo: https://github.com/owenezekielanchola-ops/infoman1
Date submitted: 11/13/2026

## Task 1 — Safe INSERT

**Approach / explanation:**
I made two inserts specifying the columns to be inserted into. After inserting, I did a SELECT statement to ensure they are successfully inserted. The third insert had text in the price column to ensure it fails.

**Code / query used (if applicable):**
```sql
INSERT INTO products (product_name, sku, price, stock_quantity, status)
VALUES ('Scientific Calculator', 'CALC-SCI-001', 850.00, 20, 'Active');

SELECT * FROM products WHERE sku = 'CALC-SCI-001';

INSERT INTO products (product_name, sku, price, stock_quantity, status)
VALUES ('Compass', 'CMP-001', 120.00, 50, 'Active');

SELECT * FROM products WHERE sku = 'CMP-001';

INSERT INTO products (product_name, sku, price, stock_quantity, status)
VALUES ('Marker', 'MK-001', 'free', 10, 'Active');
```

**Evidence (screenshot filename, output, or file reference in this folder):**
`task1_output.txt`

The first two inserts executed successfully and appeared in the SELECT statements. However, the third insert failed as the price column was DECIMAL(10,2) and could not contain ‘free’.

**Reflection question:**
_[Why does listing target columns explicitly make an INSERT safer, and what fills in for columns you omit?]_
When you explicitly state the columns you will be inserting into, it ensures it will not fail if columns are moved around, or more are added. Columns not specified will take on their default value, auto increment value or NULL if allowed.

## Task 2 — UPDATE & DELETE Without Collateral Damage

**Approach / explanation:**
I used the product ID to look at the row before updating/deleting. Then used the same WHERE clause to update/delete. Finally, a SELECT statement to ensure it is updated/deleted.

**Code / query used (if applicable):**
```sql
SELECT product_id, product_name, price FROM products WHERE product_id = 6;
UPDATE products SET price = 875.00 WHERE product_id = 6;
SELECT product_id, product_name, price FROM products WHERE product_id = 6;

SELECT product_id, product_name, sku FROM products WHERE product_id = 5;
DELETE FROM products WHERE product_id = 5;
SELECT product_id, product_name, sku FROM products WHERE product_id = 5;
```

**Evidence (screenshot filename, output, or file reference in this folder):**
`task2_output.txt`

The calculator (product_id = 6) successfully updated its price from 850.00 to 875.00. The eraser (product_id = 5) successfully deleted and verified with an empty set. If there was no WHERE clause, it would have updated all products to 875.00 and attempted to delete all rows.

**Reflection question:**
_[What would your UPDATE and DELETE have done without their WHERE clauses, and why is a stable identifier safer than a name?]_
Without the WHERE clause it would have updated all prices and deleted all rows. Using a primary key such as product_id is safer as the IDs are unique and you will not accidentally have duplicate names.

## Task 3 — Self Join & Cross Join

**Approach / explanation:**
(a) Used a self join on the employees table with two aliases (e & m). Used a LEFT JOIN to join e.manager_id to m.employee_id. (b) Used a CROSS JOIN to join the colours and sizes tables.

**Code / query used (if applicable):**
```sql
SELECT e.employee_name AS employee, m.employee_name AS manager
FROM employees AS e
LEFT JOIN employees AS m ON e.manager_id = m.employee_id;

SELECT c.color_name, s.size_name
FROM colors c
CROSS JOIN sizes s;
```

**Evidence (screenshot filename, output, or file reference in this folder):**
`task3_output.txt`

The query (a) returned 3 rows. Lea Ramos was still present with a NULL value as we used a LEFT JOIN. The query (b) returned 9 rows. This is intended as it can create variations of colour & size for notebooks. This should never happen by accident as there is no ON clause.

**Reflection question:**
_[Why does the self join need two aliases and a LEFT JOIN, and when is a CROSS JOIN the deliberate choice rather than a missing ON?]_
Two aliases were needed as MySQL would not know which row was the employee and which was the manager. The LEFT JOIN included Lea as she does not have a manager. The CROSS JOIN is intentional when you want all possible combinations such as creating a catalogue of sizes and colours.

## Task 4 — Constraints & Table Evolution

**Approach / explanation:**
I added a contact_number column to the products table. I also added NOT NULL to product_name, UNIQUE to sku and CHECK (price > 0) using ALTER TABLE. For each rule I did a valid and invalid insert.

**Code / query used (if applicable):**
```sql
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
```

**Evidence (screenshot filename, output, or file reference in this folder):**
`task4_output.txt`

The valid inserts all went through. However, the invalid inserts failed due to the product_name having a NULL value, sku having a duplicate NB-001 and price having a value of 0.00. As this is MySQL, to add NOT NULL you have to use MODIFY COLUMN and restate the VARCHAR(100). Older versions of MySQL do not allow the CHECK rule so I tested 0.00 to see if it was enforced on this server.

**Reflection question:**
_[Why do constraints block future bad writes without repairing old bad rows, and what must you do before adding NOT NULL?]_
Constraints only check new inserts and will not automatically update old rows. Before adding NOT NULL you must search for any NULL values and either update or delete them.

## Task 5 — Reflection

**Approach / explanation:**
Compare application rules to database constraints used in previous tasks. Mention the error I made in task 3.

**Code / query used (if applicable):**
```sql
-- paste your SQL (or Java/JDBC, for Week 13+) here
```

**Evidence (screenshot filename, output, or file reference in this folder):**
Application rules would be used for things like friendly validation on forms, such as checking text formatting before the user clicks submit. However, for rules to protect the data itself, I would always use constraints on the database. As anyone can bypass a form with a different script or SQL. In task 4 we added UNIQUE to sku and CHECK (price > 0) to the products table. Even if the web form for a book store broke, or a direct insert was used, MySQL would still not allow duplicates for SKU and 0 prices.

An error I noticed in task 3 was not using separate aliases for the self join. Initially I tried to do a self join on the employees table without using separate aliases and MySQL gave an error stating the table/column was not unique and was ambiguous. I fixed this by adding aliases to each table (e & m) and adding e. or m. to all columns in the SELECT and ON clauses.

**Reflection question:**
_[When would you trust the application form versus the database constraint to enforce a rule, and what single symptom would tell you the wrong layer was trusted?]_
Trust the application form for UX and formatting. Trust the constraints for data integrity. Bad data would appear in the table such as duplicate SKUs and 0 prices.

## Self-Check

- [x] All tasks committed with individual, meaningful commit messages
- [x] All files placed inside `week10/`
- [x] This file completed and renamed `answers.md`
- [x] Repository link pasted into Moodle (no files uploaded)
