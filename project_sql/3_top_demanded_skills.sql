/*
Question: What are the most in-demand skills for a Data Scientist?
- Identify the top 5 in-demand skills for a Data Scientist.
- Focus on remote job postings.
- Why? To have insights about the most valuable skills for job seekers.
*/


SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM 
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Scientist' AND
    job_location = 'Anywhere'
GROUP BY 
    skills
ORDER BY
    demand_count DESC
LIMIT 5;

