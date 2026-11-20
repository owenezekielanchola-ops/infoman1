# INFOMAN1 — Midterm Practical Assessment: Answer Document

**Name:** Owen Ezekiel A. Anchola  
**Student ID:** 2511003  
**Repository URL:** https://github.com/owenezekielanchola-ops/infoman1  
**Date Submitted:** 11/21/2026

---

## Task 1: Normalization Audit & 3NF Decomposition

### Approach
<!-- Describe how you inspected the flat table and decided on the decomposition order -->
Checked the 7 rows in event_booking_flat, found repeating venues/organizers and comma-listed speakers, then broke it down from 1NF to 3NF.

### 1. Data Anomalies in `event_booking_flat`
<!-- Identify and explain at least one real example of each anomaly in the provided flat table -->

- **Update Anomaly:**
  Repeated data: V-METRO appears in 3 rows. Updating the capacity or city will require editing 3 rows.
- **Insertion Anomaly:**
  We cannot insert new unbooked venues such as V-CAMPUS as booking_id and session_code are the PK and cannot be NULL.
- **Deletion Anomaly:**
  If we delete 103 SESS-A1 we lose the only information about Organizer 3 (Innovate Campus Lab) and AI & Cloud Infrastructure.

### 2. Functional Dependencies
<!-- List all functional dependencies identified in the flat dataset -->
- `(booking_id, session_code) -> ticket_category, ticket_price, tickets_booked`
- `booking_id -> booking_date, event_title, organizer_id, venue_code`
- `organizer_id -> organizer_name, organizer_email`
- `venue_code -> venue_name, venue_city, venue_capacity`
- `(booking_id, session_code) ->> speaker_name`

### 3. Normalization Progression
<!-- Detail each step from unnormalized flat table to 1NF, 2NF, and 3NF -->

- **First Normal Form (1NF)** (include how speakers become atomic rows):
  speaker_list removed to ensure that all data in each cell is atomic. Speakers table created and junction table session_speakers.
- **Second Normal Form (2NF):**
  Columns booking_date, event_title, organiser and venue moved into events table as they only rely on booking_id. Ticket information moved to bookings table.
- **Third Normal Form (3NF):**
  Organizers and venues tables split from events. Reference keys (organizer_id, venue_code) added.

### 4. Final Relational Schema Notation
<!-- Provide the complete relational schema in standard notation: TableName(<u>pk</u>, attr1, attr2, fk_col [FK]) -->
venues(<u>venue_code</u>, venue_name, venue_city, venue_capacity)  
organizers(<u>organizer_id</u>, organizer_name, organizer_email)  
events(<u>booking_id</u>, booking_date, event_title, organizer_id [FK], venue_code [FK])  
bookings(<u>booking_id [FK]</u>, <u>session_code</u>, ticket_category, ticket_price, tickets_booked, booking_status)  
speakers(<u>speaker_id</u>, speaker_name)  
session_speakers(<u>booking_id [FK]</u>, <u>session_code [FK]</u>, <u>speaker_id [FK]</u>)

### Evidence
<!-- Reference the rows of the seed data that demonstrate each anomaly -->
V-METRO appears in 3 rows (101 SESS-A1, 101 SESS-A2, 103 SESS-A1). Row 103 SESS-A1 is the only row with Innovate Campus Lab. Cannot add new venue as both values in primary key are not NULL.

### Reflection
Why does the many-to-many relationship between sessions and speakers require a junction table instead of another column?

Many speakers per session. Many sessions per speaker. Comma separated violates 1NF and limits the number of speakers (speaker1/speaker2). Using a junction table is most appropriate.

---

## Task 2: DDL Implementation with Constraints

### Approach
<!-- Explain your data type choices and constraint definitions (PRIMARY KEY, FOREIGN KEY, NOT NULL, UNIQUE, DEFAULT, CHECK) -->
Tables created with relevant datatypes (INT/VARCHAR/DATE/DECIMAL(8,2)). Primary and foreign keys, NOT NULL constraints. Unique Constraints applied to organizer_email and speaker_name. Default value: CONFIRMED. Data integrity constraints (venue_capacity >0, ticket_price >=0.00).

### Code / Query Used
<!-- Paste or summarize your DDL (full script is in task2_schema_ddl.sql) -->
```sql
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
```

