
-- Encounter Data Analysis
-- What is the average base encounter cost for ambulatory encounters?
SELECT AVG(base_encounter_cost) AS avg_base
FROM testdb.healthcaredemo
WHERE encounterclass = 'ambulatory';

-- How many encounters were classified as hospital encounters with a problem in 2022?
SELECT COUNT(encounter_id) AS enc_problem
FROM testdb.healthcaredemo
WHERE enc_type = 'Hospital Encounter with Problem';

-- What are the most common reasons for encounters in the dataset?
SELECT enc_reason, COUNT(*) AS encounter_count
FROM testdb.healthcaredemo
GROUP BY enc_reason
ORDER BY encounter_count DESC;

-- Patient Demographic
-- What is our patient mix by race and ethnicity?
SELECT race, ethnicity, COUNT(*) as NUM
FROM testdb.healthcaredemo
GROUP BY race, ethnicity;

-- What is the age groups?
SELECT 
	CASE
		WHEN FLOOR(DATEDIFF(CURDATE(), birthdate) / 365) <= 18 THEN '0-18'
        WHEN FLOOR(DATEDIFF(CURDATE(), birthdate) / 365) BETWEEN 19 AND 65 THEN '19-65'
        WHEN FLOOR(DATEDIFF(CURDATE(), birthdate) / 365) >= 66 THEN '66+'
	END AS age_group,
    COUNT(*) AS patient_count
FROM testdb.healthcaredemo
GROUP BY age_group
ORDER BY age_group;

-- How many unique patients are there?
SELECT COUNT(DISTINCT(patient_id))
FROM testdb.healthcaredemo;


-- Cost and Payment Analysis
-- How does the average base encounter cost vary between different payers?
SELECT payer, AVG(total_claim_cost) as avg_total
FROM testdb.healthcaredemo
GROUP BY payer
ORDER BY avg_total DESC;

-- How does the average base encounter cost vary between different payers?
SELECT payer, AVG(base_encounter_cost) AS avg_base
FROM testdb.healthcaredemo
GROUP BY payer
ORDER BY avg_base DESC;

-- Which payer accounts for the highest total encountercosts?
SELECT payer_category, SUM(total_claim_cost) as total_encounter_cost
FROM testdb.healthcaredemo
GROUP BY payer_category
ORDER BY total_encounter_cost DESC
LIMIT 1;


