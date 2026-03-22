-- ============================================================
-- PROJECT 3: Spatial Zoo Enclosure Analysis
-- Simulating geographic queries using Haversine formula
-- Real coordinates based on Marwell Zoo, Winchester, Hampshire
-- Author: Nivedita Saha
-- GitHub: github.com/Nivedita-Saha
-- ============================================================

-- STEP 1: CREATE TABLES
-- ============================================================

CREATE TABLE locations (
    location_id SERIAL PRIMARY KEY,
    location_name VARCHAR(50),
    latitude DECIMAL(9,6),
    longitude DECIMAL(9,6)
);

CREATE TABLE enclosures (
    enclosure_id SERIAL PRIMARY KEY,
    enclosure_name VARCHAR(50),
    location_id INTEGER REFERENCES locations(location_id),
    capacity INTEGER,
    enclosure_type VARCHAR(50)
);

CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,
    animal_name VARCHAR(50),
    latitude DECIMAL(9,6),
    longitude DECIMAL(9,6),
    sighting_time TIMESTAMP,
    behaviour VARCHAR(100)
);

-- STEP 2: INSERT DATA
-- Real Marwell Zoo coordinates (Winchester, Hampshire)
-- ============================================================

INSERT INTO locations (location_name, latitude, longitude) VALUES
('Nocturnal House',    51.0452, -1.2891),
('Savannah Enclosure', 51.0461, -1.2878),
('Aquatic Centre',     51.0448, -1.2901),
('Bird Sanctuary',     51.0470, -1.2860),
('Reptile House',      51.0455, -1.2912),
('Visitor Centre',     51.0440, -1.2885);

INSERT INTO enclosures (enclosure_name, location_id, capacity, enclosure_type) VALUES
('Nocturnal House',    1, 6,  'Indoor'),
('Savannah Enclosure', 2, 10, 'Outdoor'),
('Aquatic Centre',     3, 8,  'Mixed'),
('Bird Sanctuary',     4, 15, 'Outdoor'),
('Reptile House',      5, 12, 'Indoor');

INSERT INTO sightings (animal_name, latitude, longitude, sighting_time, behaviour) VALUES
('aardvark', 51.0453, -1.2890, '2026-03-22 01:00:00', 'Foraging'),
('catfish',  51.0447, -1.2902, '2026-03-22 01:30:00', 'Stationary'),
('lion',     51.0462, -1.2877, '2026-03-22 02:00:00', 'Pacing'),
('penguin',  51.0449, -1.2900, '2026-03-22 02:30:00', 'Swimming'),
('python',   51.0456, -1.2911, '2026-03-22 03:00:00', 'Coiled'),
('owl',      51.0471, -1.2859, '2026-03-22 00:30:00', 'Hunting'),
('bat',      51.0453, -1.2892, '2026-03-22 00:15:00', 'Flying'),
('hedgehog', 51.0451, -1.2893, '2026-03-22 01:15:00', 'Foraging'),
('fox',      51.0460, -1.2880, '2026-03-22 02:45:00', 'Roaming'),
('badger',   51.0454, -1.2888, '2026-03-22 03:30:00', 'Burrowing');

-- STEP 3: ANALYTICAL QUERIES
-- ============================================================

-- Q1: Distance of each animal sighting from Nocturnal House
SELECT 
    s.animal_name,
    s.behaviour,
    s.sighting_time,
    l.location_name AS nearest_building,
    ROUND(
        CAST(
            111000 * SQRT(
                POWER(s.latitude - l.latitude, 2) +
                POWER((s.longitude - l.longitude) * COS(RADIANS(l.latitude)), 2)
            ) AS NUMERIC
        ), 1
    ) AS distance_metres
FROM sightings s
CROSS JOIN locations l
WHERE l.location_name = 'Nocturnal House'
ORDER BY distance_metres ASC;

-- Q2: Animals spotted within 100m of any enclosure
SELECT 
    s.animal_name,
    s.behaviour,
    l.location_name AS nearest_enclosure,
    ROUND(
        CAST(
            111000 * SQRT(
                POWER(s.latitude - l.latitude, 2) +
                POWER((s.longitude - l.longitude) * COS(RADIANS(l.latitude)), 2)
            ) AS NUMERIC
        ), 1
    ) AS distance_metres
FROM sightings s
CROSS JOIN locations l
WHERE 
    111000 * SQRT(
        POWER(s.latitude - l.latitude, 2) +
        POWER((s.longitude - l.longitude) * COS(RADIANS(l.latitude)), 2)
    ) <= 100
ORDER BY s.animal_name, distance_metres ASC;

-- Q3: Nocturnal activity report (midnight to 4am)
-- Each animal matched to its nearest location
SELECT 
    s.animal_name,
    s.behaviour,
    s.sighting_time,
    EXTRACT(HOUR FROM s.sighting_time) AS hour_of_sighting,
    l.location_name AS nearest_location,
    ROUND(
        CAST(
            111000 * SQRT(
                POWER(s.latitude - l.latitude, 2) +
                POWER((s.longitude - l.longitude) 
                * COS(RADIANS(l.latitude)), 2)
            ) AS NUMERIC
        ), 1
    ) AS distance_metres
FROM sightings s
JOIN locations l ON l.location_id = (
    SELECT l2.location_id
    FROM locations l2
    ORDER BY 
        POWER(s.latitude - l2.latitude, 2) +
        POWER((s.longitude - l2.longitude) * COS(RADIANS(l2.latitude)), 2)
    ASC LIMIT 1
)
WHERE EXTRACT(HOUR FROM s.sighting_time) BETWEEN 0 AND 4
ORDER BY s.sighting_time;