# INFOMAN1 — Midterm Practical Assessment: Answer Document

**Name:** Owen Ezekiel A. Anchola  
**Student ID:** 2511003  
**Repository URL:** https://github.com/owenezekielanchola-ops/infoman1  
**Date Submitted:** 11/21/2026

---

## Task 1: Normalization Audit & 3NF Decomposition

### Approach
Checked the 7 rows in event_booking_flat, found repeating venues/organizers and comma-listed speakers, then broke it down from 1NF to 3NF.

### 1. Data Anomalies in `event_booking_flat`

- **Update Anomaly:**
  Repeated data: V-METRO appears in 3 rows. Updating the capacity or city will require editing 3 rows.
- **Insertion Anomaly:**
  We cannot insert new unbooked venues such as V-CAMPUS as booking_id and session_code are the PK and cannot be NULL.
- **Deletion Anomaly:**
  If we delete 103 SESS-A1 we lose the only information about Organizer 3 (Innovate Campus Lab) and AI & Cloud Infrastructure.

### 2. Functional Dependencies
- `(booking_id, session_code) -> ticket_category, ticket_price, tickets_booked`
- `booking_id -> booking_date, event_title, organizer_id, venue_code`
- `organizer_id -> organizer_name, organizer_email`
- `venue_code -> venue_name, venue_city, venue_capacity`
- `(booking_id, session_code) ->> speaker_name`

### 3. Normalization Progression

- **First Normal Form (1NF)** (include how speakers become atomic rows):
  speaker_list removed to ensure that all data in each cell is atomic. Speakers table created and junction table session_speakers.
- **Second Normal Form (2NF):**
  Columns booking_date, event_title, organiser and venue moved into events table as they only rely on booking_id. Ticket information moved to bookings table.
- **Third Normal Form (3NF):**
  Organizers and venues tables split from events. Reference keys (organizer_id, venue_code) added.

### 4. Final Relational Schema Notation
venues(<u>venue_code</u>, venue_name, venue_city, venue_capacity)  
organizers(<u>organizer_id</u>, organizer_name, organizer_email)  
events(<u>booking_id</u>, booking_date, event_title, organizer_id [FK], venue_code [FK])  
bookings(<u>booking_id [FK]</u>, <u>session_code</u>, ticket_category, ticket_price, tickets_booked, booking_status)  
speakers(<u>speaker_id</u>, speaker_name)  
session_speakers(<u>booking_id [FK]</u>, <u>session_code [FK]</u>, <u>speaker_id [FK]</u>)

### Evidence
V-METRO appears in 3 rows (101 SESS-A1, 101 SESS-A2, 103 SESS-A1). Row 103 SESS-A1 is the only row with Innovate Campus Lab. Cannot add new venue as both values in primary key are not NULL.

### Reflection
Why does the many-to-many relationship between sessions and speakers require a junction table instead of another column?

Many speakers per session. Many sessions per speaker. Comma separated violates 1NF and limits the number of speakers (speaker1/speaker2). Using a junction table is most appropriate.

---

## Task 2: DDL Implementation with Constraints

### Approach
<!-- Explain your data type choices and constraint definitions (PRIMARY KEY, FOREIGN KEY, NOT NULL, UNIQUE, DEFAULT, CHECK) -->



### Code / Query Used
<!-- Paste or summarize your DDL (full script is in task2_schema_ddl.sql) -->

```sql
```

### Evidence: Table Verification (SHOW TABLES / DESCRIBE)
<!-- Paste the verification output of your tables -->

```sql
```

### Reflection
Which table in your schema needed a composite primary key, and why?



---

## Task 3: Data Migration & Safe DML Operations

### Approach
<!-- Explain how you moved data from event_booking_flat into your 3NF tables without data loss, including how speaker names were split -->



### Code / Query Used
<!-- Paste or summarize your migration INSERT statements and the V-CAMPUS insert (full script is in task3_dml_operations.sql) -->

```sql
```

### Safe Change Loop: 10% Ticket Price Increase
<!-- Document each of the 4 steps of the Safe Change Loop -->

- **Step 1 (Preview Rows):**
  ```sql
  ```
- **Step 2 (Confirm Target Count):**
  
- **Step 3 (Execute UPDATE):**
  ```sql
  ```
- **Step 4 (Verify Changes):**
  ```sql
  ```

