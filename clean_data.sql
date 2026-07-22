use hr;

CREATE TABLE hr_dummy LIKE hr_data;

-- Copy all the live records into your dummy table
INSERT INTO hr_dummy SELECT * FROM hr_data;



select * from hr_dummy;

SELECT COUNT(*) AS total_rows
FROM hr_dummy;




SELECT
    Employee_ID,
    COUNT(*) AS Duplicate_Count
FROM hr_dummy
GROUP BY Employee_ID
HAVING COUNT(*) > 1;

SELECT 
    COUNT(*) AS total_rows,
    SUM(CASE WHEN Experience_Years <= 0 THEN 1 ELSE 0 END) AS count_zero_neg_experience,
    SUM(CASE WHEN Age - Experience_Years < 18 THEN 1 ELSE 0 END) AS count_impossible_age_gap,
    SUM(CASE WHEN Salary <= 0 OR Salary IS NULL THEN 1 ELSE 0 END) AS count_invalid_salaries,
    SUM(CASE WHEN Department IS NULL THEN 1 ELSE 0 END) AS count_missing_dept
FROM hr_dummy;




select Experience_Years, hire_Date 
from hr_dummy
where Experience_Years<=0;

SELECT Experience_Years, hire_date 
FROM hr_dummy
WHERE hire_date IS NULL;




UPDATE hr_dummy
SET Experience_Years = CASE 
                WHEN Experience_Years <= 0 THEN TIMESTAMPDIFF(YEAR, hire_date, CURRENT_DATE())
                else Experience_Years
             END;



SELECT Employee_ID, Department, Job_Level, Salary
FROM hr_dummy
WHERE Salary <= 0;

SELECT
    Department,
    Job_Level,
    COUNT(*) AS Employees,
    ROUND(AVG(Salary),2) AS Avg_Salary
FROM hr_dummy
WHERE Salary > 0
GROUP BY Department, Job_Level;



select Job_Title,Department 
from hr_dummy
 group by Department,Job_Title;



-- there dep and same level (because same level could have diff experment years) also job title 
UPDATE hr_dummy h
join (
	select 
    Department, 
    Job_Level,
    Job_Title,
    avg(salary) as avg_Salary
    from hr_dummy
    where salary>0
    group by Department,Job_Level,Job_Title
) a 
ON h.Department = a.Department
AND h.Job_Level = a.Job_Level
and h.Job_Title=a.Job_Title
SET h.Salary = ROUND(a.Avg_Salary)
WHERE h.Salary <= 0;


select count(salary) from hr_dummy where salary<=0;
select count(*) from hr_dummy where Department is null ;

select age,Experience_Years, age-Experience_Years<18 as Failed 
from hr_dummy 
HAVING Failed = 1;

select * from hr_dummy;

UPDATE hr_dummy
SET Experience_Years = Age - 18
WHERE Age - Experience_Years < 18;






SELECT
    Job_Level,
    MIN(Salary) AS Min_Salary,
    AVG(Salary) AS Avg_Salary,
    MAX(Salary) AS Max_Salary
FROM hr_dummy
GROUP BY Job_Level
ORDER BY AVG(Salary);



select * from hr_dummy
where Job_Level="senior"
and Salary >(
select MIN(Salary)
from hr_dummy
where job_level="Director"
);

ALTER TABLE hr_dummy
ADD COLUMN Salary_Flag VARCHAR(50);



UPDATE hr_dummy
SET Salary_Flag = 'Test'
WHERE Employee_ID = 'EMP0000008';

select  * from hr_dummy where Employee_ID="EMP0000008";

UPDATE hr_dummy
SET Salary_Flag = 'Review Salary'
WHERE Job_Level = 'Senior'
AND Salary >
(
    SELECT MinDirectorSalary
    FROM (
        SELECT MIN(Salary) AS MinDirectorSalary
        FROM hr_dummy
        WHERE Job_Level = 'Director'
    ) d
);


select * from hr_dummy
where Salary_Flag = 'Review Salary';



-- performance ratings and departments.

select count(*) from hr_dummy 
where Performance_Rating is null;



update hr_dummy
set Performance_Rating="Not Rated"
where  Performance_Rating is null;

select * from hr_dummy;



SELECT @@hostname, @@port;