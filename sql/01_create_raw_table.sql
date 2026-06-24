-- =========================================
-- CREATE TABLES
-- Emergency Department Wait Time Analytics
-- =========================================

/*This table stores the original emergency department dataset.
It includes patient visit identifiers, hospital information,
timing metrics, urgency levels, staffing indicators and outcomes.*/

-- Raw source table

CREATE TABLE emergency_analytics (
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
    patient_satisfaction INTEGER
);