### Evidence: Table Verification (SHOW TABLES / DESCRIBE)
<!-- Paste the verification output of your tables -->
```text
[run in MySQL to fill SHOW TABLES and DESCRIBE outputs]
```

### Reflection
Which table in your schema needed a composite primary key, and why?

Booking_id and session_code required in bookings table as the session code appears in multiple rows (101 & 103). Junction table session_speakers required with booking_id, session_code and speaker_id to avoid duplicates.



---

## Task 3: Data Migration & Safe DML Operations

### Approach
<!-- Explain how you moved data from event_booking_flat into your 3NF tables without data loss, including how speaker names were split -->
Parent tables (venues, organizers, events, bookings, speakers, session_speakers) inserted using SELECT DISTINCT so foreign keys match. List of speakers split into 7 rows, creating 11 rows in junction table.

### Code / Query Used
<!-- Paste or summarize your migration INSERT statements and the V-CAMPUS insert (full script is in task3_dml_operations.sql) -->
```sql
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
```

### Safe Change Loop: 10% Ticket Price Increase
<!-- Document each of the 4 steps of the Safe Change Loop -->

- **Step 1 (Preview Rows):**
  ```sql
  SELECT booking_id, session_code, ticket_category, ticket_price
  FROM bookings
  WHERE ticket_price > 400.00;
  ```
- **Step 2 (Confirm Target Count):**
  4 rows updated: 101 SESS-A1, 101 SESS-A2, 105 SESS-D1, 106 SESS-D2.
- **Step 3 (Execute UPDATE):**
  ```sql
  UPDATE bookings
  SET ticket_price = ROUND(ticket_price * 1.10, 2)
  WHERE ticket_price > 400.00;
  ```
- **Step 4 (Verify Changes):**
  ```sql
  SELECT booking_id, session_code, ticket_category, ticket_price
  FROM bookings;
  ```

### Safe Change Loop: DELETE of `V-TEMP`
- **Step 1 (Preview Rows):**
  ```sql
  INSERT INTO venues (venue_code, venue_name, venue_city, venue_capacity)
  VALUES ('V-TEMP', 'Temporary Annex', 'Makati', 50);

  SELECT * FROM venues WHERE venue_code = 'V-TEMP';
  ```
- **Step 2 (Confirm Target Count):**
  1 row (V-TEMP) deleted.
- **Step 3 (Execute DELETE):**
  ```sql
  DELETE FROM venues WHERE venue_code = 'V-TEMP';
  ```
- **Step 4 (Verify Changes):**
  ```sql
  SELECT * FROM venues WHERE venue_code = 'V-TEMP';
  ```

### Evidence: Constraint Protection Verification
<!-- Show the query attempting to insert invalid data (negative ticket price) and the MySQL error response -->

- **Invalid SQL Statement:**
  ```sql
  INSERT INTO bookings (booking_id, session_code, ticket_category, ticket_price, tickets_booked)
  VALUES (101, 'SESS-ERR', 'Promo', -100.00, 1);
  ```
- **MySQL Error Message Received:**
  ```text
  [run in MySQL to fill actual ERROR 3819 message]
  ```

### Reflection
Why is the `DELETE` targeted by primary key rather than by venue name?

Venue_code is unique. By searching by venue_code we delete only that specific row. Searching by venue_name may delete multiple rows, or none if there is a typo.



---

## Task 4: Filtering, Functions & Aggregate Analytics

### Approach
<!-- Explain how you chose filters, wildcards, and grouping columns -->
Bookings joined with events using OR in brackets (Q1). Events joined with organizers to allow concatenation and DATE difference (Q2). Venue filtering using LIKE (Q3). Booking grouping with HAVING clause (Q4).

### Query 1: Compound Logical Filtering with Precedence
**SQL Query:**
```sql
SELECT b.booking_id, b.session_code, e.booking_date, b.ticket_category, b.ticket_price, b.tickets_booked
FROM bookings b
INNER JOIN events e ON b.booking_id = e.booking_id
WHERE e.booking_date BETWEEN '2025-04-10' AND '2025-04-20'
  AND (b.ticket_category = 'VIP' OR b.ticket_price > 500.00);
```
**Output:**
```text
[run in MySQL to fill]
```

