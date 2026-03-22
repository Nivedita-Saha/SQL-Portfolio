-- ============================================================
-- PROJECT: Student Alcohol Consumption Analysis
-- Dataset: UCI Student Alcohol Consumption (Maths)
-- Author: Nivedita Saha
-- GitHub: github.com/Nivedita-Saha
-- ============================================================

-- STEP 1: CREATE TABLES
-- ============================================================

CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    school VARCHAR(50),
    age INTEGER,
    famsize VARCHAR(10),
    Pstatus VARCHAR(10)
);

CREATE TABLE demographics (
    demo_id SERIAL PRIMARY KEY,
    student_id INTEGER REFERENCES students(student_id),
    sex VARCHAR(10),
    address VARCHAR(10),
    Medu INTEGER,
    Fedu INTEGER
);

CREATE TABLE academic_performance (
    perf_id SERIAL PRIMARY KEY,
    student_id INTEGER REFERENCES students(student_id),
    studytime INTEGER,
    failures INTEGER,
    absences INTEGER,
    Dalc INTEGER,
    Walc INTEGER,
    G1 INTEGER,
    G2 INTEGER,
    G3 INTEGER
);

-- STEP 2: LOAD DATA VIA STAGING TABLE
-- ============================================================

CREATE TABLE staging (
    school VARCHAR(50), sex VARCHAR(10), age INTEGER, address VARCHAR(10),
    famsize VARCHAR(10), Pstatus VARCHAR(10), Medu INTEGER, Fedu INTEGER,
    Mjob VARCHAR(50), Fjob VARCHAR(50), reason VARCHAR(50), guardian VARCHAR(50),
    traveltime INTEGER, studytime INTEGER, failures INTEGER,
    schoolsup VARCHAR(10), famsup VARCHAR(10), paid VARCHAR(10),
    activities VARCHAR(10), nursery VARCHAR(10), higher VARCHAR(10),
    internet VARCHAR(10), romantic VARCHAR(10), famrel INTEGER,
    freetime INTEGER, goout INTEGER, Dalc INTEGER, Walc INTEGER,
    health INTEGER, absences INTEGER, G1 INTEGER, G2 INTEGER, G3 INTEGER
);

COPY staging FROM '/Users/niveditasaha/Downloads/student-mat.csv'
DELIMITER ',' CSV HEADER;

INSERT INTO students (school, age, famsize, Pstatus)
SELECT school, age, famsize, Pstatus FROM staging;

INSERT INTO demographics (student_id, sex, address, Medu, Fedu)
SELECT s.student_id, st.sex, st.address, st.Medu, st.Fedu
FROM staging st
JOIN students s ON s.age = st.age
AND s.school = st.school
AND s.Pstatus = st.Pstatus;

INSERT INTO academic_performance
(student_id, studytime, failures, absences, Dalc, Walc, G1, G2, G3)
SELECT s.student_id, st.studytime, st.failures, st.absences,
       st.Dalc, st.Walc, st.G1, st.G2, st.G3
FROM staging st
JOIN students s ON s.age = st.age
