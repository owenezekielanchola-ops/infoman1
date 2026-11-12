USE infoman1_canteen;

SELECT s.student_name, s.program, o.order_id, o.order_date
FROM students s
INNER JOIN orders o ON s.student_id = o.student_id
ORDER BY o.order_id;

SELECT s.student_name, s.program, o.order_id, o.order_date
FROM students s
LEFT JOIN orders o ON s.student_id = o.student_id;

SELECT s.student_name, s.program, o.order_id, o.order_date
FROM students s
LEFT JOIN orders o ON s.student_id = o.student_id
WHERE o.order_id IS NULL;

SELECT s.student_name, s.program, o.order_id, mi.item_name, oi.quantity, mi.price, oi.quantity * mi.price AS line_total
FROM students s
INNER JOIN orders o ON s.student_id = o.student_id
INNER JOIN order_items oi ON o.order_id = oi.order_id
INNER JOIN menu_items mi ON oi.menu_id = mi.menu_id
ORDER BY o.order_id, mi.item_name;
