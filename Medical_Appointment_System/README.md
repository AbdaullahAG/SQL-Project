# Medical_Appointment_System
A simple and efficient SQL database system for managing medical clinic appointments, doctors, patients, specialties, and invoices.

---

## Project Overview

This project implements a relational database schema for a medical appointment system with the following features:

- Managing patients, doctors, and their specialties.
- Scheduling appointments with prevention of duplicate bookings for the same doctor and time.
- Tracking appointment status (Scheduled, Completed, Cancelled).
- Managing invoices linked to appointments.
- Generating monthly income reports per doctor and per specialty.

---

## Database Structure

The database consists of the following tables:

- **SPECIALTIES**: Medical specialties (e.g., Cardiology, Dermatology).
- **DOCTORS**: Doctors with their specialty, contact info.
- **PATIENTS**: Patient details including contact info and birthdate.
- **APPOINTMENTS**: Appointment records linking patients and doctors, with date, fee, and status.
- **INVOICES**: Payment invoices linked to appointments.

---

## Features

- Prevents double booking of the same doctor at the same appointment time.
- Supports tracking appointment status.
- Calculates monthly income per doctor and specialty.
- Generates reports filtered by time periods.

---

## Getting Started

### Prerequisites

- MySQL server installed.
- SQL client or MySQL Workbench for running SQL scripts.

### Installation

1. Clone or download this repository.
2. Run the schema creation script (`schema.sql`) to create tables.
3. Insert sample data using the data insertion script (`data.sql`).
4. Use the queries script (`queries.sql`) for running advanced queries and reports.

---

## File Structure

- `schema.sql`: Contains SQL commands to create database tables and constraints.
- `data.sql`: Contains SQL insert statements to populate tables with sample data.
- `queries.sql`: Contains SQL queries for business logic and reports with clear comments.

---

## Usage

- Modify or extend tables and queries according to your clinic’s needs.
- Run queries to view appointments, invoices, and reports.
- Integrate this database backend with an application or frontend as needed.

---

## Contact

For questions or suggestions, please contact:

- **Your Name**  
- Email: your.email@example.com  
- LinkedIn: [Your LinkedIn Profile](https://linkedin.com/in/yourprofile)

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
