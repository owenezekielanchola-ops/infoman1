CREATE DATABASE IF NOT EXISTS infoman1_vetclinic;
USE infoman1_vetclinic;

CREATE TABLE owner (
    owner_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone_number INT NOT NULL
);

CREATE TABLE pet (
    pet_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    species VARCHAR(50) NOT NULL,
    age INT NOT NULL,
    owner_id INT NOT NULL,
    FOREIGN KEY (owner_id) REFERENCES owner(owner_id)
);

CREATE TABLE veterinarian (
    vet_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    specialization VARCHAR(100) NOT NULL
);

CREATE TABLE appointment (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_date DATETIME NOT NULL,
    reason_for_visit VARCHAR(255) NOT NULL,
    pet_id INT NOT NULL,
    vet_id INT NOT NULL,
    FOREIGN KEY (pet_id) REFERENCES pet(pet_id),
    FOREIGN KEY (vet_id) REFERENCES veterinarian(vet_id)
);

CREATE TABLE vaccination_record (
    pet_id INT NOT NULL,
    vaccine_name VARCHAR(100) NOT NULL,
    vaccination_date DATE NOT NULL,
    PRIMARY KEY (pet_id, vaccine_name, vaccination_date),
    FOREIGN KEY (pet_id) REFERENCES pet(pet_id)
);

ALTER TABLE owner MODIFY phone_number VARCHAR(15) NOT NULL;