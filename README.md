# HR Analytics Dashboard (2M Employee Records)

An end-to-end HR analytics project: raw employee data is loaded with Python, cleaned and validated in MySQL, and visualised in an interactive Power BI dashboard focused on employee performance.

**Tech stack:** Python (pandas, SQLAlchemy, PyMySQL), MySQL, SQL, Power BI

## Project Workflow

```
hr_raw.csv  ->  Python (load_data.ipynb)  ->  MySQL (hr_data)  ->  SQL cleaning (clean_data.sql)  ->  hr_dummy  ->  Power BI dashboard
```

1. **Load** - `load_data.ipynb` reads the raw CSV (~2M rows) with pandas and writes it to a MySQL table `hr_data` through SQLAlchemy.
2. **Clean** - `clean_data.sql` works on a copy of the data (`hr_dummy`) so the raw table stays untouched.
3. **Visualise** - the cleaned table is connected to Power BI to build the Employee Performance Dashboard.

## Dataset

Each record contains: Employee_ID, Full_Name, Department, Job_Title, Hire_Date, Performance_Rating, Experience_Years, Status, Work_Mode, Salary, Year, Country, City, Age, Job_Level.

## Data Cleaning & Validation (SQL)

- Created a working copy of the table (`hr_dummy`) to preserve the original data.
- Checked for duplicate `Employee_ID` values and missing departments.
- Ran data-quality checks for zero/negative experience, invalid or missing salaries, and impossible age vs. experience combinations (started working before age 18).
- **Experience:** replaced zero/negative `Experience_Years` with the years calculated from `Hire_Date`.
- **Salary:** replaced invalid salaries (<= 0) with the average salary of the same Department + Job Level + Job Title.
- **Age consistency:** corrected experience where `Age - Experience_Years < 18` by setting it to `Age - 18`.
- **Salary flag:** added a `Salary_Flag` column marking Senior employees earning more than the lowest Director salary as `Review Salary`.
- **Performance:** filled missing `Performance_Rating` values with `Not Rated`.

## Dashboard (Power BI)

Key KPIs:

| Metric | Value |
|---|---|
| Total Employees | 2M |
| Excellent | 15% |
| Good | 50% |
| Needs Improvement | 7% |

Visuals:
- Performance distribution
- Performance by department
- Performance by job level
- Performance by work mode (On-site / Hybrid / Remote)
- Employee detail table
- Slicers: Job Level, Job Title, Experience Years, Performance Rating, Status, Work Mode

## Repository Structure

```
Hr_data/
├── load_data.ipynb   # Python: load CSV into MySQL
├── clean_data.sql    # SQL: validation and cleaning
└── README.md
```

## How to Run

1. Install dependencies: `pip install pandas sqlalchemy pymysql`
2. Place `hr_raw.csv` next to the notebook and create a MySQL database named `hr`.
3. Set your MySQL credentials in `load_data.ipynb` (use environment variables rather than hard-coding them) and run the notebook.
4. Run `clean_data.sql` in MySQL.
5. Connect Power BI to the `hr` database (`hr_dummy` table) and open the dashboard.
