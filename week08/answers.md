# INFOMAN1 — Week 8 Lab Answers

Name: Owen Ezekiel A. Anchola
Student ID: 2511003
GitHub repo: https://github.com/owenezekielanchola-ops/infoman1
Date submitted: 11/12/2026

**Dataset check:** `SELECT COUNT(*) FROM employee;` returned: 500

## Task 1 — Pattern Matching Basics

**Approach / explanation:**
I used the `LIKE` operator with the `%` and `_` wildcards to filter the employee table using different text patterns. First, I ran `'%ez'` to get last names ending with "ez" and `'Ma%'` to find first names starting with "Ma". Next, I used four underscores in `'E____'` to confirm that all 500 employee codes are 5 characters long, and then ran `'E_0__'` to find the codes with 0 as the third character.

**Code / query used (if applicable):**
```sql
SELECT emp_id, first_name, last_name FROM employee WHERE last_name LIKE '%ez';

SELECT emp_id, first_name, department FROM employee WHERE last_name LIKE 'Ma%';

SELECT emp_id, emp_code, first_name, last_name FROM employee WHERE emp_code LIKE 'E____';

SELECT emp_code, first_name, last_name FROM employee WHERE emp_code LIKE 'E_0__';
```

**Evidence (screenshot filename, output, or file reference in this folder):**
Full text copies of all four result sets are saved in `task1_output.txt`.

- **Query 1.1 (`LIKE '%ez'`):** Returned **161 rows**.
- **Query 1.2 (`LIKE 'Ma%'`):** Returned **111 rows**.
- **Query 1.3a (`LIKE 'E____'`):** Returned **500 rows** (confirms all 500 codes are 5 characters starting with `E`).
- **Query 1.3b (`LIKE 'E_0__'`):** Returned **48 rows**:
```text
+----------+------------+------------+
| emp_code | first_name | last_name  |
+----------+------------+------------+
| E9042    | Isabel     | Cruz       |
| E1041    | John       | Navarro    |
| E9032    | Leo        | Tolentino  |
| E6062    | Jacob      | Morales    |
| E7043    | Matthew    | Jimenez    |
| E9045    | Vanessa    | Gutierrez  |
| E8035    | Matthew    | Soriano    |
| E6040    | Liam       | Mendoza    |
| E8095    | Maricel    | Dela Cruz  |
| E9020    | Olivia     | Pascual    |
| E2053    | Emma       | Perez      |
| E7064    | Oscar      | Perez      |
| E1003    | Lucia      | Velasquez  |
| E5060    | Oscar      | Castillo   |
| E1084    | Liam       | Salazar    |
| E9060    | Rico       | Rivera     |
| E6013    | Bianca     | Tan        |
| E4088    | Isabel     | Morales    |
| E4047    | Helen      | Pascual    |
| E4067    | Mario      | Lim        |
| E1080    | Yna        | Salazar    |
| E4039    | Hannah     | Navarro    |
| E2047    | Walter     | Ramos      |
| E2030    | Gabriel    | Morales    |
| E6077    | Maricel    | Villanueva |
| E3015    | Sara       | Aquino     |
| E3004    | Noel       | Gutierrez  |
| E3010    | Jacob      | Martinez   |
| E3059    | John       | Cruz       |
| E3069    | Hannah     | Ramirez    |
| E3051    | John       | Gomez      |
| E4005    | Carmen     | Tolentino  |
| E4078    | Dennis     | Martinez   |
| E1087    | Olivia     | Bautista   |
| E6025    | Carmen     | Mendoza    |
| E6085    | Lara       | Villanueva |
| E4091    | Maria      | Ortiz      |
| E1032    | Victor     | Domingo    |
| E2042    | Liam       | Navarro    |
| E7029    | Liam       | Mendoza    |
| E5065    | Mavis      | Santos     |
| E3072    | Marisol    | Mendoza    |
| E5047    | Matthew    | Reyes      |
| E8087    | Karen      | Chua       |
| E9080    | Victor     | Morales    |
| E3090    | Maria      | Rodriguez  |
| E8066    | Olivia     | Chua       |
| E3019    | Jose       | Martinez   |
+----------+------------+------------+
48 rows in set
```

**Reflection question:**
_[Why do we use the `%` wildcard instead of the `_` wildcard when searching for fields containing a specific keyword?]_
We use the `%` wildcard because it can look for any amount of characters, including none. The `_` wildcard can only look for one character at a time. You will not be able to use the `_` wildcard unless you know the exact length of text.

## Task 2 — Basic Aggregation

**Approach / explanation:**
Using aggregate functions (`COUNT`, `SUM`, `AVG`, `MIN`, and `MAX`), I was able to analyze the employee table and hire date range. The employee table shows a large discrepancy (148 rows) between the values for `COUNT(*)` (500) and `COUNT(commission)` (352). This is because the `COUNT(*)` function displays the total number of rows in the table, whereas `COUNT(commission)` excludes any `NULL` values. In Query 2.4, it was necessary to use `COALESCE(commission, 0)` because if you add any number to a `NULL` value in SQL, it will give `NULL`. Therefore, if we did not change any `NULL` values to `0`, we would not have included those 148 employees' base salaries in the `SUM`.

