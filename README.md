# SQL Portfolio — Nivedita Saha

A collection of SQL projects demonstrating relational database design,
data loading, and analytical querying using PostgreSQL.

📧 sahanivedita10@gmail.com
🌐 www.nivsaha.com
💻 github.com/Nivedita-Saha

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

---

## Project 2: Animal Welfare Observation System

**Dataset:** UCI Zoo Animal Classification (101 animals)
**Tool:** PostgreSQL
**Skills:** Multi-table schema design, CASE statements, HAVING, welfare alert queries

### What I built
- Designed a 4-table relational system: animals, enclosures, behaviour_logs, vet_visits
- Loaded 101 real animal records and simulated 7 days of welfare observation data
- Built escalating welfare alert queries to flag at-risk animals

### Key Findings
- Identified animals with low activity levels (≤2) as welfare flags
- Detected animals missing 2+ consecutive feeds requiring vet attention
- Combined activity and feeding data to produce a highest-risk priority list

### Relevance
This project directly mirrors the data infrastructure needed for AI-powered
nocturnal animal monitoring systems in conservation settings.

---

*More projects coming soon: PostGIS spatial analysis, end-to-end ETL pipeline*