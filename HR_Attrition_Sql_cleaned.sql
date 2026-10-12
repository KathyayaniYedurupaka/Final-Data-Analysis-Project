CREATE DATABASE hr_attrition_analysis; 
use hr_attrition_analysis;
CREATE TABLE employees ( row_id INT PRIMARY KEY, 
age INT NULL, attrition VARCHAR(10), business_travel VARCHAR(30), daily_rate INT, department VARCHAR(30),
 distance_from_home INT, education INT, education_field VARCHAR(30), employee_count INT,
 employee_number INT, environment_satisfaction INT, gender VARCHAR(10), hourly_rate INT, 
 job_involvement INT, job_level INT, job_role VARCHAR(50), job_satisfaction INT NULL, 
 marital_status VARCHAR(20), monthly_income INT NULL, monthly_rate INT, num_companies_worked INT,
 over18 VARCHAR(5), over_time VARCHAR(10), percent_salary_hike INT, performance_rating INT,
 relationship_satisfaction INT, standard_hours INT, stock_option_level INT, total_working_years INT NULL, 
 training_times_last_year INT, work_life_balance INT, years_at_company INT NULL, years_in_current_role INT,
 years_since_last_promotion INT, years_with_curr_manager INT );
 SELECT COUNT(*) AS Total_Rows
FROM employee;
 SELECT COUNT(*) FROM employees WHERE age IS NULL;
 SELECT COUNT(*) AS Total_Rows FROM employees;
 SELECT COUNT(*) FROM employees WHERe monthly_income IS NULL;
 SELECT COUNT(*) FROM employees WHERE job_satisfaction IS NULL;
 SELECT COUNT(*) FROM employees WHERE total_working_years IS NULL;
 SELECT COUNT(*) FROM employees WHERE years_at_company IS NULL;
  SELECT COUNT(*) FROM employees WHERE age = 0; 
 SELECT COUNT(*) FROM employees WHERe job_satisfaction=0;
 SELECT COUNT(*) FROM employees WHERE total_working_years = 0;
  SELECT COUNT(*) FROM employees WHERE years_at_company =0;
  SELECT
    COUNT(*) AS Total_Rows,
    SUM(Age IS NULL) AS Missing_Age,
    SUM(Department IS NULL) AS Missing_Department,
    SUM(Monthly_Income IS NULL) AS Missing_Income,
    SUM(Total_Working_Years IS NULL) AS Missing_TotalWorkingYears,
    SUM(Years_At_Company IS NULL) AS Missing_YearsAtCompany,
    SUM(Job_Satisfaction IS NULL) AS Missing_JobSatisfaction
FROM employees;
SELECT Attrition, COUNT(*) AS Employes
FROM employees
GROUP BY Attrition;
-- Analysis---
-- 1.Employees who left--
SELECT COUNT(*) AS Employees_Left
FROM employees
WHERE Attrition = 'Yes';
-- 2.Employees who stayed--
SELECT COUNT(*) AS Employees_Stayed
FROM employees
WHERE Attrition = 'No';
-- 3. Overall Attrition Rate--
SELECT
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),2) AS Attrition_Rate FROM employees;
-- Attrition By Department--
SELECT
    Department,
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Employees_Left,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2) AS Attrition_Rate
FROM employees
GROUP BY Department
ORDER BY Attrition_Rate DESC;
-- Attrition By Job Role --
SELECT
    JobRole,
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Employees_Left,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2) AS Attrition_Rate
FROM employees
GROUP BY JobRole
ORDER BY Attrition_Rate DESC;
-- Attrition By Gender --
SELECT
    Gender,
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Employees_Left,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2) AS Attrition_Rate
FROM employees
GROUP BY Gender;
-- Attrition By Overtime --
SELECT
    Over_Time,
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Employees_Left,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS Attrition_Rate
FROM employees
GROUP BY Over_Time
ORDER BY Attrition_Rate DESC;
-- Attrition by Business Travel --
SELECT
    Business_Travel,
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Employees_Left,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS Attrition_Rate
FROM employees
GROUP BY Business_Travel
ORDER BY Attrition_Rate DESC;
-- Attrition By Experience --
SELECT
    CASE
        WHEN Years_At_Company <= 2 THEN '0-2 Years'
        WHEN Years_At_Company BETWEEN 3 AND 5 THEN '3-5 Years'
        WHEN Years_At_Company BETWEEN 6 AND 10 THEN '6-10 Years'
        WHEN Years_At_Company > 10 THEN '10+ Years'
        ELSE 'Unknown'
    END AS Experience_Group,

    COUNT(*) AS Total_Employees,

    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Employees_Left,

    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS Attrition_Rate

FROM employees

GROUP BY Experience_Group

ORDER BY Attrition_Rate DESC;
-- Stayed vs Left — Overall Comparison --
SELECT
    Attrition,
    COUNT(*) AS Employes,
    ROUND(AVG(Age), 2) AS Avg_Age,
    ROUND(AVG(Monthly_Income), 2) AS Avg_Income,
    ROUND(AVG(Years_At_Company), 2) AS Avg_Years_At_Company,
    ROUND(AVG(Distance_From_Home), 2) AS Avg_Distance,
    ROUND(AVG(Job_Satisfaction), 2) AS Avg_Job_Satisfaction,
    ROUND(AVG(Work_Life_Balance), 2) AS Avg_WorkLifeBalance
FROM employees
GROUP BY Attrition;