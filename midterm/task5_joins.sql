USE eventhub_midterm;

SELECT e.event_title, o.organizer_name, v.venue_name, b.ticket_category, b.tickets_booked, b.tickets_booked * b.ticket_price AS total_price
FROM bookings b
INNER JOIN events e ON b.booking_id = e.booking_id
INNER JOIN venues v ON e.venue_code = v.venue_code
INNER JOIN organizers o ON e.organizer_id = o.organizer_id;

SELECT v.venue_code, v.venue_name, v.venue_city
FROM venues v
LEFT JOIN events e ON v.venue_code = e.venue_code
WHERE e.booking_id IS NULL;

SELECT v.venue_code, v.venue_name, b.booking_id, b.session_code, b.ticket_category, b.tickets_booked
FROM venues v
LEFT JOIN events e ON v.venue_code = e.venue_code
LEFT JOIN bookings b ON e.booking_id = b.booking_id
WHERE b.ticket_category = 'VIP';

SELECT v.venue_code, v.venue_name, b.booking_id, b.session_code, b.ticket_category, b.tickets_booked
FROM venues v
LEFT JOIN events e ON v.venue_code = e.venue_code
LEFT JOIN bookings b ON e.booking_id = b.booking_id AND b.ticket_category = 'VIP';
