-- =========================================
-- CREATE RELATIONAL TABLES
-- =========================================

/*
Create a hospitals table by extracting unique hospital information.
This simulates a more realistic relational database structure.
*/

CREATE TABLE hospitals AS
SELECT DISTINCT
    hospital_id,
    hospital_name,
    region,
    facility_size_beds
FROM emergency_analytics_transformed;


-- Create a visits table with visit-level information.

CREATE TABLE visits AS
SELECT
    visit_id,
    patient_id,
    hospital_id,
    urgency_level,
    total_wait_time_min,
    patient_outcome,
    patient_satisfaction,
    time_of_day,
    triage_colour,
    target_compliance
FROM emergency_analytics_transformed;

-- =========================================
-- INNER JOIN
-- =========================================

/*
Join visits with hospitals using hospital_id.
This allows visit-level data to be analyzed together
with hospital-level information.
*/

SELECT
    v.visit_id,
    h.hospital_name,
    h.region,
    h.facility_size_beds,
    v.urgency_level,
    v.triage_colour,
    v.total_wait_time_min,
    v.target_compliance
FROM visits v
INNER JOIN hospitals h
ON v.hospital_id = h.hospital_id
LIMIT 10;

-- =========================================
-- CREATE VIEW
-- =========================================

/*
Create a reusable view combining visit and hospital information.
Views are useful for dashboards and repeated analysis.
*/

CREATE VIEW visit_summary AS
SELECT
    v.visit_id,
    h.hospital_name,
    h.region,
    h.facility_size_beds,
    v.urgency_level,
    v.triage_colour,
    v.total_wait_time_min,
    v.patient_satisfaction,
    v.target_compliance,
    v.time_of_day
FROM visits v
INNER JOIN hospitals h
ON v.hospital_id = h.hospital_id;

-- Preview the view.

SELECT *
FROM visit_summary
LIMIT 10;

-- =========================================
-- LEFT JOIN
-- =========================================

/*
Return all visits, even if matching hospital
information does not exist.

In this dataset the result is expected to be
similar to the INNER JOIN because all hospital_ids
are present in both tables.
*/

SELECT
    v.visit_id,
    v.urgency_level,
    h.hospital_name,
    h.region
FROM visits v
LEFT JOIN hospitals h
ON v.hospital_id = h.hospital_id
LIMIT 10;

-- Identify visits without matching hospital information

SELECT
    v.visit_id,
    v.hospital_id
FROM visits v
LEFT JOIN hospitals h
ON v.hospital_id = h.hospital_id
WHERE h.hospital_id IS NULL;