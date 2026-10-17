\# INFOMAN1 — Week 4 Lab Answers



\## Task 1 — Create the Database

Created the database `infoman1\_vetclinic` and opened it with these commands:

```sql

CREATE DATABASE infoman1\_vetclinic;

SHOW DATABASES;

USE infoman1\_vetclinic;

```

Running `SHOW DATABASES;` confirmed that `infoman1\_vetclinic` is on the server.



Screenshot evidence: `screenshots/task1\_database.png`



\---



\## Task 2 — Create the Core Tables

Created the three core tables from the Week 3 schema:

\- `owner`: Stores owner information with `owner\_id` as the primary key. First and last names are stored as `VARCHAR(50)`.

\- `pet`: Tracks pets with `pet\_id` as the primary key. `age` is an integer, and `owner\_id` is the foreign key connecting the pet to their owner.

\- `veterinarian`: Holds vet records with `vet\_id` as the primary key, plus text columns for their name and specialization.



Screenshot evidence: `screenshots/task2\_core\_tables.png`



\---



\## Task 3 — Create the Relationship Tables

Created the two relationship tables to handle the connections from Week 3:

\- `appointment`: Resolves the many-to-many relationship between pets and veterinarians. Uses `appointment\_id` as the primary key, with two foreign keys: `pet\_id` referencing `pet(pet\_id)` and `vet\_id` referencing `veterinarian(vet\_id)`.

\- `vaccination\_record`: Resolves the weak entity. It uses a composite primary key made of `pet\_id`, `vaccine\_name` and `vaccination\_date`. And `pet\_id` also acts as the foreign key referencing `pet(pet\_id)`.



Screenshot evidence: `screenshots/task3\_relationship\_tables.png`



\---



\## Task 4 — Verify the Schema



\### 1. SHOW TABLES Check

Running `SHOW TABLES;` confirmed that all five tables exist in the database:

\- `appointment`

\- `owner`

\- `pet`

\- `vaccination\_record`

\- `veterinarian`



\### 2. DESCRIBE Outputs and Schema Comparison

Ran `DESCRIBE` on each table to check columns, keys, and types:

\- `owner`: Primary key `owner\_id` is marked as `PRI`. Names are `VARCHAR(50)`. Phone number was initially created as an `INT` for the Task 5 exercise.

\- `pet`: Primary key `pet\_id` is marked as `PRI`, and `owner\_id` shows up as a foreign key (`MUL`).

\- `veterinarian`: Primary key `vet\_id` is marked as `PRI`, with strings for names and specialization.

\- `appointment`: Primary key `appointment\_id` is marked as `PRI`, date is `DATETIME`, and both `pet\_id` and `vet\_id` show up as foreign keys (`MUL`).

\- `vaccination\_record`: All three columns (`pet\_id`, `vaccine\_name`, `vaccination\_date`) are marked as `PRI`, confirming the composite primary key. The column `pet\_id` also acts as the foreign key referencing `pet`.



Comparison against design:

Comparing the actual tables to the Week 3 schema and ERD, everything matches what we planned. All primary keys, foreign keys and data types match the logical design, so there are actually no design mismatches found.



Screenshot evidence: `screenshots/task4\_verification.png`



\---



\## Task 5 — Fix a Deliberate Mistake



\### 1. The Mistake

When creating the `owner` table in Task 2, I deliberately made `phone\_number` an `INT NOT NULL` instead of a string.



\### 2. How DESCRIBE Revealed the Problem

Running `DESCRIBE owner;` showed `phone\_number` with type `int`. The reason this is a bad data type is because phone numbers aren't values you do math on:

\- Any leading zero in a phone number gets dropped automatically by MySQL since it treats it as a number.

\- Formatting like dashes, parentheses or plus signs can't be saved in an integer field.

\- Full phone numbers with country codes pretty much always exceed the 2,147,483,647 limit of a standard signed INT.



\### 3. The Correction

Fixed the column definition using `ALTER TABLE`:

```sql

ALTER TABLE owner MODIFY phone\_number VARCHAR(15) NOT NULL;

```

Running `DESCRIBE owner;` again confirmed the column changed from `int` to `varchar(15)`.



Screenshot evidence: `screenshots/task5\_mistake\_fix.png`

