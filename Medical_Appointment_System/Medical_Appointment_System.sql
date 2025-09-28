CREATE DATABASE Medical_Appointment_System ;
USE Medical_Appointment_System;
-- ====================================
-- SECTION 1: SCHEMA 
-- ====================================
CREATE TABLE SPECIALTIES (
    SPECIALTY_ID INT AUTO_INCREMENT PRIMARY KEY,
    NAME VARCHAR(100) NOT NULL
);
CREATE TABLE DOCTORS (
    DOCTOR_ID INT AUTO_INCREMENT PRIMARY KEY,
    NAME VARCHAR(100) NOT NULL,
    SPECIALTY_ID INT,
    PHONE VARCHAR(20),
    EMAIL VARCHAR(100),
    FOREIGN KEY (SPECIALTY_ID) REFERENCES SPECIALTIES(SPECIALTY_ID)
);
CREATE TABLE PATIENTS (
    PATIENT_ID INT AUTO_INCREMENT PRIMARY KEY,
    NAME VARCHAR(100) NOT NULL,
    PHONE VARCHAR(20),
    EMAIL VARCHAR(100),
    BIRTHDATE DATE
);
CREATE TABLE APPOINTMENTS (
    APPOINTMENT_ID INT AUTO_INCREMENT PRIMARY KEY,
    PATIENT_ID INT,
    DOCTOR_ID INT,
    APPOINTMENT_DATE DATETIME,
    FEE DECIMAL(8,2),
    STATUS ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    FOREIGN KEY (PATIENT_ID) REFERENCES PATIENTS(PATIENT_ID),
    FOREIGN KEY (DOCTOR_ID) REFERENCES DOCTORS(DOCTOR_ID),
    UNIQUE (DOCTOR_ID, APPOINTMENT_DATE) 
);

CREATE TABLE INVOICES (
    INVOICE_ID INT AUTO_INCREMENT PRIMARY KEY,
    APPOINTMENT_ID INT,
    AMOUNT DECIMAL(8,2),
    PAYMENT_DATE DATE,
    FOREIGN KEY (APPOINTMENT_ID) REFERENCES APPOINTMENTS(APPOINTMENT_ID)
);
-- ====================================
-- SECTION 2: DATA (Insert Records)
-- ====================================
INSERT INTO SPECIALTIES (NAME) VALUES
('Internal Medicine'),
('Dermatology'),
('Dentistry'),
('Pediatrics'),
('Orthopedics'),
('ENT'),
('Gynecology'),
('Neurology'),
('Cardiology'),
('Ophthalmology');

INSERT INTO DOCTORS (NAME, SPECIALTY_ID, PHONE, EMAIL) VALUES
('Dr. John Smith', 1, '555-0101', 'john.smith@example.com'),
('Dr. Sarah Johnson', 2, '555-0102', 'sarah.johnson@example.com'),
('Dr. Michael Brown', 3, '555-0103', 'michael.brown@example.com'),
('Dr. Emily Davis', 4, '555-0104', 'emily.davis@example.com'),
('Dr. David Wilson', 5, '555-0105', 'david.wilson@example.com'),
('Dr. Linda Martinez', 6, '555-0106', 'linda.martinez@example.com'),
('Dr. James Anderson', 7, '555-0107', 'james.anderson@example.com'),
('Dr. Karen Thomas', 8, '555-0108', 'karen.thomas@example.com'),
('Dr. Robert Taylor', 9, '555-0109', 'robert.taylor@example.com'),
('Dr. Jessica Moore', 10, '555-0110', 'jessica.moore@example.com');

INSERT INTO PATIENTS (NAME, PHONE, EMAIL, BIRTHDATE) VALUES
('Alice Green', '444-1001', 'alice.green@example.com', '1990-05-12'),
('Bob White', '444-1002', 'bob.white@example.com', '1985-03-25'),
('Charlie Black', '444-1003', 'charlie.black@example.com', '1992-08-10'),
('Diana Blue', '444-1004', 'diana.blue@example.com', '1998-01-17'),
('Ethan Gray', '444-1005', 'ethan.gray@example.com', '1987-09-04'),
('Fiona Gold', '444-1006', 'fiona.gold@example.com', '1975-12-30'),
('George Red', '444-1007', 'george.red@example.com', '2000-07-23'),
('Hannah Silver', '444-1008', 'hannah.silver@example.com', '1983-06-15'),
('Ian Violet', '444-1009', 'ian.violet@example.com', '1995-11-11'),
('Julia Orange', '444-1010', 'julia.orange@example.com', '2001-02-28');

