-- =========================================
-- EXPLORATORY SQL ANALYSIS
-- Emergency Department Wait Time Analytics
-- =========================================

/*
This script contains exploratory SQL queries used to understand
the transformed emergency department dataset.

Main table used:
- emergency_analytics_transformed
*/


-- =========================================
-- DATA PREVIEW
-- =========================================

-- Preview the first rows of the transformed dataset.

SELECT *
FROM emergency_analytics_transformed
LIMIT 5;


-- Count total number of visits.

SELECT COUNT(*) AS total_visits
FROM emergency_analytics_transformed;


-- =========================================
-- WAIT TIME BY URGENCY LEVEL
-- =========================================

-- Evaluate whether higher urgency levels are associated
-- with shorter emergency department waiting times.

SELECT
    urgency_level,
    ROUND(AVG(total_wait_time_min)::numeric, 2) AS avg_wait_time
FROM emergency_analytics_transformed
GROUP BY urgency_level
ORDER BY avg_wait_time ASC;


-- =========================================
-- WAIT TIME BY TIME OF DAY
-- =========================================

-- Identify which periods of the day are associated
-- with higher average waiting times.

SELECT
    time_of_day,
    ROUND(AVG(total_wait_time_min)::numeric, 2) AS avg_wait_time
FROM emergency_analytics_transformed
GROUP BY time_of_day
ORDER BY avg_wait_time DESC;


-- =========================================
-- WAIT TIME BY SEASON
-- =========================================

-- Explore whether waiting times vary across seasons.

SELECT
    season,
    ROUND(AVG(total_wait_time_min)::numeric, 2) AS avg_wait_time
FROM emergency_analytics_transformed
GROUP BY season
ORDER BY avg_wait_time DESC;


-- =========================================
-- PATIENT SATISFACTION BY URGENCY LEVEL
-- =========================================

-- Explore whether patient satisfaction differs across urgency levels.

SELECT
    urgency_level,
    ROUND(AVG(patient_satisfaction)::numeric, 2) AS avg_satisfaction
FROM emergency_analytics_transformed
GROUP BY urgency_level
ORDER BY avg_satisfaction DESC;


-- =========================================
-- PATIENT SATISFACTION BY TIME OF DAY
-- =========================================

-- Explore whether patient satisfaction differs across periods of the day.

SELECT
    time_of_day,
    ROUND(AVG(patient_satisfaction)::numeric, 2) AS avg_satisfaction
FROM emergency_analytics_transformed
GROUP BY time_of_day
ORDER BY avg_satisfaction DESC;


-- =========================================
-- WAIT TIME BY NURSE-TO-PATIENT RATIO
-- =========================================

-- Investigate the relationship between staffing ratio
-- and average waiting time.

SELECT
    nurse_to_patient_ratio,
    ROUND(AVG(total_wait_time_min)::numeric, 2) AS avg_wait_time
FROM emergency_analytics_transformed
GROUP BY nurse_to_patient_ratio
ORDER BY nurse_to_patient_ratio;


-- =========================================
-- WAIT TIME BY SPECIALIST AVAILABILITY
-- =========================================

-- Explore whether specialist availability is associated
-- with average waiting time.

SELECT
    specialist_availability,
    ROUND(AVG(total_wait_time_min)::numeric, 2) AS avg_wait_time
FROM emergency_analytics_transformed
GROUP BY specialist_availability
ORDER BY specialist_availability;


-- =========================================
-- WAIT TIME BY FACILITY SIZE
-- =========================================

-- Explore whether hospital size is associated with waiting times.

SELECT
    facility_size_beds,
    ROUND(AVG(total_wait_time_min)::numeric, 2) AS avg_wait_time
FROM emergency_analytics_transformed
GROUP BY facility_size_beds
ORDER BY facility_size_beds;


-- =========================================
-- FILTERING WITH WHERE
-- =========================================

-- Calculate the average waiting time only for critical cases.

SELECT
    ROUND(AVG(total_wait_time_min)::numeric, 2) AS avg_critical_wait_time
FROM emergency_analytics_transformed
WHERE urgency_level = 'Critical';


-- Calculate the average waiting time in larger hospitals.

SELECT
    ROUND(AVG(total_wait_time_min)::numeric, 2) AS avg_large_hospital_wait_time
FROM emergency_analytics_transformed
WHERE facility_size_beds > 100;


-- =========================================
-- COMBINING WHERE AND GROUP BY
-- =========================================

-- Analyze average waiting time for critical cases
-- across different periods of the day.

SELECT
    time_of_day,
    ROUND(AVG(total_wait_time_min)::numeric, 2) AS avg_wait_time
FROM emergency_analytics_transformed
WHERE urgency_level = 'Critical'
GROUP BY time_of_day
ORDER BY avg_wait_time DESC;


-- =========================================
-- HAVING
-- =========================================

/*
Identify urgency levels with an average waiting time above 50 minutes.
HAVING is used because the filter is applied after aggregation.
*/

SELECT
    urgency_level,
    ROUND(AVG(total_wait_time_min)::numeric, 2) AS avg_wait_time
FROM emergency_analytics_transformed
GROUP BY urgency_level
HAVING AVG(total_wait_time_min) > 50
ORDER BY avg_wait_time DESC;


-- Identify periods of the day with average patient satisfaction below 5.

SELECT
    time_of_day,
    ROUND(AVG(patient_satisfaction)::numeric, 2) AS avg_satisfaction
FROM emergency_analytics_transformed
GROUP BY time_of_day
HAVING AVG(patient_satisfaction) < 5
ORDER BY avg_satisfaction DESC;