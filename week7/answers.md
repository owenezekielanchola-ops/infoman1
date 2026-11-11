# INFOMAN1 — Week 7 Lab Answers


## Task 1 — Complex Student Roster

**Approach / explanation:**
I chose to filter through `first_name`, `last_name` and `major`. I used `IN` on the `major` column to check if it was one of the majors and `LIKE 'S%'` on the `last_name` to check if it started with an S. I added `AND NOT section = 'Online'` so that I could exclude online students.

**Code / query used (if applicable):**
```sql
SELECT first_name, last_name, major
FROM students
WHERE major IN ('Computer Science', 'Information Technology')
  AND last_name LIKE 'S%'
  AND NOT section = 'Online';
```

**Evidence (screenshot filename, output, or file reference in this folder):**
`task1_output.png`

**Reflection question:**
Why is it often better to use the `IN` operator rather than chaining multiple `OR` conditions when filtering by a specific list of values?
It is much cleaner and more readable using `IN`. Using a long string of `OR` can get confusing and messy. It is easy to make a typo with having to type out the column name repeatedly.

---

## Task 2 — Formatting Employee Data

**Approach / explanation:**
I used `LEFT(first_name, 1)` to get the first letter, `ROUND(salary)` to round salary. Then I put them into `CONCAT` alongside the punctuation required to match the example output. The column was then given an alias of `Instructor Details` and `LIMIT 5` was used to only display 5 rows.

**Code / query used (if applicable):**
```sql
SELECT CONCAT(LEFT(first_name, 1), '. ', last_name, ' ($', ROUND(salary), ')') AS `Instructor Details`
FROM instructors
LIMIT 5;
```

**Evidence (screenshot filename, output, or file reference in this folder):**
```text
+---------------------+
| Instructor Details  |
+---------------------+
| J. Smith ($55001)   |
| M. Santos ($62500)  |
| R. Johnson ($49000) |
| A. Reyes ($71250)   |
| P. Cruz ($47001)    |
+---------------------+
```

**Reflection question:**
How do string functions like `CONCAT` affect the performance of a query compared to retrieving raw columns and formatting them in the application layer (e.g., in Java or Python)?
Using `CONCAT` in SQL will require extra CPU usage by the server. If there are thousands of rows it is usually better to simply get the raw data and format it in Python/Java. However in this case there is not much of a difference.

---

## Task 3 — Project Deadline Analysis

**Approach / explanation:**
I have calculated the number of days per assignment by using `DATEDIFF(due_date, assigned_date)`, creating a column called `Days_To_Complete`. The `WHERE` statement is filtering out assignments to only show ones that are longer than 14 days. Finally I have ordered my results in descending order using `ORDER BY Days_To_Complete DESC`.

**Code / query used (if applicable):**
```sql
SELECT assignment_name, DATEDIFF(due_date, assigned_date) AS Days_To_Complete
FROM assignments
WHERE DATEDIFF(due_date, assigned_date) > 14
ORDER BY Days_To_Complete DESC;
```

**Evidence (screenshot filename, output, or file reference in this folder):**
`task3_output.png`

**Reflection question:**
Why is column aliasing particularly important when using mathematical or date functions in the `SELECT` clause?
If you do not assign an alias to your column, MySQL will take the entire formula from `DATEDIFF(...)` as the column name. This can look untidy and cause issues when trying to use it in an `ORDER BY` statement or in application code. By assigning an alias it becomes clean and easy to understand.

---

## Task 4 — Comprehensive Data Audit

**Approach / explanation:**
I selected the columns I wanted to display (`course_code`, `course_name`, `credits`) from the table `courses` whilst adding parentheses around `IS NULL` and `BETWEEN 4 AND 6`. This causes MySQL to check the `OR` before the `AND course_code LIKE '%ADV%'`. Finally, I ordered it in alphabetical order using the column `course_name`.

**Code / query used (if applicable):**
```sql
SELECT course_code, course_name, credits
FROM courses
WHERE (course_description IS NULL OR credits BETWEEN 4 AND 6)
  AND course_code LIKE '%ADV%'
ORDER BY course_name ASC;
```

**Evidence (screenshot filename, output, or file reference in this folder):**
```text
+-------------+----------------------------+---------+
| course_code | course_name                | credits |
+-------------+----------------------------+---------+
| CS-ADV305   | Advanced Algorithms        |       4 |
| CS-ADV400   | Advanced Capstone Project  |       6 |
| CS-ADV101   | Advanced Database Systems  |       5 |
| IT-ADV210   | Advanced Networking        |       3 |
| ENG-ADV110  | Advanced Technical Writing |       2 |
| IT-ADV150   | Advanced Web Development   |       6 |
+-------------+----------------------------+---------+
```
Precedence explanation: `AND` runs before `OR` by default, so I wrapped `(course_description IS NULL OR credits BETWEEN 4 AND 6)` in parentheses to make MySQL evaluate the `OR` conditions first before filtering with `AND course_code LIKE '%ADV%'`.

**Reflection question:**
Explain how MySQL evaluates the expression `A OR B AND C`. How did you use parentheses (if you did) to ensure your query filtered the exact data requested in the instructions?
The `AND` always comes first as it has higher precedence. This means that `A OR B AND C` will be interpreted as `A OR (B AND C)`. Putting parentheses around `IS NULL` and `BETWEEN` ensures that the `OR` condition is checked first by MySQL. Without parentheses any course with a null description would have shown up regardless of there being no `'ADV'` in the code.

---

## Self-Check

- [x] All tasks committed with individual, meaningful commit messages
- [x] All files placed inside `week07/`
- [x] This file completed and renamed `answers.md`
- [x] Repository link pasted into Moodle (no files uploaded)