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
Create enrollment_1nf without enrolled_courses. Add the primary key (student_id, course_id). Insert 3 rows. Perform a SELECT.

**Code / query used (if applicable):**
```sql
CREATE TABLE enrollment_1nf (
  student_id INT NOT NULL,
  student_name VARCHAR(100) NOT NULL,
  course_id VARCHAR(10) NOT NULL,
  course_title VARCHAR(100) NOT NULL,
  dept_id VARCHAR(10) NOT NULL,
  department_name VARCHAR(100) NOT NULL,
  grade DECIMAL(4,2) NOT NULL,
  PRIMARY KEY (student_id, course_id)
);

INSERT INTO enrollment_1nf VALUES
(101, 'Ana Cruz', 'IT101', 'Database Systems', 'D01', 'Computing Studies', 1.50),
(102, 'Ben Lim', 'IT101', 'Database Systems', 'D01', 'Computing Studies', 1.75),
(101, 'Ana Cruz', 'IT102', 'Web Development', 'D01', 'Computing Studies', 1.25);

SELECT * FROM enrollment_1nf;
```

**Evidence (screenshot filename, output, or file reference in this folder):**
`task2_output.txt`

All values in the table are now single values. There are 3 rows in the table with the primary key (student_id, course_id). There is still some redundant information in the 1NF table. Student name (Ana Cruz), Course Title (Database Systems), and Department ID (D01) and Name (Computing Studies) are all duplicated.

**Reflection question:**
_[Why does splitting the multi-valued cell still leave student names repeating, and which normal form removes that next?]_
Each row represents one enrollment. However if a student has 2 courses they will still be duplicated. This will be resolved in 2NF by separating the columns that only partally depend on the key.

## Task 3 — Reach Second Normal Form

**Approach / explanation:**
Listed the composite key. Showed dependencies. Split into 3 tables; students, courses (stage), enrollments. Joined the tables to recreate the report.

**Code / query used (if applicable):**
```sql
CREATE TABLE students (
  student_id INT PRIMARY KEY,
  student_name VARCHAR(100) NOT NULL
);

CREATE TABLE courses (
  course_id VARCHAR(10) PRIMARY KEY,
  course_title VARCHAR(100) NOT NULL,
  dept_id VARCHAR(10) NOT NULL,
  department_name VARCHAR(100) NOT NULL
);

CREATE TABLE enrollments (
  student_id INT NOT NULL,
  course_id VARCHAR(10) NOT NULL,
  grade DECIMAL(4,2) NOT NULL,
  PRIMARY KEY (student_id, course_id),
  FOREIGN KEY (student_id) REFERENCES students(student_id),
  FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

INSERT INTO students SELECT DISTINCT student_id, student_name FROM enrollment_1nf;
INSERT INTO courses SELECT DISTINCT course_id, course_title, dept_id, department_name FROM enrollment_1nf;
INSERT INTO enrollments SELECT student_id, course_id, grade FROM enrollment_1nf;

SELECT s.student_id, s.student_name, c.course_id, c.course_title, c.dept_id, c.department_name, e.grade
FROM enrollments e
INNER JOIN students s ON e.student_id = s.student_id
INNER JOIN courses c ON e.course_id = c.course_id;
```

**Evidence (screenshot filename, output, or file reference in this folder):**
`task3_output.txt`

Composite Key: (student_id, course_id)
Dependencies: student_id → student_name (Partial Dependency). course_id → course_title, dept_id, department_name (Partial Dependency). (student_id, course_id) → grade (Full Dependency).
The grade remains as a full dependency as it refers to a particular student and course.

**Reflection question:**
_[How do you tell that student name depends on part of the key while grade depends on the whole key?]_
student_id alone will provide student_name (101 will always be Ana Cruz). Grade requires both student_id and course_id. (101 has a grade of 1.50 in IT101 and 1.25 in IT102)

## Task 4 — Reach Third Normal Form

**Approach / explanation:**
Created a departments table. Removed department_name from courses with a foreign key on dept_id. Checked all 4 tables. Performed a 4 way JOIN.

**Code / query used (if applicable):**
```sql
CREATE TABLE departments (
  dept_id VARCHAR(10) PRIMARY KEY,
  department_name VARCHAR(100) NOT NULL
);

INSERT INTO departments SELECT DISTINCT dept_id, department_name FROM courses;

ALTER TABLE courses
DROP COLUMN department_name,
ADD CONSTRAINT fk_courses_dept FOREIGN KEY (dept_id) REFERENCES departments(dept_id);

SELECT s.student_name, c.course_title, d.department_name, e.grade
FROM enrollments e
INNER JOIN students s ON e.student_id = s.student_id
INNER JOIN courses c ON e.course_id = c.course_id
INNER JOIN departments d ON c.dept_id = d.dept_id;
```

**Evidence (screenshot filename, output, or file reference in this folder):**
`task4_output.txt`

Transitive Dependency: course_id → dept_id → department_name.
Students: No Multi Valued, Partial or Transitive Dependencies. (3NF)
Departments: No Multi Valued, Partial or Transitive Dependencies. (3NF)
Courses: No Multi Valued, Partial or Transitive Dependencies. (3NF)
Enrollments: No Multi Valued, Partial or Transitive Dependencies. (3NF)
All 3 complete rows are returned.

**Reflection question:**
_[What makes the department name indirectly dependent, and how does the final four-table join prove nothing was lost?]_
department_name now depends on dept_id rather than course_id. A 4 way JOIN was performed and all 3 original rows were returned showing no information was lost.

## Task 5 — Reflection

**Approach / explanation:**
I compared when to put a table into 3NF and when to intentionally leave it in a denormalised state. I also noted a mistake I made regarding foreign keys.

**Code / query used (if applicable):**
```sql
-- paste your SQL (or Java/JDBC, for Week 13+) here
```

**Evidence (screenshot filename, output, or file reference in this folder):**
If this was a system for enrolling students on campus, I would put the table into 3NF. This is because students, courses, and departments will be added/updated regularly. In Task 1, the table wasn’t split so there was an update anomaly (changing department name D01 meant changing 3 rows) and delete anomaly (Ana’s IT102 row was deleted so course was deleted). By splitting the table into students, courses, departments and enrollments (Task 4), this removes the anomalies. I would intentionally leave the table in a denormalised state if it was a read only summary table. This is because I may want to keep student name in a snapshot of their old transcript so reports can be pulled quicker.

A mistake I noticed was thinking foreign keys were causing redundancy. I originally thought that D01 was repeating so the table wasn’t in 3NF. This meant I felt I needed to remove dept_id from the courses. To fix this I referred back to the 3NF rule. Dept_id is a foreign key and needs to stay in the table so it can be joined. Only department_name needs to be moved.

**Reflection question:**
_[When would you keep some denormalized repetition on purpose, and what single symptom tells you a split dropped a key?]_
If the table is intentionally left in a denormalised state, this should be done if it is a read only report or snapshot. This is because speed of reading data is a priority. If a split drops a key, the tables cannot be joined properly and will return missing rows or incorrect duplicates.

## Self-Check

- [x] All tasks committed with individual, meaningful commit messages
- [x] All files placed inside `week11/`
- [x] This file completed and renamed `answers.md`
- [x] Repository link pasted into Moodle (no files uploaded)
