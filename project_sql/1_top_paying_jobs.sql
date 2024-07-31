/*
Question: what are the top-paying Data Scientist jobs?
- Identify the top-paying Data Scientist roles that are available remotely.
- Focuses on job postings with specified salaries (remove nulls).
- Why? Highlight the top-paying jobs for Data Scientists and get insights about employment opportunities.
*/

SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
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
LIMIT 10;

/*
Quick Insights into Top Paying Data Scientist Job Postings in 2023
1. Extremely High Salaries for Senior Roles:
Staff Data Scientist/Quant Researcher and Business Analytics: Positions at Selby Jennings offer exceptionally high salaries ($550,000 and $525,000), indicating that specialized and senior-level roles command top-tier pay in the data science field.

2. Leadership Positions are Highly Valued:
Head of Data Science: Roles at Demandbase offer $351,500 and $324,000, while Director-level roles at companies like Teramind and Reddit ($320,000 and $313,000) also show substantial compensation, reflecting the premium placed on leadership and strategic direction in data science.

3. Diverse Industry Demand:
Companies Across Various Sectors: High-paying jobs are available in different sectors, from financial services (Selby Jennings, Algo Capital Group) to retail (Walmart) and technology (Storm5, Storm4), showcasing the widespread demand for data science expertise across industries.

[
  {
    "job_id": 40145,
    "job_title": "Staff Data Scientist/Quant Researcher",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "550000.0",
    "job_posted_date": "2023-08-16 16:05:16",
    "company_name": "Selby Jennings"
  },
  {
    "job_id": 1714768,
    "job_title": "Staff Data Scientist - Business Analytics",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "525000.0",
    "job_posted_date": "2023-09-01 19:24:02",
    "company_name": "Selby Jennings"
  },
  {
    "job_id": 1131472,
    "job_title": "Data Scientist",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "375000.0",
    "job_posted_date": "2023-07-31 14:05:21",
    "company_name": "Algo Capital Group"
  },
  {
    "job_id": 1742633,
    "job_title": "Head of Data Science",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "351500.0",
    "job_posted_date": "2023-07-12 03:07:31",
    "company_name": "Demandbase"
  },
  {
    "job_id": 551497,
    "job_title": "Head of Data Science",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "324000.0",
    "job_posted_date": "2023-05-26 22:04:44",
    "company_name": "Demandbase"
  },
  {
    "job_id": 126218,
    "job_title": "Director Level - Product Management - Data Science",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "320000.0",
    "job_posted_date": "2023-03-26 23:46:39",
    "company_name": "Teramind"
  },
  {
    "job_id": 1161630,
    "job_title": "Director of Data Science & Analytics",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "313000.0",
    "job_posted_date": "2023-08-23 22:03:48",
    "company_name": "Reddit"
  },
  {
    "job_id": 38905,
    "job_title": "Principal Data Scientist",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "300000.0",
    "job_posted_date": "2023-11-24 14:08:44",
    "company_name": "Storm5"
  },
  {
    "job_id": 129924,
    "job_title": "Director of Data Science",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "300000.0",
    "job_posted_date": "2023-01-21 11:09:36",
    "company_name": "Storm4"
  },
  {
    "job_id": 226011,
    "job_title": "Distinguished Data Scientist",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "300000.0",
    "job_posted_date": "2023-08-06 11:00:43",
    "company_name": "Walmart"
  }
]

*/