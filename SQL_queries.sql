-- Q1: How many employees left the company?
SELECT COUNT(*) AS total_left
FROM `employee-attrition-465509.employeeatrition.ibm_hr_attrition`
WHERE Attrition = TRUE;

-- Q2: What is the attrition rate by department?
SELECT 
  Department,
  COUNT(*) AS total_employees,
  SUM(CASE WHEN Attrition = TRUE THEN 1 ELSE 0 END) AS attrition_count,
  ROUND(SUM(CASE WHEN Attrition = TRUE THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS attrition_rate_percentage
FROM `employee-attrition-465509.employeeatrition.ibm_hr_attrition`
GROUP BY Department
ORDER BY attrition_rate_percentage DESC;

-- Q3: What is the average monthly income of employees who left vs. stayed?
SELECT 
  Attrition,
  ROUND(AVG(MonthlyIncome), 2) AS avg_income
FROM `employee-attrition-465509.employeeatrition.ibm_hr_attrition`
GROUP BY Attrition;

-- Q4: Is distance from home related to attrition?
SELECT 
  Attrition,
  ROUND(AVG(DistanceFromHome), 2) AS avg_distance
FROM `employee-attrition-465509.employeeatrition.ibm_hr_attrition`
GROUP BY Attrition;

-- Q5: What age groups show the highest attrition?
SELECT 
  age_group,
  COUNT(*) AS total_employees,
  SUM(CASE WHEN Attrition = TRUE THEN 1 ELSE 0 END) AS attrition_count,
  ROUND(SUM(CASE WHEN Attrition = TRUE THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS attrition_rate_percentage
FROM (
  SELECT *,
    CASE 
      WHEN Age BETWEEN 18 AND 25 THEN '18-25'
      WHEN Age BETWEEN 26 AND 35 THEN '26-35'
      WHEN Age BETWEEN 36 AND 45 THEN '36-45'
      WHEN Age BETWEEN 46 AND 55 THEN '46-55'
      ELSE '56+'
    END AS age_group
  FROM `employee-attrition-465509.employeeatrition.ibm_hr_attrition`
)
GROUP BY age_group
ORDER BY attrition_rate_percentage DESC;


