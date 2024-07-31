/*
Question: What skilld are required for top paying Data Scientist jobs?
- Use the top 10 highest-paying Data Scientist jobs from the first query
- Add specific skills required for these roles
- Group the results by skills to see which are the most popular.
- Why? It provides a detailed look at which high-paying jobs demand certain skills,
    helping job seekers understand which skills to develop that aligh with top salaries.
*/

WITH top_paying_jobs AS (
SELECT
    job_id,
    job_title,
    salary_year_avg,
    company_dim.name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Scientist' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10
), skills_top_job AS (
    SELECT 
        top_paying_jobs.*,
        skills
    FROM top_paying_jobs
    INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    ORDER BY
        salary_year_avg DESC)

SELECT 
    skills,
    COUNT(*) AS skill_demand,
    ROUND(AVG(salary_year_avg),0) AS average_salary
FROM skills_top_job
GROUP BY
    skills
ORDER BY
    skill_demand DESC


