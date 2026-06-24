-- =========================================
-- BUSINESS QUESTIONS
-- Emergency Department Wait Time Analytics
-- =========================================

/*
This script contains business-oriented analyses focused on
operational performance and triage target compliance.
*/


-- =========================================
-- OVERALL TRIAGE TARGET COMPLIANCE
-- =========================================

-- How many visits complied with the recommended waiting time target?

SELECT
    target_compliance,
    COUNT(*) AS total_visits
FROM emergency_analytics_transformed
GROUP BY target_compliance;


-- =========================================
-- WAIT TIME PERFORMANCE BY URGENCY LEVEL
-- =========================================

-- Compare actual waiting times against recommended targets.

SELECT
    urgency_level,
    ROUND(AVG(total_wait_time_min)::numeric, 2) AS avg_wait_time,
    ROUND(AVG(recommended_wait_time_min)::numeric, 2) AS recommended_wait_time,
    ROUND(AVG(wait_time_difference_min)::numeric, 2) AS avg_delay
FROM emergency_analytics_transformed
GROUP BY urgency_level
ORDER BY recommended_wait_time;


-- =========================================
-- COMPLIANCE BY TIME OF DAY
-- =========================================

-- Which periods of the day have the best and worst compliance?

SELECT
    time_of_day,
    target_compliance,
    COUNT(*) AS total_visits
FROM emergency_analytics_transformed
GROUP BY time_of_day, target_compliance
ORDER BY time_of_day;


-- =========================================
-- COMPLIANCE RATE BY TRIAGE COLOUR
-- =========================================

-- Calculate compliance percentage for each triage category.

SELECT
    triage_colour,
    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN target_compliance = 'Compliant'
                THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS compliance_rate
FROM emergency_analytics_transformed
GROUP BY triage_colour
ORDER BY compliance_rate DESC;


-- =========================================
-- AVERAGE DELAY BY TRIAGE COLOUR
-- =========================================

-- Measure how far each triage category is from its target.

SELECT
    triage_colour,
    ROUND(
        AVG(wait_time_difference_min)::numeric,
        2
    ) AS avg_delay
FROM emergency_analytics_transformed
GROUP BY triage_colour
ORDER BY avg_delay;


-- =========================================
-- COMPLIANCE BY URGENCY LEVEL
-- =========================================

-- Identify which urgency levels contribute most to target breaches.

SELECT
    urgency_level,
    target_compliance,
    COUNT(*) AS total_visits
FROM emergency_analytics_transformed
GROUP BY urgency_level, target_compliance
ORDER BY urgency_level;

-- =========================================
-- PATIENT SATISFACTION VS COMPLIANCE
-- =========================================

SELECT
    target_compliance,
    ROUND(
        AVG(patient_satisfaction)::numeric,
        2
    ) AS avg_satisfaction
FROM emergency_analytics_transformed
GROUP BY target_compliance;

-- =========================================
-- HOSPITAL PERFORMANCE
-- =========================================

SELECT
    hospital_name,
    ROUND(
        AVG(total_wait_time_min)::numeric,
        2
    ) AS avg_wait_time,
    ROUND(
        AVG(wait_time_difference_min)::numeric,
        2
    ) AS avg_delay
FROM emergency_analytics_transformed
GROUP BY hospital_name
ORDER BY avg_delay DESC;

