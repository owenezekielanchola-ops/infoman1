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
