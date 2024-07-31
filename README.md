# Introduction
The purpose of this project is to look at the data job market. The focus is on positions for Data Scientists: the intention is to get insights about top-paying jobs and the most important skills to have and to improve.

SQL queries: check them out at [project_sql folder](/project_sql/).

# Background
This project comes from my desire to investigate the data job market effectively while at the same time improving my SQL skills. 

The dataset is provided by [Luke Barousse](https://lukebarousse.com/sql) and contains info about jobs, salaries, skills and companies coming from job postings of 2023.

# Tools I used
The following tool have been used to carry out this analysis:
- **SQL** to query the database.
- **PostgreSQL** as database management system.
- **Visual Studio Code** to manage the database and execute the queries.
- **Git & GitHub** for controllin versions and sharing my SQL scripts and analysis.

# The Analysis
This project is all about exploring the job market in order to understand what is worth learning to get the most out of a career in Data Science. 

One of my priorities is to have the possibility to work from anywhere. Given this, I want to look for those skills that allow me to have access to a large number of jobs (just to be secure in the future) and those skills that grant me the access to top-paying jobs.


### 1. Top Paying Data Scientist Jobs
To identify the highest paying roles for Data Scientists, first I looked only for the ones offering the possibility of working from anywhere, and then sorted them on salary base.

```sql
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
```
Quick Insights into Top Paying Data Scientist Job Postings in 2023

**1. Extremely High Salaries for Senior Roles**

Staff Data Scientist/Quant Researcher and Business Analytics: Positions at Selby Jennings offer exceptionally high salaries ($550,000 and $525,000), indicating that specialized and senior-level roles command top-tier pay in the data science field.

**2. Leadership Positions are Highly Valued**

Head of Data Science: Roles at Demandbase offer $351,500 and $324,000, while Director-level roles at companies like Teramind and Reddit ($320,000 and $313,000) also show substantial compensation, reflecting the premium placed on leadership and strategic direction in data science.

**3. Diverse Industry Demand**

Companies Across Various Sectors: High-paying jobs are available in different sectors, from financial services (Selby Jennings, Algo Capital Group) to retail (Walmart) and technology (Storm5, Storm4), showcasing the widespread demand for data science expertise across industries.


# What I learned
# Conclusions
