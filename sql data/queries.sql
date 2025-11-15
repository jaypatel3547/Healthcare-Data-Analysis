--1 How many patients, doctors, and appointments are recorded in the database?
SELECT
    (SELECT COUNT(*) FROM patients) AS 'Number of Patients',
    (SELECT COUNT(*) FROM doctors ) AS 'Number of Doctors',
    (SELECT COUNT(*) FROM appointments)  AS 'Number of Appointments'
;

--2 What are the different doctor specializations and how many doctors belong to each?
SELECT specialization, COUNT(*) AS 'Number of Doctors'
FROM doctors
GROUP BY specialization;

--3 Which doctors have handled the most appointments?
SELECT COUNT(*) AS 'Number of Appointments', doctor_id
FROM appointments
GROUP BY doctor_id
ORDER BY `Number of Appointments` DESC;

--4 Which insurance providers does each hospital branch handle monthly?
SELECT D.hospital_branch, P.insurance_provider, COUNT(*) AS 'Monthly Appointments'
FROM doctors D
JOIN appointments A ON A.doctor_id = D.doctor_id
JOIN patients P ON A.patient_id = P.patient_id
WHERE DATE_FORMAT(A.appointment_date, '%Y-%m')
GROUP BY D.hospital_branch, P.insurance_provider;

--5 How has patient registration changed month by month?
SELECT DATE_FORMAT(registration_date, '%Y-%m') AS Month, COUNT(*) AS 'NUMBER of NEW Patients'
FROM patients
GROUP BY Month
ORDER BY Month;

--6 How many appointments does each hospital branch handle monthly?
SELECT D.hospital_branch, DATE_FORMAT(A.appointment_date, '%Y-%m') AS Month, COUNT(*) AS 'NUMBER of Appointments'
FROM doctors D JOIN appointments A ON A.doctor_id = D.doctor_id
GROUP BY D.hospital_branch, Month
ORDER BY D.hospital_branch, Month;

--7 What are the most common reasons for patient visits?
SELECT reason_for_visit AS 'Reason for Visit', COUNT(*) AS 'Number of Visits'
FROM appointments
GROUP BY `Reason for Visit`
ORDER BY `Number of Visits` DESC;

--8 What is the average treatment cost per specialization?
SELECT D.specialization, AVG(T.cost) AS 'Average Treatment Cost'
FROM appointments A
JOIN treatments T ON A.appointment_id = T.appointment_id
JOIN doctors D ON A.doctor_id = D.doctor_id
GROUP BY D.specialization;

--9 Which doctors have the highest average treatment costs?
SELECT D.doctor_id, CONCAT(D.first_name, ' ', D.last_name) AS 'Doctor Name', AVG(T.cost)
FROM appointments A
JOIN treatments T ON A.appointment_id = T.appointment_id
JOIN doctors D ON A.doctor_id = D.doctor_id
GROUP BY D.doctor_id, `Doctor Name`
ORDER BY AVG(T.cost) DESC;

--10 What is the distribution of payment methods (cash, card, insurance)?
SELECT DISTINCT payment_method, COUNT(*) AS 'Number of Payments'
FROM billing
GROUP BY payment_method;

--11 What is the average revenue per patient?
SELECT P.patient_id, CONCAT(P.first_name, ' ', P.last_name) AS 'Patient Name', AVG(B.amount) AS 'Average Revenue per Patient'
FROM billing B JOIN patients P ON P.patient_id = B.patient_id
GROUP BY P.patient_id, `Patient Name`;

--12 What is the monthly revenue growth trend for the hospital?
SELECT DATE_FORMAT(T.treatment_date, '%Y-%m') AS Month, SUM(T.cost) AS 'Monthly Revenue'
FROM doctors D
JOIN appointments A ON A.doctor_id = D.doctor_id
JOIN treatments T ON A.appointment_id = T.appointment_id
JOIN billing B ON T.treatment_id = B.treatment_id
GROUP BY Month
ORDER BY Month;

--13 Which doctors perform treatment that are costlier than the overall average?
SELECT D.doctor_id, CONCAT(D.first_name, ' ', D.last_name) AS 'Doctor Name', COUNT(*) AS 'Number of Treatments Above Average Cost'
FROM doctors D
JOIN appointments A ON A.doctor_id = D.doctor_id
JOIN treatments T ON T.appointment_id = A.appointment_id
JOIN billing B ON B.treatment_id = T.treatment_id
WHERE T.cost > (SELECT AVG(T.cost) FROM treatments T)
GROUP BY D.doctor_id;

--14 Which have patients have received multiple treatments within a month?
SELECT P.patient_id, CONCAT(P.first_name, ' ', P.last_name) AS 'Patient FUll Name', DATE_FORMAT(T.treatment_date, '%Y-%m') AS Month, COUNT(*) AS 'Treatments Received'
FROM patients P
JOIN appointments A ON P.patient_id = A.patient_id
JOIN treatments T ON T.appointment_id = A.appointment_id
GROUP BY P.patient_id, `Patient FUll Name`, Month
HAVING COUNT(*) > 1
ORDER BY P.patient_id, Month;


--15 Which appointments have no billing records associated (potential data or process gaps)?
SELECT A.appointment_id, A.patient_id, A.doctor_id, A.appointment_date, A.reason_for_visit
FROM appointments A
LEFT JOIN billing B ON A.patient_id = B.patient_id
WHERE B.bill_id IS NULL;