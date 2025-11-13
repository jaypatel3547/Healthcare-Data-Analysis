--LOADING DATA INTO SQL TABLES IN HEALTHCARE DATABASE

USE healthcare;

--Load data into doctors table
LOAD DATA LOCAL INFILE 'C:/Healthcare Data Analysis/data/doctors.csv'
INTO TABLE doctors
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(doctor_id, first_name, last_name, specialization, contact_number, years_experience, hospital_branch, email);

--Load data into patients table
LOAD DATA LOCAL INFILE 'C:/Healthcare Data Analysis/data/patients.csv'
INTO TABLE patients
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(patient_id, first_name, last_name, gender, date_of_birth, contact_number, address, registration_date, insurance_provider, insurance_number, email);

--Load data into appointments table
LOAD DATA LOCAL FILE 'C:/Healthcare Data Analysis/data/appointments.csv'
INTO TABLE appointments
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
IGNORE 1 ROWS
(appointment_id, patient_id, doctor_id, appointment_date, appointment_time, reason_for_visit, status);

--Load data into treatments table
LOAD DATA LOCAL INFILE 'C:/Healthcare Data Analysis/data/treatments.csv'
INTO TABLE treatments
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(treatment_id, appointment_id, treatment_type, description, cost, treatment_date);

--Load data into billing table
LOAD DATA LOCAL INFILE 'C:/Healthcare Data Analysis/data/billing.csv'
INTO TABLE billing
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(bill_id, patient_id, treatment_id, bill_date, amount, payment_method, payment_status);