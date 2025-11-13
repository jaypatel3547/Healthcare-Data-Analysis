--Healthcare Database Schema

--Drop the database if it exists and create a new one
DROP DATABASE IF EXISTS healthcare;
CREATE DATABASE healthcare;
USE healthcare;

--Create a table for doctors
CREATE TABLE doctors (
    doctor_id VARCHAR(4),
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100) NOT NULL,
    contact_number VARCHAR(11) NOT NULL,
    years_experience INT,
    hospital_branch VARCHAR(100),
    email VARCHAR(100),
    CONSTRAINT pk_d_id PRIMARY KEY (doctor_id)
);

--Create a table for patients
CREATE TABLE patients (
    patient_id VARCHAR(4),
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    gender CHAR(1),
    date_of_birth DATE NOT NULL,
    contact_number VARCHAR(11) NOT NULL,
    address VARCHAR(255),
    registration_date DATE,
    insurance_provider VARCHAR(100),
    insurance_number VARCHAR(50),
    email VARCHAR(100)
    CONSTRAINT pk_p_id PRIMARY KEY (patient_id)
);

--Create a table for appointments
CREATE TABLE appointments (
    appointment_id VARCHAR(4),
    patient_id VARCHAR(4),
    doctor_id VARCHAR(4),
    appointment_date DATE,
    appointment_time TIME,
    reason_for_visit VARCHAR(255),
    status VARCHAR(50),
    CONSTRAINT pk_a_id PRIMARY KEY (appointment_id),
    CONSTRAINT fk_a_patient FOREIGN KEY (patient_id)
        REFERENCES patients(patient_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_a_doctor FOREIGN KEY (doctor_id)
        REFERENCES doctors(doctor_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

--Create table for treatments
CREATE TABLE treatments (
    treatment_id VARCHAR(4),
    appointment_id VARCHAR(4),
    treatment_type VARCHAR(100),
    treatment_description TEXT,
    treatment_cost DECIMAL(6, 2),
    treatment_date DATE,
    CONSTRAINT pk_t_id PRIMARY KEY (treatment_id),
    CONSTRAINT fk_t_appointment FOREIGN KEY (appointment_id)
        REFERENCES appointments(appointment_id
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

--Create table for billing
CREATE TABLE billing (
    bill_id VARCHAR(4),
    patient_id VARCHAR(4),
    treatment_id VARCHAR(4),
    bill_date DATE,
    amount DECIMAL(6, 2),
    payment_method VARCHAR(50),
    payment_status VARCHAR(50),
    CONSTRAINT pk_b_id PRIMARY KEY (bill_id),
    CONSTRAINT fk_b_patient FOREIGN KEY (patient_id)
        REFERENCES patients(patient_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_b_treatment FOREIGN KEY (treatment_id)
        REFERENCES treatments(treatment_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
