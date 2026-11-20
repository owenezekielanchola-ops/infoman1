USE eventhub_midterm;

SELECT b.booking_id, b.session_code, e.booking_date, b.ticket_category, b.ticket_price, b.tickets_booked
FROM bookings b
INNER JOIN events e ON b.booking_id = e.booking_id
WHERE e.booking_date BETWEEN '2025-04-10' AND '2025-04-20'
  AND (b.ticket_category = 'VIP' OR b.ticket_price > 500.00);
/*
+------------+--------------+--------------+-----------------+--------------+----------------+
| booking_id | session_code | booking_date | ticket_category | ticket_price | tickets_booked |
+------------+--------------+--------------+-----------------+--------------+----------------+
|        101 | SESS-A1      | 2025-04-10   | Standard        |       550.00 |              4 |
|        101 | SESS-A2      | 2025-04-10   | VIP             |      1320.00 |              2 |
|        105 | SESS-D1      | 2025-04-20   | VIP             |      1650.00 |              1 |
+------------+--------------+--------------+-----------------+--------------+----------------+
3 rows in set (0.014 sec)
*/

SELECT e.booking_id, CONCAT(o.organizer_name, ' <', o.organizer_email, '>') AS contact_card, DATEDIFF('2025-05-01', e.booking_date) AS days_elapsed
FROM events e
INNER JOIN organizers o ON e.organizer_id = o.organizer_id;
/*
+------------+-------------------------------------------------+--------------+
| booking_id | contact_card                                    | days_elapsed |
+------------+-------------------------------------------------+--------------+
|        101 | Tech Forward PH <info@techforward.ph>           |           21 |
|        102 | Green Earth Initiative <contact@greenearth.org> |           19 |
|        104 | Green Earth Initiative <contact@greenearth.org> |           13 |
|        103 | Innovate Campus Lab <lead@innovatecampus.edu>   |           16 |
|        105 | Digital Health Alliance <care@digitalhealth.ph> |           11 |
|        106 | Digital Health Alliance <care@digitalhealth.ph> |            9 |
+------------+-------------------------------------------------+--------------+
6 rows in set (0.011 sec)
*/

SELECT venue_code, venue_name, venue_city, venue_capacity
FROM venues
WHERE venue_city LIKE '%City' OR venue_city LIKE 'M%';
/*
+------------+-------------------------+-------------+----------------+
| venue_code | venue_name              | venue_city  | venue_capacity |
+------------+-------------------------+-------------+----------------+
| V-BAY      | Bayview Convention Hall | Manila      |            150 |
| V-CAMPUS   | University Amphitheater | Quezon City |            500 |
| V-METRO    | Metro Tech Auditorium   | Quezon City |            300 |
+------------+-------------------------+-------------+----------------+
3 rows in set (0.007 sec)
*/

SELECT ticket_category, SUM(tickets_booked) AS total_tickets, SUM(tickets_booked * ticket_price) AS gross_revenue
FROM bookings
GROUP BY ticket_category
HAVING SUM(tickets_booked) >= 5;
/*
+-----------------+---------------+---------------+
| ticket_category | total_tickets | gross_revenue |
+-----------------+---------------+---------------+
| Standard        |            18 |       8960.00 |
| Student         |            10 |       2500.00 |
+-----------------+---------------+---------------+
2 rows in set (0.010 sec)
*/
