# INFOMAN1 — Week 8 Lab Answers

Name: 
Student ID: 
GitHub repo: https://github.com/<STUDENT_GITHUB_USERNAME>/infoman1
Date submitted: 

**Dataset check:** `SELECT COUNT(*) FROM employee;` returned: 500

## Task 1 — Pattern Matching Basics

**Approach / explanation:**
I used the `LIKE` operator with the `%` and `_` wildcards to filter the employee table by different text patterns. First, I ran `'%ez'` to grab last names ending in "ez" and `'Ma%'` for first names starting with "Ma". After that, I used four underscores in `'E____'` to prove all 500 employee codes have 5 characters, and then used `'E_0__'` to find codes where the third character is 0.

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
Why do we use the % wildcard rather than the _ wildcard? We use the % wildcard because it can look for any amount of characters including none. The _ wildcard can only look for one character at a time. You will not be able to use the _ wildcard unless you know the exact length of text.

## Task 2 — Basic Aggregation

**Approach / explanation:**
_[Write 2–4 sentences describing how you solved this task.]_

**Code / query used (if applicable):**
```sql
-- paste your SQL here
```

**Evidence (screenshot filename, output, or file reference in this folder):**
_[e.g. `task2_output.png`, or paste console/query output here.]_

**Reflection question:**
_[What is the difference between `COUNT(*)` and `COUNT(column_name)`?]_

## Task 3 — Grouping Data

**Approach / explanation:**
_[Write 2–4 sentences describing how you solved this task.]_

**Code / query used (if applicable):**
```sql
-- paste your SQL here
```

**Evidence (screenshot filename, output, or file reference in this folder):**
_[e.g. `task3_output.png`, or paste console/query output here.]_

**Reflection question:**
_[Why is it generally invalid to include columns in the `SELECT` list that are not in the `GROUP BY` clause, unless they are inside an aggregate function?]_

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