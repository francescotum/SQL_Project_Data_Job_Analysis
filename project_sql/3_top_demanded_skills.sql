/*
Question: What are the most in-demand skills foa a data analyst?
- Identify the top 5 in-demand skills for a data analyst.
- Focus on all job postings (not only the remote ones).
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
    job_title_short = 'Data Analyst'
GROUP BY 
    skills
ORDER BY
    demand_count DESC
LIMIT 5;