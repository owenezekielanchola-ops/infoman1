# INFOMAN1 — Week 9 Lab Answers

Name: Owen Ezekiel A. Anchola
Student ID: 2511003
GitHub repo: https://github.com/owenezekielanchola-ops/infoman1
Date submitted: 11/13/2026

## Task 1 — INNER JOIN Basics

**Approach / explanation:**
I used an INNER JOIN on `student_id` and sorted by `order_id`. Only Ana and Dan show up since they're the only buyers.

**Code / query used (if applicable):**
```sql
SELECT s.student_name, s.program, o.order_id, o.order_date
FROM students s
INNER JOIN orders o ON s.student_id = o.student_id
ORDER BY o.order_id;
```

**Evidence (screenshot filename, output, or file reference in this folder):**
`task1_output.txt` (3 rows: Ana 101, Ana 102, Dan 103)

**Reflection question:**
_[Why does an INNER JOIN hide students who never ordered, and when is that exactly the behavior a sales report wants?]_
As it only shows rows where there are matches between the two tables, and Ben and Cara don't have any orders. This is what we want for a sales report as we only want to see people who have bought something.
