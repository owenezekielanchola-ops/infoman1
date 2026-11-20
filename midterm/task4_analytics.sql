USE eventhub_midterm;

SELECT b.booking_id, b.session_code, e.booking_date, b.ticket_category, b.ticket_price, b.tickets_booked
FROM bookings b
INNER JOIN events e ON b.booking_id = e.booking_id
WHERE e.booking_date BETWEEN '2025-04-10' AND '2025-04-20'
  AND (b.ticket_category = 'VIP' OR b.ticket_price > 500.00);

SELECT e.booking_id, CONCAT(o.organizer_name, ' <', o.organizer_email, '>') AS contact_card, DATEDIFF('2025-05-01', e.booking_date) AS days_elapsed
FROM events e
INNER JOIN organizers o ON e.organizer_id = o.organizer_id;

SELECT venue_code, venue_name, venue_city, venue_capacity
FROM venues
WHERE venue_city LIKE '%City' OR venue_city LIKE 'M%';

SELECT ticket_category, SUM(tickets_booked) AS total_tickets, SUM(tickets_booked * ticket_price) AS gross_revenue
FROM bookings
GROUP BY ticket_category
HAVING SUM(tickets_booked) >= 5;
