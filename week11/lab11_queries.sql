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