**Code / query used (if applicable):**
```sql
SELECT COUNT(*) AS total_employees, COUNT(commission) AS employees_with_commission FROM employee;

SELECT SUM(salary) AS total_monthly_payroll FROM employee;

SELECT AVG(salary) AS avg_salary, MIN(hire_date) AS earliest_hire, MAX(hire_date) AS latest_hire FROM employee;

SELECT SUM(salary + COALESCE(commission, 0)) AS total_compensation FROM employee;
```

**Evidence (screenshot filename, output, or file reference in this folder):**
```text
+-----------------+---------------------------+
| total_employees | employees_with_commission |
+-----------------+---------------------------+
|             500 |                       352 |
+-----------------+---------------------------+
1 row in set

+-----------------------+
| total_monthly_payroll |
+-----------------------+
|           33282250.00 |
+-----------------------+
1 row in set

+--------------+---------------+-------------+
| avg_salary   | earliest_hire | latest_hire |
+--------------+---------------+-------------+
| 66564.500000 | 2015-01-03    | 2026-09-14  |
+--------------+---------------+-------------+
1 row in set

+--------------------+
| total_compensation |
+--------------------+
|        35387750.00 |
+--------------------+
1 row in set
```

**Reflection question:**
_[What is the difference between `COUNT(*)` and `COUNT(column_name)`?]_
The difference between the two is that `COUNT(*)` will count all of the rows in the result set, regardless of any `NULL` values in the columns. However, `COUNT(column_name)` will only count the number of rows where there is a non-`NULL` value in that particular column.

## Task 3 — Grouping Data

**Approach / explanation:**
I used `GROUP BY department` in my first query in conjunction with `COUNT(*)`, `AVG(salary)`, and `COUNT(DISTINCT job_title)` to show the number of employees, average pay, and unique roles in each department. My second query grouped by `department` and `job_title` together to show the exact number of people in each role.

**Code / query used (if applicable):**
```sql
SELECT department, COUNT(*) AS headcount, AVG(salary) AS avg_salary, COUNT(DISTINCT job_title) AS distinct_titles FROM employee GROUP BY department;

SELECT department, job_title, COUNT(*) AS headcount FROM employee GROUP BY department, job_title;
```

**Evidence (screenshot filename, output, or file reference in this folder):**
```text
+-------------+-----------+--------------+-----------------+
| department  | headcount | avg_salary   | distinct_titles |
+-------------+-----------+--------------+-----------------+
| Sales       |       144 | 71799.652778 |               3 |
| Engineering |       125 | 75160.000000 |               3 |
| HR          |        50 | 62610.000000 |               3 |
| Finance     |        69 | 79513.043478 |               3 |
| Support     |       112 | 44028.571429 |               3 |
+-------------+-----------+--------------+-----------------+
5 rows in set

+-------------+----------------------+-----------+
| department  | job_title            | headcount |
+-------------+----------------------+-----------+
| Sales       | Sales Manager        |        49 |
| Sales       | Account Manager      |        50 |
| Engineering | QA Analyst           |        39 |
| Sales       | Sales Representative |        45 |
| Engineering | Software Engineer    |        44 |
| Engineering | DevOps Engineer      |        42 |
| HR          | HR Specialist        |        20 |
| HR          | Recruiter            |        12 |
| Finance     | Financial Analyst    |        24 |
| Finance     | Finance Manager      |        24 |
| Support     | Support Lead         |        29 |
| HR          | HR Manager           |        18 |
| Support     | Support Specialist   |        43 |
| Finance     | Accountant           |        21 |
| Support     | Support Agent        |        40 |
+-------------+----------------------+-----------+
15 rows in set
```

**Reflection question:**
_[Why is it generally invalid to include columns in the `SELECT` list that are not in the `GROUP BY` clause, unless they are inside an aggregate function?]_
Using `GROUP BY` in your query will cause SQL to combine rows. If you include a column in your `SELECT` list that is not in the `GROUP BY` clause, then there are many different values in that column. As such, SQL will not know what value to display.

## Task 4 — Advanced Filtering with HAVING

**Approach / explanation:**
_[Write 2–4 sentences describing how you solved this task.]_

**Code / query used (if applicable):**
```sql
-- paste your SQL here
```

**Evidence (screenshot filename, output, or file reference in this folder):**
_[e.g. `task4_output.png`, or paste console/query output here.]_

**Reflection question:**
_[Why must we use the `HAVING` clause here instead of the `WHERE` clause to filter by the average value?]_

## Self-Check

- [ ] All tasks committed with individual, meaningful commit messages
- [ ] All files placed inside `week08/`
- [ ] This file completed and renamed `answers.md`
- [ ] Repository link pasted into Moodle (no files uploaded)