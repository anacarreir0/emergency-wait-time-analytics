
-- =========================================
-- TRANSFORMED ANALYTICS TABLE
-- Emergency Department Wait Time Analytics
-- =========================================

/*
This table contains the transformed dataset generated
by the ETL pipeline.

Additional business-oriented features include:

- triage_colour
- recommended_wait_time_min
- wait_time_difference_min
- target_compliance

These variables were created to support operational
performance analysis based on urgency levels and
triage-inspired waiting time targets.
*/

CREATE TABLE emergency_analytics_transformed (
    visit_id TEXT,
    patient_id TEXT,
    hospital_id TEXT,
    hospital_name TEXT,
    region TEXT,
    visit_date DATE,
    day_of_week TEXT,
    season TEXT,
    time_of_day TEXT,
    urgency_level TEXT,
    nurse_to_patient_ratio INTEGER,
    specialist_availability INTEGER,
    facility_size_beds INTEGER,
    time_to_registration_min INTEGER,
    time_to_triage_min INTEGER,
    time_to_medical_professional_min INTEGER,
    total_wait_time_min INTEGER,
    patient_outcome TEXT,
    patient_satisfaction INTEGER,
    -- Added during transformation
    triage_colour TEXT,
    recommended_wait_time_min INTEGER,
    wait_time_difference_min INTEGER,
    target_compliance TEXT
);