### Safe Change Loop: DELETE of `V-TEMP`
- **Step 1 (Preview Rows):**
  ```sql
  ```
- **Step 2 (Confirm Target Count):**
  
- **Step 3 (Execute DELETE):**
  ```sql
  ```
- **Step 4 (Verify Changes):**
  ```sql
  ```

### Evidence: Constraint Protection Verification
<!-- Show the query attempting to insert invalid data (negative ticket price) and the MySQL error response -->

- **Invalid SQL Statement:**
  ```sql
  ```
- **MySQL Error Message Received:**
  ```
  ```

### Reflection
Why is the `DELETE` targeted by primary key rather than by venue name?



---

## Task 4: Filtering, Functions & Aggregate Analytics

### Approach
<!-- Explain how you chose filters, wildcards, and grouping columns -->



### Query 1: Compound Logical Filtering with Precedence
**SQL Query:**
```sql
```
**Output:**
```
```

### Query 2: Scalar String & Date Functions
**SQL Query:**
```sql
```
**Output:**
```
```

### Query 3: Pattern Matching with LIKE Wildcards
**SQL Query:**
```sql
```
**Output:**
```
```

### Query 4: GROUP BY and HAVING Summary
**SQL Query:**
```sql
```
**Output:**
```
```

### Reflection
Why does Query 4 filter with `HAVING` instead of `WHERE`?



---

## Task 5: Multi-Table Joins & Outer Join Diagnostics

### Approach
<!-- Explain which tables you joined, in what order, and which keys you joined on -->



### 1. Multi-Table INNER JOIN
**SQL Query:**
```sql
```
**Output:**
```
```

### 2. Finding Unbooked Venues (LEFT JOIN ... IS NULL)
**SQL Query:**
```sql
```
**Output:**
```
```

### 3. The "Silent Inner Join" Trap Comparison
- **Version A (Flawed WHERE filter):**
  ```sql
  ```
  *Result / Behavior:*
  
- **Version B (Correct ON condition):**
  ```sql
  ```
  *Result / Behavior:*
  
- **Technical Explanation:**
  <!-- Why does moving the filter from ON to WHERE strip preserved NULL rows in an outer join? -->
  

### Reflection
Why is `= NULL` the wrong way to find unbooked venues, and what is the correct test?



---

## Task 6: Schema Evolution & Cross-Week Synthesis

### Approach
<!-- Explain how you added venue_status and why you chose the CHECK values -->



### 1. ALTER TABLE Statement & Status Constraint
```sql
```

### 2. Targeted Primary-Key UPDATE
```sql
```

### 3. Constraint Test (invalid status)
- **Invalid SQL Statement:**
  ```sql
  ```
- **MySQL Error Message Received:**
  ```
  ```

### 4. Integrated Synthesis Report Query
**SQL Query:**
```sql
```
**Output:**
```
```

### Reflection
Why does adding `NOT NULL DEFAULT 'ACTIVE'` succeed on a table that already holds rows?



---

## Task 7: Self-Review & Reflection

### Self-Audit Checklist
- [ ] All three anomalies (update, insert, delete) clearly explained with examples
- [ ] Schema systematically normalized from flat table $\rightarrow$ 1NF $\rightarrow$ 2NF $\rightarrow$ 3NF
- [ ] Speakers modeled with a junction table
- [ ] All primary keys underlined and foreign keys marked in schema notation
- [ ] DDL created with `NOT NULL`, `UNIQUE`, `DEFAULT`, and `CHECK` constraints
- [ ] 4-step Safe Change Loop followed for the `UPDATE` and the `DELETE`
- [ ] Invalid insert correctly triggered and documented MySQL constraint error
- [ ] Query 1 properly uses parentheses for `AND` / `OR` operator precedence
- [ ] Query 4 properly uses `HAVING` instead of `WHERE` for aggregate filter
- [ ] Outer join missing-record query uses `IS NULL` check
- [ ] Silent inner join trap clearly explained with both query variations
- [ ] `ALTER TABLE` successfully executed and invalid status rejected
- [ ] Integrated synthesis report combines joins, aggregation, grouping, and ordering

### Concluding Reflection
1. What was the most significant challenge when decomposing the unnormalized flat table into 3NF, and how did separating entities improve data integrity?
   
   

2. What are the practical performance tradeoffs between keeping a single flat table versus querying multiple normalized tables using `JOIN`s in a high-traffic production environment?
