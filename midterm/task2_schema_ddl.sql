USE eventhub_midterm;

CREATE TABLE venues (
    venue_code VARCHAR(20) PRIMARY KEY,
    venue_name VARCHAR(100) NOT NULL,
    venue_city VARCHAR(50) NOT NULL,
    venue_capacity INT NOT NULL,
    CONSTRAINT chk_venue_capacity CHECK (venue_capacity > 0)
);

CREATE TABLE organizers (
    organizer_id INT PRIMARY KEY,
    organizer_name VARCHAR(100) NOT NULL,
    organizer_email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE events (
    booking_id INT PRIMARY KEY,
    booking_date DATE NOT NULL,
    event_title VARCHAR(150) NOT NULL,
    organizer_id INT NOT NULL,
    venue_code VARCHAR(20) NOT NULL,
    FOREIGN KEY (organizer_id) REFERENCES organizers(organizer_id),
    FOREIGN KEY (venue_code) REFERENCES venues(venue_code)
);

CREATE TABLE bookings (
    booking_id INT NOT NULL,
    session_code VARCHAR(20) NOT NULL,
    ticket_category VARCHAR(50) NOT NULL,
    ticket_price DECIMAL(8,2) NOT NULL,
    tickets_booked INT NOT NULL,
    booking_status VARCHAR(20) NOT NULL DEFAULT 'CONFIRMED',
    PRIMARY KEY (booking_id, session_code),
    FOREIGN KEY (booking_id) REFERENCES events(booking_id),
    CONSTRAINT chk_ticket_price CHECK (ticket_price >= 0.00)
);

CREATE TABLE speakers (
    speaker_id INT AUTO_INCREMENT PRIMARY KEY,
    speaker_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE session_speakers (
    booking_id INT NOT NULL,
    session_code VARCHAR(20) NOT NULL,
    speaker_id INT NOT NULL,
    PRIMARY KEY (booking_id, session_code, speaker_id),
    FOREIGN KEY (booking_id, session_code) REFERENCES bookings(booking_id, session_code),
    FOREIGN KEY (speaker_id) REFERENCES speakers(speaker_id)
);

SHOW TABLES;
DESCRIBE venues;
DESCRIBE organizers;
DESCRIBE events;
DESCRIBE bookings;
DESCRIBE speakers;
DESCRIBE session_speakers;
