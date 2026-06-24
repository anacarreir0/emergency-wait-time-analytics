-- =========================================
-- MANUAL DATA IMPORT (OPTIONAL)
-- Emergency Department Wait Time Analytics
-- =========================================

/*
This script was used during the initial SQL exploration phase
to manually import the raw dataset into PostgreSQL.

The production pipeline now uses:
Extract → Transform → Load (Python)

through the ETL process.
*/



COPY emergency_visits
FROM 'data/raw/er_wait_time.csv'
DELIMITER ','
CSV HEADER;