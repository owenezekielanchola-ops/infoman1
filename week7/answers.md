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
_[Write 2–4 sentences describing how you solved this task.]_

**Code / query used (if applicable):**
```sql
-- paste your SQL here
```

**Evidence (screenshot filename, output, or file reference in this folder):**
_[e.g. `task3_output.png`, or paste console/query output here.]_

**Reflection question:**
Why is column aliasing particularly important when using mathematical or date functions in the `SELECT` clause?
_[Your answer here]_

---

## Task 4 — Comprehensive Data Audit

**Approach / explanation:**
_[Write 2–4 sentences describing how you solved this task.]_

**Code / query used (if applicable):**
```sql
-- paste your SQL here
```

**Evidence (screenshot filename, output, or file reference in this folder):**
_[e.g. `task4_output.png`, or paste console/query output here.]_

**Reflection question:**
Explain how MySQL evaluates the expression `A OR B AND C`. How did you use parentheses (if you did) to ensure your query filtered the exact data requested in the instructions?
_[Your answer here]_

---

## Self-Check

- [ ] All tasks committed with individual, meaningful commit messages
- [ ] All files placed inside `week07/`
- [ ] This file completed and renamed `answers.md`
- [ ] Repository link pasted into Moodle (no files uploaded)