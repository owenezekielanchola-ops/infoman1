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
