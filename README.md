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
- **Python/Matplotlib** for creating charts.

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

![Top Paying Roles](assets/1_data_scientists_top_salaries.png)
*Bar chart showing the top 10 Data Scientist jobs ordered by salary.*

### 2. Skills for Top Paying Jobs
Having the top paying Data Scientist jobs, it would be interesting to understand which skills are required for them, which is why I have joined the job postings data with the skills data.


```sql
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
    skill_demand DESC;
```

This allows to state that **Python** and **SQL** are very important (as expected), and moreover, it seams that the knwoledge of **Deep Learning** libraries is also requested.

![Skills for Top jobs](assets/2_ds_top_paying_skills_demand.png)
*Bar chart showing the count of skills appearing in the top 10 paying jobs.*

### 3. Top Demanded Skills for Data Scientists
The next step is to understand which are the most requested skills for Data Scientists: in other words, which skills appear more often on job postings.

```sql
SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM 
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Scientist'
GROUP BY 
    skills
ORDER BY
    demand_count DESC
LIMIT 5;
```

The results for all Data Scientist jobs and for the fully remote ones show that **Python**, **SQL**, and **R** are the most sought-after skills. The key difference is the inclusion of **AWS** in the remote jobs list, indicating the importance of cloud computing skills for remote data science positions. Finally, data visulization tools like **Tableu** remain essential.

| Skills   | Demand Count |
|----------|--------------|
| Python   | 114016       |
| SQL      | 79174        |
| R        | 59754        |
| SAS      | 29642        |
| Tableau  | 29513        |
*Top demanded skills for Data Scientists*

| Skills   | Demand Count |
|----------|--------------|
| Python   | 10390        |
| SQL      | 7488         |
| R        | 4674         |
| AWS      | 2593         |
| Tableau  | 2458         |
*Top demanded skills for Data Scientists among those jobs allowing to work from anywhere.*

### 4. Top Paying Skills
Another useful insight is the average salary associeted to each skill.

```sql
SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM 
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Scientist' AND
    salary_year_avg IS NOT NULL AND
    job_work_from_home = TRUE
GROUP BY 
    skills
ORDER BY
    avg_salary DESC
LIMIT 25;
```
Breaking down the results:

**1. GDPR** 

High demand and premium salaries for those job seakers that understand the importance of data privacy and compliance.

**2.Diverse Technical Skills**

 The presence of Golang, Selenium, OpenCV, Neo4j, and DynamoDB indicates that a variety of technical and programming skills command high salaries, spanning areas such as programming languages, automation, computer vision, graph databases, and cloud data management.

**3. Specialized Tools**

Skills in specific tools and frameworks like Atlassian, MicroStrategy, and Tidyverse are highly valued, emphasizing the importance of proficiency in specialized software for data analysis, project management, and data visualization.

| Skills       | Avg Salary ($) |
|--------------|------------|
| GDPR         | 217738     |
| Golang       | 208750     |
| Atlassian    | 189700     |
| Selenium     | 180000     |
| OpenCV       | 172500     |
| Neo4j        | 171655     |
| MicroStrategy| 171147     |
| DynamoDB     | 169670     |
| PHP          | 168125     |
| Tidyverse    | 165513     |

### 5. Optimal Skills to Learn
Now that I have the most demanded and the most remunerated skills, I want to understand which skills fall in a sort of trade-off between demand and remuneration.

```sql
WITH skills_demand AS (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Scientist'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY
        skills_dim.skill_id
), average_salary AS(
    SELECT
        skills_job_dim.skill_id,
        ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Scientist'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY
        skills_job_dim.skill_id
)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM
    skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE
    demand_count > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25
```

| Skills      | Demand Count | Avg Salary ($) |
|-------------|--------------|------------|
| C           | 48           | 164865     |
| Go          | 57           | 164691     |
| Qlik        | 15           | 164485     |
| Looker      | 57           | 158715     |
| Airflow     | 23           | 157414     |
| BigQuery    | 36           | 157142     |
| Scala       | 56           | 156702     |
| GCP         | 59           | 155811     |
| Snowflake   | 72           | 152687     |
| PyTorch     | 115          | 152603     |
*Most optimal skills for Data Scientists in 2023*

These results say that:

**1.High Salaries in Programming and Data Tools**

 Skills in programming languages (C, Go) and data visualization tools (Qlik) command some of the highest average salaries, each exceeding $164,000, indicating their significant value in the data science job market.
**2. Cloud and Big Data Expertise**

 Tools and platforms such as Airflow, BigQuery, GCP, and Snowflake are in demand, reflecting the importance of cloud computing and big data management in modern data science roles.

**3. Machine Learning and Data Visualization**

 Skills in PyTorch and Looker highlight the need for machine learning expertise and data visualization capabilities, crucial for deriving insights and building predictive models.

# What I learned
This project made me improve my SQL skills while at the same time helping me in getting info about jobs in the Data Science world. 

- I got more comfortable with complex queries using CTEs and sub-queries.
- I managed to apply correctly the aggregation functions and GROUP BY statements. 

# Conclusions
The analysis made emerge several key aspects regarding the job market for Data Scientists, particularly:

### Insights
**1. Exceptional Salaries for Senior Data Scientist Roles**

Senior and specialized positions, such as Staff Data Scientist/Quant Researcher and Business Analytics roles, command exceptionally high salaries, with figures reaching up to $550,000. This highlights the premium placed on advanced expertise and experience in the data science field.

**2. High Value on Leadership in Data Science**

Leadership roles, including Head of Data Science and Director-level positions, offer substantial compensation, with salaries ranging from $313,000 to $351,500. This underscores the importance of strategic direction and leadership within data science teams.

**3. Widespread Industry Demand**

High-paying data science jobs span across various sectors, including financial services, retail, and technology. This demonstrates the extensive demand for data science expertise across different industries, showcasing the versatility and critical importance of data science skills.

**4. Key Skills for Top-Paying Jobs**

Python and SQL are essential skills for top-paying data science jobs. Additionally, proficiency in deep learning libraries is increasingly sought after, reflecting the growing emphasis on advanced machine learning techniques.

**5. Optimal Skills Balancing Demand and Remuneration**

Skills in programming languages (C, Go), data visualization tools (Qlik), cloud platforms (Airflow, BigQuery, GCP, Snowflake), and machine learning frameworks (PyTorch) are highly valued. These skills offer a balance between high demand and competitive salaries, indicating their critical role in the data science job market.

### Closing Thoughts
To conclude, now I am more aware about the required competences I should develop in order to advance in my Data Science career. These findings helped my in understanding what I should prioritize and moreover they confirmed the fact that this journey is all about continuous learning: this is a fast-paced sector and you need to adapt in order to get the best opportunities.
