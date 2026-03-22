-- ============================================================
-- PROJECT 2: Animal Welfare Observation System
-- Dataset: UCI Zoo Animal Classification
-- Author: Nivedita Saha
-- GitHub: github.com/Nivedita-Saha
-- ============================================================

-- STEP 1: CREATE TABLES
-- ============================================================

CREATE TABLE animals (
    animal_id SERIAL PRIMARY KEY,
    animal_name VARCHAR(50),
    class_type INTEGER,
    hair BOOLEAN,
    feathers BOOLEAN,
    eggs BOOLEAN,
    milk BOOLEAN,
    aquatic BOOLEAN,
    predator BOOLEAN,
    legs INTEGER,
    domestic BOOLEAN
);

CREATE TABLE enclosures (
    enclosure_id SERIAL PRIMARY KEY,
    enclosure_name VARCHAR(50),
    location VARCHAR(50),
    capacity INTEGER
);

CREATE TABLE behaviour_logs (
    log_id SERIAL PRIMARY KEY,
    animal_id INTEGER REFERENCES animals(animal_id),
    enclosure_id INTEGER REFERENCES enclosures(enclosure_id),
    log_date DATE,
    activity_level INTEGER,
    feeding_observed BOOLEAN,
    notes TEXT
);

CREATE TABLE vet_visits (
    visit_id SERIAL PRIMARY KEY,
    animal_id INTEGER REFERENCES animals(animal_id),
    visit_date DATE,
    reason VARCHAR(100),
    outcome VARCHAR(100)
);

-- STEP 2: LOAD DATA
-- ============================================================

CREATE TABLE zoo_staging (
    animal_name VARCHAR(50), hair INTEGER, feathers INTEGER,
    eggs INTEGER, milk INTEGER, airborne INTEGER, aquatic INTEGER,
    predator INTEGER, toothed INTEGER, backbone INTEGER,
    breathes INTEGER, venomous INTEGER, fins INTEGER,
    legs INTEGER, tail INTEGER, domestic INTEGER,
    catsize INTEGER, class_type INTEGER
);

COPY zoo_staging FROM '/Users/niveditasaha/Downloads/archive (1)/zoo.csv'
DELIMITER ',' CSV HEADER;

INSERT INTO animals 
(animal_name, class_type, hair, feathers, eggs, milk, aquatic, predator, legs, domestic)
SELECT 
    animal_name, class_type,
    hair::BOOLEAN, feathers::BOOLEAN, eggs::BOOLEAN, milk::BOOLEAN,
    aquatic::BOOLEAN, predator::BOOLEAN, legs, domestic::BOOLEAN
FROM zoo_staging;

INSERT INTO enclosures (enclosure_name, location, capacity) VALUES
('Savannah House', 'East Wing', 10),
('Aquatic Centre', 'West Wing', 8),
('Nocturnal House', 'North Wing', 6),
('Bird Sanctuary', 'South Wing', 15),
('Reptile House', 'Central', 12);

INSERT INTO behaviour_logs 
(animal_id, enclosure_id, log_date, activity_level, feeding_observed, notes)
SELECT 
    a.animal_id,
    (FLOOR(RANDOM() * 5) + 1)::INTEGER,
    CURRENT_DATE - (generate_series % 7),
    (FLOOR(RANDOM() * 5) + 1)::INTEGER,
    (RANDOM() > 0.3),
    CASE WHEN RANDOM() < 0.2 THEN 'Unusual behaviour observed' ELSE 'Normal' END
FROM animals a
CROSS JOIN generate_series(1, 7)
WHERE a.animal_id <= 10;

INSERT INTO vet_visits (animal_id, visit_date, reason, outcome) VALUES
(1, CURRENT_DATE - 10, 'Routine checkup', 'Healthy'),
(2, CURRENT_DATE - 5, 'Low activity observed', 'Prescribed rest'),
(3, CURRENT_DATE - 3, 'Not feeding', 'Under observation'),
(5, CURRENT_DATE - 1, 'Routine checkup', 'Healthy'),
(7, CURRENT_DATE - 7, 'Injury on left leg', 'Treatment given');

-- STEP 3: ANALYTICAL QUERIES
-- ============================================================

-- Q1: Animals with low activity in last 7 days (welfare flag)
SELECT a.animal_name,
       b.log_date,
       b.activity_level,
       b.feeding_observed,
       b.notes
FROM behaviour_logs b
JOIN animals a ON b.animal_id = a.animal_id
WHERE b.activity_level <= 2
ORDER BY b.log_date DESC;

-- Q2: Animals not feeding for 2+ days (welfare alert)
SELECT a.animal_name,
       COUNT(*) AS days_not_feeding,
       MIN(b.log_date) AS first_missed,
       MAX(b.log_date) AS last_missed
FROM behaviour_logs b
JOIN animals a ON b.animal_id = a.animal_id
WHERE b.feeding_observed = false
GROUP BY a.animal_name
HAVING COUNT(*) >= 2
ORDER BY days_not_feeding DESC;

-- Q3: Highest welfare risk - low activity AND missed feeding
SELECT a.animal_name,
       ROUND(AVG(b.activity_level), 2) AS avg_activity,
       COUNT(CASE WHEN b.feeding_observed = false THEN 1 END) AS missed_feeds,
       COUNT(*) AS total_logs
FROM behaviour_logs b
JOIN animals a ON b.animal_id = a.animal_id
GROUP BY a.animal_name
HAVING AVG(b.activity_level) < 3 
AND COUNT(CASE WHEN b.feeding_observed = false THEN 1 END) >= 2
ORDER BY avg_activity ASC, missed_feeds DESC;