# SQL Portfolio — Nivedita Saha

A collection of SQL projects demonstrating relational database design, 
data loading, and analytical querying using PostgreSQL.

---

## Project 1: Student Alcohol Consumption Analysis

**Dataset:** UCI Student Alcohol Consumption (Maths students, Portugal)  
**Tool:** PostgreSQL  
**Skills:** Schema design, normalisation, JOINs, GROUP BY, aggregate functions

### What I built
- Designed a normalised 3-table schema (students, demographics, academic_performance)
- Loaded 395 real student records from CSV using PostgreSQL COPY
- Wrote analytical queries to uncover patterns in the data

### Key Findings
- Male and female students perform almost equally (10.75 vs 10.72 avg grade)
- Heavy weekend drinkers (level 4) score notably lower (9.16 avg vs 10.74)
- Urban and rural students have nearly identical absence rates