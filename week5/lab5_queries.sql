USE infoman1_vetclinic;

-- Task 1: Basic SELECT Statements
-- 1.1 All columns and rows
SELECT * 
FROM pet;

-- 1.2 Only name and species
SELECT name, species 
FROM pet;


-- Task 2: Filtering with Equality
SELECT name, species 
FROM pet 
WHERE species = 'Dog';


-- Task 3: Filtering with Relational Operators
-- 3.1 Date filter on pet table
SELECT name, species, birth_date 
FROM pet 
WHERE birth_date >= '2021-01-01';

-- 3.2 Date filter on appointment table
SELECT appointment_id, pet_id, appointment_date 
FROM appointment 
WHERE appointment_date >= '2024-01-01';


-- Task 4: Combine and Debug
-- Original Working Query:
SELECT name, species, birth_date 
FROM pet 
WHERE species = 'Cat';

-- Deliberately Broken Query (missing quotes around 'Cat'):
-- SELECT name, species, birth_date 
-- FROM pet 
-- WHERE species = Cat;

-- Task 4 Notes:
-- Mismatch: Removed single quotes around 'Cat'.
-- Result: Returned MySQL Error 1054 ("Unknown column 'Cat' in 'where clause'") instead of cat rows.
-- Cause: Without quotes, MySQL treated Cat as a column name that doesn't exist.