# INFOMAN1 – Week 2 Lab: Conceptual ERD Case Study
**Name:** Owen Ezekiel A. Anchola
**Student ID:** 2511003
**Section:** BSCS-II

## Task 1 — Candidate Entities

| Entity | Justification |
|---|---|
| Customer | Customers are clients who interact with the shop to get their vehicles repaired, giving them their own distinct identity and data rather than just describing another entity. |
| Car | A car is an identifiable physical object tracked by the shop, defined by its own properties like plate number, model, and color. |
| Mechanic | Mechanics are individual workers employed by the shop to carry out repairs, each possessing a specific name and field of expertise. |

*(Note on excluded nouns: Words like "shop" represent the overall business environment, "service records" refers to the database system itself, and nouns like "model", "plate number", "color", "name", and "specialty" are descriptive attributes of entities rather than independent entities).*

## Task 2 — Attributes per Entity

### Customer
- Primary Key: customer_id
- Attributes:
  - customer_id — Domain: numeric (integer, unique identifier)
  - customer_name — Domain: text (VARCHAR(100))
  - contact_number — Domain: text (VARCHAR(20))

### Car
- Primary Key: plate_number
- Attributes:
  - plate_number — Domain: text (VARCHAR(15), unique natural key)
  - model — Domain: text (VARCHAR(50))
  - color — Domain: text (VARCHAR(30))

### Mechanic
- Primary Key: mechanic_id
- Attributes:
  - mechanic_id — Domain: numeric (integer, unique identifier)
  - name — Domain: text (VARCHAR(100))
  - specialty — Domain: text (VARCHAR(50))

## Task 3 — Relationships

| Relationship (verb phrase) | Between | Cardinality | Checked both directions? |
|---|---|---|---|
| owns | Customer ↔ Car | 1:N | Yes — Looking from Customer to Car, one customer can bring in multiple cars (1:N). Looking from Car to Customer, each car is owned by only one customer (1:1). Therefore, the relationship is 1:N. |
| services | Mechanic ↔ Car | M:N | Yes — Looking from Mechanic to Car, a mechanic works on many different cars over time (1:N). Looking from Car to Mechanic, a car can be repaired by different mechanics on separate visits (1:N). Therefore, the relationship is M:N. |

## Task 4 — Conceptual ERD

![Conceptual ERD](erd.png)

*Note: In this conceptual diagram, the appointment information (date and repair note) is placed directly on the "services" relationship to record the details of each repair session.*