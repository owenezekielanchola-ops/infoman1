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