INSERT INTO APPOINTMENTS (PATIENT_ID, DOCTOR_ID, APPOINTMENT_DATE, FEE, STATUS) VALUES
(1, 1, '2025-06-03 09:00:00', 300.00, 'Scheduled'),
(2, 1, '2025-06-03 09:30:00', 300.00, 'Completed'),
(3, 2, '2025-06-04 10:00:00', 350.00, 'Scheduled'),
(4, 3, '2025-06-04 10:30:00', 250.00, 'Cancelled'),
(5, 4, '2025-06-05 11:00:00', 320.00, 'Scheduled'),
(6, 5, '2025-06-06 11:30:00', 400.00, 'Completed'),
(7, 6, '2025-06-07 12:00:00', 280.00, 'Scheduled'),
(8, 7, '2025-06-08 12:30:00', 450.00, 'Completed'),
(9, 8, '2025-06-09 13:00:00', 300.00, 'Scheduled'),
(10, 9, '2025-06-10 13:30:00', 370.00, 'Scheduled');

INSERT INTO INVOICES (APPOINTMENT_ID, AMOUNT, PAYMENT_DATE) VALUES
(2, 300.00, '2025-06-03'),
(6, 400.00, '2025-06-06'),
(8, 450.00, '2025-06-08');
-- ====================================
--  SECTION 3: QUERIES 
-- ====================================
/*
================================================================================
1. Prevent Duplicate Booking for the Same Doctor and Time
   - This query checks if there is already an existing appointment 
     for the same doctor at the same date and time that is not cancelled.
================================================================================
*/
SELECT COUNT(*) AS ExistingAppointments
FROM APPOINTMENTS
WHERE DOCTOR_ID = 1 
  AND APPOINTMENT_DATE = '2025-06-03 09:00:00'
  AND STATUS != 'Cancelled';
/*
================================================================================
2. Calculate Monthly Income per Doctor
   - This query sums up the total amounts from invoices related to completed appointments 
     for each doctor within a specified month and year.
================================================================================
*/
SELECT D.DOCTOR_ID, D.NAME, 
       SUM(I.AMOUNT) AS TotalIncome
FROM DOCTORS D
JOIN APPOINTMENTS A ON D.DOCTOR_ID = A.DOCTOR_ID
JOIN INVOICES I ON A.APPOINTMENT_ID = I.APPOINTMENT_ID
WHERE A.STATUS = 'Completed'
  AND MONTH(I.PAYMENT_DATE) = 6
  AND YEAR(I.PAYMENT_DATE) = 2025
GROUP BY D.DOCTOR_ID, D.NAME;
/*
================================================================================
3. Monthly Income Report by Specialty
   - Calculates the total income per specialty by summing invoice amounts 
     from completed appointments of doctors within that specialty, filtered by month and year.
================================================================================
*/
SELECT S.NAME AS Specialty, 
       SUM(I.AMOUNT) AS TotalIncome
FROM SPECIALTIES S
JOIN DOCTORS D ON S.SPECIALTY_ID = D.SPECIALTY_ID
JOIN APPOINTMENTS A ON D.DOCTOR_ID = A.DOCTOR_ID
JOIN INVOICES I ON A.APPOINTMENT_ID = I.APPOINTMENT_ID
WHERE A.STATUS = 'Completed'
  AND MONTH(I.PAYMENT_DATE) = 6
  AND YEAR(I.PAYMENT_DATE) = 2025
GROUP BY S.NAME;
/*
================================================================================
4. List Upcoming Appointments for a Specific Doctor
   - Shows scheduled upcoming appointments (future dates) for a specific doctor 
     along with patient names and appointment status, ordered by date and time.
================================================================================
*/
SELECT A.APPOINTMENT_ID, P.NAME AS PatientName, A.APPOINTMENT_DATE, A.STATUS
FROM APPOINTMENTS A
JOIN PATIENTS P ON A.PATIENT_ID = P.PATIENT_ID
WHERE A.DOCTOR_ID = 1
  AND A.APPOINTMENT_DATE > NOW()
  AND A.STATUS = 'Scheduled'
ORDER BY A.APPOINTMENT_DATE;
/*
================================================================================
5. Count of Patients per Doctor
   - Counts the distinct number of patients that each doctor has appointments with.
================================================================================
*/
SELECT D.NAME, COUNT(DISTINCT A.PATIENT_ID) AS PatientCount
FROM DOCTORS D
JOIN APPOINTMENTS A ON D.DOCTOR_ID = A.DOCTOR_ID
GROUP BY D.NAME;
