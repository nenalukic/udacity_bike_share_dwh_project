--Create dim_date table
IF OBJECT_ID('dbo.dim_date') IS NOT NULL
BEGIN
    DROP TABLE dbo.dim_date;
END

-- Create the date dimension table
CREATE TABLE dbo.dim_date (
    date_id SERIAL PRIMARY KEY,
    date DATE NOT NULL,
    year INT NOT NULL,
    quarter INT NOT NULL,
    month INT NOT NULL,
    day INT NOT NULL,
    day_of_week INT NOT NULL,
    is_weekend BOOLEAN NOT NULL
);

-- Populate dim_date table
INSERT INTO dbo.dim_date (date, year, quarter, month, day, day_of_week, is_weekend)
SELECT
    calendar_date AS date,
    EXTRACT(YEAR FROM calendar_date) AS year,
    EXTRACT(QUARTER FROM calendar_date) AS quarter,
    EXTRACT(MONTH FROM calendar_date) AS month,
    EXTRACT(DAY FROM calendar_date) AS day,
    EXTRACT(DOW FROM calendar_date) AS day_of_week,
    CASE WHEN EXTRACT(ISODOW FROM calendar_date) IN (6, 7) THEN TRUE ELSE FALSE END AS is_weekend
FROM generate_series('2020-01-01'::DATE, '2030-12-31'::DATE, '1 day'::INTERVAL) AS calendar_date;

CREATE UNIQUE INDEX date_idx ON dbo.dim_date (date);

SELECT TOP 10 * FROM dbo.dim_date;



SELECT
	ROW_NUMBER() OVER (ORDER BY calendar_date) AS date_id,
    calendar_date AS date,
    DATEPART(YEAR, calendar_date) AS year,
    DATEPART(QUARTER, calendar_date) AS quarter,
    DATEPART(MONTH, calendar_date) AS month,
    DATEPART(DAY, calendar_date) AS day,
    DATEPART(WEEKDAY, calendar_date) AS day_of_week,
    CASE WHEN DATEPART(WEEKDAY, calendar_date) IN (6, 7) THEN 1 ELSE 0 END AS is_weekend
FROM
    (
        SELECT TOP (DATEDIFF(DAY, '2020-01-01', '2030-12-31') + 1)
            calendar_date = DATEADD(DAY, ROW_NUMBER() OVER (ORDER BY a.object_id) - 1, '2020-01-01')
        FROM
            sys.all_objects a
            CROSS JOIN sys.all_objects b
    ) as ts;

CREATE TABLE [dbo].[dim_date] WITH(
    LOCATION = 'Star_schemas/fact_trip'
) AS (
    SELECT
    calendar_date AS date,
    EXTRACT(YEAR FROM calendar_date) AS year,
    EXTRACT(QUARTER FROM calendar_date) AS quarter,
    EXTRACT(MONTH FROM calendar_date) AS month,
    EXTRACT(DAY FROM calendar_date) AS day,
    EXTRACT(DOW FROM calendar_date) AS day_of_week,
    CASE WHEN EXTRACT(ISODOW FROM calendar_date) IN (6, 7) THEN TRUE ELSE FALSE END AS is_weekend
FROM generate_series('2020-01-01'::DATE, '2030-12-31'::DATE, '1 day'::INTERVAL) AS calendar_date
);
