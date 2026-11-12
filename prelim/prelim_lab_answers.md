# INFOMAN1 — Prelim Lab Exam Answers

## Task 3: Data Type Justifications
1. `location_code VARCHAR(10)`
Storage codes are alphanumeric (e.g. 'A3', 'B1', 'C2') therefore we need to store them as `VARCHAR(10)` rather than `INT`.
2. `phone VARCHAR(20)`
Phone numbers contain a leading number (e.g. '09171234567'). Using `INT` will cause the first number to be dropped. It also exceeds the maximum 32-bit limit for `INT`. Also phone numbers aren’t used in any mathematical calculations. Therefore it makes sense to store them as `VARCHAR(20)`.

## Task 5: Debug a Cross-Week Mismatch

### 1. Why the Original Query Fails
This query (SELECT borrow_date, return_date FROM borrowing WHERE member_name = 'Maria Santos'; ) will fail with an error: Unknown column 'member_name' in 'where clause'.
- **Week 3 (Relational Schema Design):** As we have resolved the M:N relationship between the member and tool tables, using the borrowing table. We still need to keep the member_name field in the member table, so that there is no duplication of data. The borrowing table only contains the member_id field as a Foreign Key (FK).
- **Week 4 (DDL Implementation):** When creating the borrowing table (CREATE TABLE borrowing) we only CREATE the following columns: borrow_id, member_id, tool_id, borrow_date, return_date. As there is no member_name column in the borrowing table, this will fail.

### 2. Corrected Single-Table Queries
We can first run a query on the member table to find the member_id for Maria Santos:
```sql
SELECT member_id, member_name
FROM member
WHERE member_name = 'Maria Santos';
```
Result: `member_id = 1`

Second, query the `borrowing` table using `member_id = 1`:
```sql
SELECT borrow_date, return_date
FROM borrowing
WHERE member_id = 1;
```
Result:
```text
+-------------+-------------+
| borrow_date | return_date |
+-------------+-------------+
| 2025-09-01  | 2025-09-10  |
| 2025-09-12  | NULL        |
+-------------+-------------+
2 rows in set
```

### 3. Week 5 Concept Illustrated
This demonstrates column scoping when using a single-table SELECT ... FROM ... WHERE statement. As a single-table SELECT statement can only filter based on columns within the table in the FROM section (borrowing) we need to find out what member_id values are present in member first. The tables are distinct and joined using the Primary Key - Foreign Key (member_id).

## Task 6: Video Walkthrough Link
https://youtu.be/XfFq-AHbFVI