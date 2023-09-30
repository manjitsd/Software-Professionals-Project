create table software_professionals (
rating real,
company varchar,
job_title varchar,
salary int,
salaries_reported int,
location varchar,
employment_status varchar,
job_roles varchar);

-- loaded the csv file

select * from software_professionals;

-- A) Basic Questions

-- 1. What is the average salary for software professionals in the dataset?

SELECT Round(AVG(salary), 2) average_salary, count(salary) total_employees 
FROM software_professionals;

-- 2. How many unique companies are included in the dataset?

SELECT COUNT(DISTINCT company) total_unique_companies 
FROM software_professionals;

-- 3. What are the top 5 most common job titles?

select distinct(job_title) job_title, count(job_title) count_of_the_job_title
from software_professionals
group by job_title
order by 2 desc
limit 5;

-- B) Location Based Questions

-- 4. Which top 3 locations has the highest average salary for software professionals?

select location, round(avg(salary), 2) average_salary
from software_professionals
group by location
order by 2 desc
limit 3;

-- 5. How many software professionals have reported salaries in the dataset for Contractor jobs?

select count(*) count_of_employees
from software_professionals
where employment_status = 'Contractor';

-- c) Company Rankings

-- 6. Can you rank the top 10 companies based on the average salary they offer?

select distinct(company), round(avg(salary), 2) average_salary
from software_professionals
group by company
order by 2 desc
limit 10;


-- D) Job title and Salary relation

-- 7. Is there a correlation between job title and salary? List the top 5 job titles with the highest 
-- and lowest average salaries.

select * from (select job_title, round(avg(salary), 2) avg_salary 
			   from software_professionals
			   group by job_title
			   order by 2
			   limit 5) as lowest_5
union all
select * from (select job_title, round(avg(salary), 2) avg_salary 
			   from software_professionals
			   group by job_title
			   order by 2 desc
			   limit 5) as top_5

-- E) Employment status Breakdown

-- 8. How many software professionals are in each employment status category 
-- (e.g., full-time, part-time, contract, etc.)?

select distinct(employment_status), count(*) No_of_software_professionals
from software_professionals
group by employment_status
order by 2;

-- 9. What is the average salary for full-time software professionals compared 
-- to contractor professionals?

select employment_status, round(avg(salary), 2) avg_salary
from software_professionals
where employment_status in ('Full Time', 'Contractor')
group by employment_status;

-- F) Salary Distribution

-- 10. Create a histogram showing the distribution of salaries for software professionals.
-- Is it normally distributed?

select salary, count(*) as frequency
from software_professionals
group by salary
order by salary;


-- G) Location and Salary insights

-- 11. Are there significant salary differences between different locations when adjusted for job roles?
-- Perform a detailed analysis.

select location, job_roles, round(avg(salary), 2) avg_salary
from software_professionals
group by location, job_roles
order by 1, 3 desc

-- 12. Find companies that offer above-average salaries for software professionals in specific locations.

select company, round(avg(salary), 2) avg_salary_of_company, 
round((select avg(salary) from software_professionals),2) overall_average_salary
from software_professionals
where location = 'Bangalore'
group by company
having avg(salary) > (select avg(salary) from software_professionals)
order by 2
