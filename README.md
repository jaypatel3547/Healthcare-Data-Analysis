# Healthcare-Data-Analysis

This project analyses healtcare data using MySQL. Kaggle CSV datasets were imported into a custom relational schema, then queried with SQL to explore doctors, patients, appointments, treatments, and billing.


## Overview ##

This project demonstrates practical SQL skills on realistic healthcare dataset.
The workflow was :

1. Download public healthcare CSV files from Kaggle.
2. Create MySQL tables and relationships in 'schema.sql'.
3. Load the CSV files into MySQL in 'load_data.sql'.
4. Run analysis queries from 'queries.sql' to answer business-style questions.


** Tech Stack **

- MySQL
- VS Code
- Git/GitHub
- SQL


## Database Schema

The database consists of five main tables created in 'schema.sql':

1. patients - demographic and registration details
2. doctors - doctor information (name, specialisation, years of experience, hospital branch)
3. appointments - it links patients and doctors with appointment date, time, reason for visit, and status
4. treatments - treatments given during appointments, including its type, description, date and cost associated
5. billing - billing records for treatments, with bill date, amount, payment method, and payment status

## Dataset

- Source: Hospital Management CSV dataset from Kaggle
- Format: 5 CSV files
- Process: CSV files were mapped into the custom schema and loaded into MySQL using 'load_data.sql', so all analysis could be done with SQL.


## Project Structure

```
Healthcare-Data-Analysis/
├── data/
│   ├── appointments.csv
│   ├── billing.csv
│   ├── doctors.csv
│   ├── patients.csv
│   └── treatments.csv
├── sql_data/
│   ├── load_data.sql
│   ├── queries.sql
│   └── schema.sql
└── README.md
```

## Key SQL features

The 'queries.sql' includes:

- Counts of patients, doctors, and appointments along with doctor specialisation.
- Joins across patients, doctors, appointments, treatments, and billing to analyse activity per branch, specialisation, and insurance provider.
- Aggregation with GROUP BY (COUNT, SUM, AVG) to find doctors with the most appointments, average treatment cost per specialisation and monthly revenue trend.
- Date-based analysis with DATE_FORMAT to track monthly patient registrations, appointments and treatment revenue.
- Checks for data issues such as appointments without billing records.

## How to Run

1. Create a new MySQL database (For Ex - healthcare_db).
2. Run 'schema.sql' to create all tables and constraints.
3. Run 'load_data.sql' to import the data from the Kaggle CSV's.
4. Execute the queries in 'queries.sql' using MySQL Workbench, MySQL CLI, or phpMyAdmin.


Author: Jay Patel - BSc Computer Science, University of Westminster.