### Query 2: Scalar String & Date Functions
**SQL Query:**
```sql
SELECT e.booking_id, CONCAT(o.organizer_name, ' <', o.organizer_email, '>') AS contact_card, DATEDIFF('2025-05-01', e.booking_date) AS days_elapsed
FROM events e
INNER JOIN organizers o ON e.organizer_id = o.organizer_id;
```
**Output:**
```text
[run in MySQL to fill]
```

### Query 3: Pattern Matching with LIKE Wildcards
**SQL Query:**
```sql
SELECT venue_code, venue_name, venue_city, venue_capacity
FROM venues
WHERE venue_city LIKE '%City' OR venue_city LIKE 'M%';
```
**Output:**
```text
[run in MySQL to fill]
```

### Query 4: GROUP BY and HAVING Summary
**SQL Query:**
```sql
SELECT ticket_category, SUM(tickets_booked) AS total_tickets, SUM(tickets_booked * ticket_price) AS gross_revenue
FROM bookings
GROUP BY ticket_category
HAVING SUM(tickets_booked) >= 5;
```
**Output:**
```text
[run in MySQL to fill]
```

### Reflection
Why does Query 4 filter with `HAVING` instead of `WHERE`?

WHERE clause comes before grouping and so before the SUM of tickets booked. HAVING clause comes after grouping and so removes any VIP bookings with 3 tickets.



---

## Task 5: Multi-Table Joins & Outer Join Diagnostics

### Approach
<!-- Explain which tables you joined, in what order, and which keys you joined on -->
Bookings, events, venues and organisers joined using primary and foreign keys. Idle venues found using LEFT JOIN with IS NULL. Compared where VIP filter is in WHERE clause, or ON clause.

### 1. Multi-Table INNER JOIN
**SQL Query:**
```sql
SELECT e.event_title, o.organizer_name, v.venue_name, b.ticket_category, b.tickets_booked, b.tickets_booked * b.ticket_price AS total_price
FROM bookings b
INNER JOIN events e ON b.booking_id = e.booking_id
INNER JOIN venues v ON e.venue_code = v.venue_code
INNER JOIN organizers o ON e.organizer_id = o.organizer_id;
```
**Output:**
```text
[run in MySQL to fill]
```

### 2. Finding Unbooked Venues (LEFT JOIN ... IS NULL)
**SQL Query:**
```sql
SELECT v.venue_code, v.venue_name, v.venue_city
FROM venues v
LEFT JOIN events e ON v.venue_code = e.venue_code
WHERE e.booking_id IS NULL;
```
**Output:**
```text
[run in MySQL to fill]
```

### 3. The "Silent Inner Join" Trap Comparison
- **Version A (Flawed WHERE filter):**
  ```sql
  SELECT v.venue_code, v.venue_name, b.booking_id, b.session_code, b.ticket_category, b.tickets_booked
  FROM venues v
  LEFT JOIN events e ON v.venue_code = e.venue_code
  LEFT JOIN bookings b ON e.booking_id = b.booking_id
  WHERE b.ticket_category = 'VIP';
  ```
  *Result / Behavior:*
  Version A: 2 rows - V-METRO and V-PARK. V-BAY and V-CAMPUS are omitted.
- **Version B (Correct ON condition):**
  ```sql
  SELECT v.venue_code, v.venue_name, b.booking_id, b.session_code, b.ticket_category, b.tickets_booked
  FROM venues v
  LEFT JOIN events e ON v.venue_code = e.venue_code
  LEFT JOIN bookings b ON e.booking_id = b.booking_id AND b.ticket_category = 'VIP';
  ```
  *Result / Behavior:*
  Version B: 7 rows - All 4 venues included. Where there are no VIP tickets for a venue, NULL is displayed.
- **Technical Explanation:**
  <!-- Why does moving the filter from ON to WHERE strip preserved NULL rows in an outer join? -->
  As WHERE occurs after LEFT JOIN, rows with NULL values will not satisfy ‘VIP’ and so will be omitted (like an INNER JOIN). Adding AND b.ticket_category = ‘VIP’ in the ON clause means that during joining, only VIP bookings are matched. This means all venues remain.

### Reflection
Why is `= NULL` the wrong way to find unbooked venues, and what is the correct test?

