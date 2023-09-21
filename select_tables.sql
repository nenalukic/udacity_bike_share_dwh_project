SELECT COUNT(1) AS Count, 'payment' AS Table_name FROM payment
UNION
SELECT COUNT(1) AS Count, 'rider' AS Table_name FROM rider
UNION
SELECT COUNT(1) AS Count, 'station' AS Table_name FROM station
UNION
SELECT COUNT(1) AS Count, 'trip' AS Table_name FROM trip


SELECT COUNT(1) AS Count, 'staging_payment' AS Table_name FROM staging_payment
UNION
SELECT COUNT(1) AS Count, 'staging_rider' AS Table_name FROM staging_rider
UNION
SELECT COUNT(1) AS Count, 'staging_station' AS Table_name FROM staging_station
UNION
SELECT COUNT(1) AS Count, 'staging_trip' AS Table_name FROM staging_trip


SELECT COUNT(1) AS Count, 'fact_payment' AS Table_name FROM dbo.fact_payment
UNION
SELECT COUNT(1) AS Count, 'dim_rider' AS Table_name FROM dbo.dim_rider
UNION
SELECT COUNT(1) AS Count, 'dim_station' AS Table_name FROM dbo.dim_station
UNION
SELECT COUNT(1) AS Count, 'fact_trip' AS Table_name FROM dbo.fact_trip