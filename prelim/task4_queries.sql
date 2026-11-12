USE toolshare_prelim;

-- 1. Tools in the 'Power Tools' category
SELECT tool_name, category
FROM tool
WHERE category = 'Power Tools';
/*
+----------------+-------------+
| tool_name      | category    |
+----------------+-------------+
| Cordless Drill | Power Tools |
| Circular Saw   | Power Tools |
| Angle Grinder  | Power Tools |
+----------------+-------------+
3 rows in set
*/

-- 2. Members who joined after January 1, 2025
SELECT member_id, member_name, phone, join_date
FROM member
WHERE join_date > '2025-01-01';
/*
+-----------+-------------+-------------+------------+
| member_id | member_name | phone       | join_date  |
+-----------+-------------+-------------+------------+
|         2 | Jose Rizal  | 09179876543 | 2025-02-10 |
|         3 | Ana Reyes   | 09172223333 | 2025-06-01 |
|         5 | Liza Gomez  | 09175556666 | 2025-01-15 |
|         6 | Kevin Lim   | 09176667777 | 2025-08-05 |
+-----------+-------------+-------------+------------+
4 rows in set
*/

-- 3. Borrowing records currently on loan (return_date IS NULL)
SELECT borrow_id, member_id, tool_id, borrow_date, return_date
FROM borrowing
WHERE return_date IS NULL;
/*
+-----------+-----------+---------+-------------+-------------+
| borrow_id | member_id | tool_id | borrow_date | return_date |
+-----------+-----------+---------+-------------+-------------+
|         2 |         1 |       2 | 2025-09-12  | NULL        |
|         3 |         2 |       7 | 2025-09-05  | NULL        |
+-----------+-----------+---------+-------------+-------------+
2 rows in set
*/

-- 4. Borrowing records for member_id = 1 (Maria Santos)
SELECT borrow_id, member_id, tool_id, borrow_date, return_date
FROM borrowing
WHERE member_id = 1;
/*
+-----------+-----------+---------+-------------+-------------+
| borrow_id | member_id | tool_id | borrow_date | return_date |
+-----------+-----------+---------+-------------+-------------+
|         1 |         1 |       1 | 2025-09-01  | 2025-09-10  |
|         2 |         1 |       2 | 2025-09-12  | NULL        |
+-----------+-----------+---------+-------------+-------------+
2 rows in set
*/

-- 5. Tools purchased before January 1, 2024
SELECT tool_id, tool_name, category, purchase_date, location_code
FROM tool
WHERE purchase_date < '2024-01-01';
/*
+---------+----------------+-------------+---------------+---------------+
| tool_id | tool_name      | category    | purchase_date | location_code |
+---------+----------------+-------------+---------------+---------------+
|       1 | Cordless Drill | Power Tools | 2023-05-10    | A3            |
|       2 | Circular Saw   | Power Tools | 2023-08-22    | A3            |
|       4 | Garden Shovel  | Garden      | 2023-12-01    | B1            |
+---------+----------------+-------------+---------------+---------------+
3 rows in set
*/