Using = NULL will return 0 results. It must be IS NULL.



---

## Task 6: Schema Evolution & Cross-Week Synthesis

### Approach
<!-- Explain how you added venue_status and why you chose the CHECK values -->
Added new column to venues table using ALTER TABLE. Column: venue_status VARCHAR(20), NOT NULL with default of ACTIVE. Check constraint to make sure it can only be ACTIVE/RENOVATION/INACTIVE. Updated V-PARK, tried CLOSED and produced final report.

### 1. ALTER TABLE Statement & Status Constraint
```sql
ALTER TABLE venues
ADD COLUMN venue_status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
ADD CONSTRAINT chk_venue_status CHECK (venue_status IN ('ACTIVE', 'RENOVATION', 'INACTIVE'));
```

### 2. Targeted Primary-Key UPDATE
```sql
UPDATE venues
SET venue_status = 'RENOVATION'
WHERE venue_code = 'V-PARK';
```

### 3. Constraint Test (invalid status)
- **Invalid SQL Statement:**
  ```sql
  UPDATE venues
  SET venue_status = 'CLOSED'
  WHERE venue_code = 'V-BAY';
  ```
- **MySQL Error Message Received:**
  ```text
  [run in MySQL to fill actual ERROR 3819 message]
  ```

### 4. Integrated Synthesis Report Query
**SQL Query:**
```sql
SELECT v.venue_name, v.venue_city, COUNT(*) AS total_bookings, SUM(b.tickets_booked) AS total_attendees, AVG(b.ticket_price) AS avg_ticket_price, SUM(b.tickets_booked * b.ticket_price) AS total_revenue
FROM venues v
INNER JOIN events e ON v.venue_code = e.venue_code
INNER JOIN bookings b ON e.booking_id = b.booking_id
WHERE v.venue_status = 'ACTIVE'
GROUP BY v.venue_name, v.venue_city
HAVING AVG(b.ticket_price) > 300.00
ORDER BY total_revenue DESC;
```
**Output:**
```text
[run in MySQL to fill]
```

### Reflection
Why does adding `NOT NULL DEFAULT 'ACTIVE'` succeed on a table that already holds rows?

Default value of ACTIVE means that for the 4 existing rows, ACTIVE is automatically filled in. Therefore, no rows will be NULL and NOT NULL constraint is satisfied.



---

## Task 7: Self-Review & Reflection

### Self-Audit Checklist
- [x] All three anomalies (update, insert, delete) clearly explained with examples
- [x] Schema systematically normalized from flat table $\rightarrow$ 1NF $\rightarrow$ 2NF $\rightarrow$ 3NF
- [x] Speakers modeled with a junction table
- [x] All primary keys underlined and foreign keys marked in schema notation
- [x] DDL created with `NOT NULL`, `UNIQUE`, `DEFAULT`, and `CHECK` constraints
- [x] 4-step Safe Change Loop followed for the `UPDATE` and the `DELETE`
- [x] Invalid insert correctly triggered and documented MySQL constraint error
- [x] Query 1 properly uses parentheses for `AND` / `OR` operator precedence
- [x] Query 4 properly uses `HAVING` instead of `WHERE` for aggregate filter
- [x] Outer join missing-record query uses `IS NULL` check
- [x] Silent inner join trap clearly explained with both query variations
- [x] `ALTER TABLE` successfully executed and invalid status rejected
- [x] Integrated synthesis report combines joins, aggregation, grouping, and ordering

### Concluding Reflection
1. What was the most significant challenge when decomposing the unnormalized flat table into 3NF, and how did separating entities improve data integrity?
   
   It was hardest to notice that SESS-A1 was repeated in bookings 101 and 103 and to separate speaker_list into session_speakers. Splitting into 6 tables ensured data integrity. In task 6, only 1 row is updated for V-PARK. In task 3, V-CAMPUS can be added as there are no bookings for it. Unique and CHECK constraints prevent poor data.

2. What are the practical performance tradeoffs between keeping a single flat table versus querying multiple normalized tables using `JOIN`s in a high-traffic production environment?
   
   The flat table design allows quick reading of data, however updating data is messy due to duplicated data. The 3NF format allows for clean and quick updates. However, complex reports take slightly longer due to multiple tables needing to be joined (Tasks 5 and 6).
