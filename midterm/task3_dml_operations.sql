USE eventhub_midterm;

INSERT INTO venues (venue_code, venue_name, venue_city, venue_capacity)
SELECT DISTINCT venue_code, venue_name, venue_city, venue_capacity
FROM event_booking_flat;

INSERT INTO organizers (organizer_id, organizer_name, organizer_email)
SELECT DISTINCT organizer_id, organizer_name, organizer_email
FROM event_booking_flat;

INSERT INTO events (booking_id, booking_date, event_title, organizer_id, venue_code)
SELECT DISTINCT booking_id, booking_date, event_title, organizer_id, venue_code
FROM event_booking_flat;

INSERT INTO bookings (booking_id, session_code, ticket_category, ticket_price, tickets_booked)
SELECT booking_id, session_code, ticket_category, ticket_price, tickets_booked
FROM event_booking_flat;

INSERT INTO speakers (speaker_id, speaker_name) VALUES
(1, 'Dr. Perez'),
(2, 'Engr. Cruz'),
(3, 'Prof. Santos'),
(4, 'Ms. Lim'),
(5, 'Dr. Reyes'),
(6, 'Dr. Aquino'),
(7, 'Engr. Tan');

INSERT INTO session_speakers (booking_id, session_code, speaker_id) VALUES
(101, 'SESS-A1', 1),
(101, 'SESS-A1', 2),
(101, 'SESS-A2', 2),
(102, 'SESS-B1', 3),
(103, 'SESS-A1', 1),
(103, 'SESS-A1', 4),
(104, 'SESS-C1', 3),
(104, 'SESS-C1', 5),
(105, 'SESS-D1', 6),
(106, 'SESS-D2', 6),
(106, 'SESS-D2', 7);

INSERT INTO venues (venue_code, venue_name, venue_city, venue_capacity)
VALUES ('V-CAMPUS', 'University Amphitheater', 'Quezon City', 500);

SELECT booking_id, session_code, ticket_category, ticket_price
FROM bookings
WHERE ticket_price > 400.00;

SELECT COUNT(*) AS target_count
FROM bookings
WHERE ticket_price > 400.00;

UPDATE bookings
SET ticket_price = ROUND(ticket_price * 1.10, 2)
WHERE ticket_price > 400.00;

SELECT booking_id, session_code, ticket_category, ticket_price
FROM bookings;

INSERT INTO venues (venue_code, venue_name, venue_city, venue_capacity)
VALUES ('V-TEMP', 'Temporary Annex', 'Makati', 50);

SELECT * FROM venues WHERE venue_code = 'V-TEMP';

SELECT COUNT(*) AS target_count FROM venues WHERE venue_code = 'V-TEMP';

DELETE FROM venues WHERE venue_code = 'V-TEMP';

SELECT * FROM venues WHERE venue_code = 'V-TEMP';

INSERT INTO bookings (booking_id, session_code, ticket_category, ticket_price, tickets_booked)
VALUES (101, 'SESS-ERR', 'Promo', -100.00, 1);
