# INFOMAN1 — Week 11 Lab Answers

Name: Owen Ezekiel A. Anchola
Student ID: 2511003
GitHub repo: https://github.com/owenezekielanchola-ops/infoman1
Date submitted: 11/14/2026

## Task 1 — Diagnose the Anomalies

**Approach / explanation:**
I ran SELECT queries on student_enrollment to count D01 rows, check for IT103, and inspect IT102 before any delete.

**Code / query used (if applicable):**
```sql
SELECT student_id, course_id, dept_id, department_name
FROM student_enrollment
WHERE dept_id = 'D01';

SELECT *
FROM student_enrollment
WHERE course_id = 'IT103';

SELECT course_id, course_title, dept_id, department_name
FROM student_enrollment
WHERE course_id = 'IT102';
```

**Evidence (screenshot filename, output, or file reference in this folder):**
`task1_output.txt`

a) Updating D01 would require editing 3 rows due to repeating department information in each row. (D01 is present in 3 rows)
b) IT103 cannot be added as it isn’t present. A dummy student or NULL values would have to be added to the fields. (Course information is locked in the enrollment table)
c) IT102 can only be found in Ana’s row. Therefore deleting it will remove IT102 (Web Development) along with the D01 relationship. (Course information is locked within the enrollment table)

**Reflection question:**
_[Which of the three anomalies surprised you most in the seed table, and what single structural fact causes all three?]_
I was most shocked by the deletion issue as you lose an entire course by just deleting one row. All 3 issues are down to having a single table containing all the information about students, enrollments, courses and departments.

## Task 2 — Reach First Normal Form

**Approach / explanation:**
_[Write 2–4 sentences describing how you solved this task.]_

**Code / query used (if applicable):**
```sql
-- paste your SQL (or Java/JDBC, for Week 13+) here
```

**Evidence (screenshot filename, output, or file reference in this folder):**
_[e.g. `task2_output.png`, or paste console/query output here.]_

**Reflection question:**
_[Why does splitting the multi-valued cell still leave student names repeating, and which normal form removes that next?]_

## Task 3 — Reach Second Normal Form

**Approach / explanation:**
_[Write 2–4 sentences describing how you solved this task.]_

**Code / query used (if applicable):**
```sql
-- paste your SQL (or Java/JDBC, for Week 13+) here
```

**Evidence (screenshot filename, output, or file reference in this folder):**
_[e.g. `task3_output.png`, or paste console/query output here.]_

**Reflection question:**
_[How do you tell that student name depends on part of the key while grade depends on the whole key?]_

## Task 4 — Reach Third Normal Form

**Approach / explanation:**
_[Write 2–4 sentences describing how you solved this task.]_

**Code / query used (if applicable):**
```sql
-- paste your SQL (or Java/JDBC, for Week 13+) here
```

**Evidence (screenshot filename, output, or file reference in this folder):**
_[e.g. `task4_output.png`, or paste console/query output here.]_

**Reflection question:**
_[What makes the department name indirectly dependent, and how does the final four-table join prove nothing was lost?]_

## Task 5 — Reflection

**Approach / explanation:**
_[Write 2–4 sentences describing how you solved this task.]_

**Code / query used (if applicable):**
```sql
-- paste your SQL (or Java/JDBC, for Week 13+) here
```

**Evidence (screenshot filename, output, or file reference in this folder):**
_[e.g. `task5_reflection.txt`, or paste your 150–200 word reflection here.]_

**Reflection question:**
_[When would you keep some denormalized repetition on purpose, and what single symptom tells you a split dropped a key?]_

## Self-Check

- [ ] All tasks committed with individual, meaningful commit messages
- [ ] All files placed inside `week11/`
- [ ] This file completed and renamed `answers.md`
- [ ] Repository link pasted into Moodle (no files uploaded)
