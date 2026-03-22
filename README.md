# SQL Portfolio — Nivedita Saha

A collection of SQL projects demonstrating relational database design,
data loading, and analytical querying using PostgreSQL.

📧 sahanivedita10@gmail.com
🌐 www.nivsaha.com
💻 github.com/Nivedita-Saha

---

## Project 1: Student Alcohol Consumption Analysis
**Dataset:** UCI Student Alcohol Consumption (395 students, Portugal)
**Tool:** PostgreSQL
**Skills:** Schema design, normalisation, JOINs, GROUP BY, aggregate functions

### What I built
- Designed a normalised 3-table schema (students, demographics, academic_performance)
- Loaded 395 real student records from CSV using PostgreSQL COPY
- Wrote analytical queries to uncover behavioural patterns

### Key Findings
- Heavy weekend drinkers (level 4) score notably lower (9.16 vs 10.74 avg grade)
- Male and female students perform almost equally (10.75 vs 10.72)
- Urban and rural students have nearly identical absence rates

---

## Project 2: Animal Welfare Observation System
**Dataset:** UCI Zoo Animal Classification (101 animals)
**Tool:** PostgreSQL
**Skills:** Multi-table schema, CASE statements, HAVING, welfare alert queries

### What I built
- Designed a 4-table system: animals, enclosures, behaviour_logs, vet_visits
- Loaded 101 real animal records with 7 days of simulated welfare observations
- Built escalating welfare alert queries to identify at-risk animals

### Key Findings
- Catfish flagged as highest welfare risk: activity 2.43/5, 4 missed feeds in 7 days
- Combined low activity + missed feeding query produces actionable priority list
- System mirrors data infrastructure needed for nocturnal animal monitoring

---

## Project 3: Spatial Zoo Enclosure Analysis
**Dataset:** Simulated sightings at real Marwell Zoo coordinates (Winchester, Hampshire)
**Tool:** PostgreSQL with Haversine distance formula
**Skills:** Spatial data, distance calculations, subqueries, timestamp analysis

### What I built
- Stored real GPS coordinates for Marwell Zoo enclosures
- Simulated 10 nocturnal animal sightings with lat/long positions
- Wrote spatial queries calculating real distances between animals and enclosures

### Key Findings
- Bat and aardvark confirmed within 13.1m of Nocturnal House at night
- All 10 animals correctly matched to their nearest enclosure within 100m
- Generated a full nocturnal activity report (midnight–4am) with distance data

### Relevance
Directly demonstrates the spatial data skills required for AI-powered
nocturnal monitoring systems in conservation settings (e.g. Marwell Wildlife KTP).

---

*Skills demonstrated across projects: PostgreSQL, schema design, normalisation,
JOINs, subqueries, window functions, spatial calculations, welfare alert logic*