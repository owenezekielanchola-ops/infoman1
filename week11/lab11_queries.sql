USE infoman1_normalization;

SELECT student_id, course_id, dept_id, department_name
FROM student_enrollment
WHERE dept_id = 'D01';

SELECT *
FROM student_enrollment
WHERE course_id = 'IT103';

SELECT course_id, course_title, dept_id, department_name
FROM student_enrollment
WHERE course_id = 'IT102';

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
