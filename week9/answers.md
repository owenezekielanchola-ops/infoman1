# INFOMAN1 — Week 9 Lab Answers

Name: Owen Ezekiel A. Anchola
Student ID: 2511003
GitHub repo: https://github.com/owenezekielanchola-ops/infoman1
Date submitted: 11/13/2026

## Task 1 — INNER JOIN Basics

**Approach / explanation:**
I used an INNER JOIN on `student_id` and sorted by `order_id`. Only Ana and Dan show up since they're the only buyers.

**Code / query used (if applicable):**
```sql
SELECT s.student_name, s.program, o.order_id, o.order_date
FROM students s
INNER JOIN orders o ON s.student_id = o.student_id
ORDER BY o.order_id;
```

**Evidence (screenshot filename, output, or file reference in this folder):**
`task1_output.txt` (3 rows: Ana 101, Ana 102, Dan 103)

**Reflection question:**
_[Why does an INNER JOIN hide students who never ordered, and when is that exactly the behavior a sales report wants?]_
As it only shows rows where there are matches between the two tables, and Ben and Cara don't have any orders. This is what we want for a sales report as we only want to see people who have bought something.

## Task 2 — Finding Missing Relationships

**Approach / explanation:**
(a) is a LEFT JOIN so all four students show, with NULL for non-buyers. (b) adds `WHERE o.order_id IS NULL`.

**Code / query used (if applicable):**
```sql
SELECT s.student_name, s.program, o.order_id, o.order_date
FROM students s
LEFT JOIN orders o ON s.student_id = o.student_id;

SELECT s.student_name, s.program, o.order_id, o.order_date
FROM students s
LEFT JOIN orders o ON s.student_id = o.student_id
WHERE o.order_id IS NULL;
```

**Evidence (screenshot filename, output, or file reference in this folder):**
`task2_output.txt` ((a) 5 rows, (b) 2 rows)

(b) only shows Ben Lim and Cara Yu, as they don't have any rows in the orders table.

**Reflection question:**
_[What does NULL mean in the unmatched columns of a LEFT JOIN, and why must you test it with IS NULL instead of equals?]_
It means there isn't a matching order. We can't use = NULL as it will return unknown rather than true. So therefore we use IS NULL.

## Task 3 — Four-Table Canteen Report

**Approach / explanation:**
I joined all four tables with their own ON on `student_id`, `order_id` and `menu_id`. Every column has an alias in front, and `line_total` is `oi.quantity * mi.price`.

**Code / query used (if applicable):**
```sql
SELECT s.student_name, s.program, o.order_id, mi.item_name, oi.quantity, mi.price, oi.quantity * mi.price AS line_total
FROM students s
INNER JOIN orders o ON s.student_id = o.student_id
INNER JOIN order_items oi ON o.order_id = oi.order_id
INNER JOIN menu_items mi ON oi.menu_id = mi.menu_id
ORDER BY o.order_id, mi.item_name;
```

**Evidence (screenshot filename, output, or file reference in this folder):**
`task3_output.txt` (4 rows)

**Reflection question:**
_[Why does each JOIN in a multi-table chain need its own ON condition, and what goes wrong when two joins share one?]_
We have to have individual ON clauses for each table so they can be joined using their key. If 2 tables shared the same ON clause, the table wouldn't be joined properly, causing duplicates and incorrect totals.
