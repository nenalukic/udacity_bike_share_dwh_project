IF OBJECT_ID('dbo.dim_date') IS NOT NULL
BEGIN
    DROP EXTERNAL TABLE dbo.dim_date
END

CREATE EXTERNAL TABLE [dbo].[dim_date] WITH(
    LOCATION = 'Star_Schema/dim_date',
    DATA_SOURCE = [nenaprojectcontainer_nenaprojectacc_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
) AS (
    SELECT
        ROW_NUMBER() OVER (ORDER BY Date) AS date_id,
        date,
        DATEPART(DAY, CONVERT(Date, Date)) AS DAY,
        DATEPART(MONTH, CONVERT(Date,Date)) AS MONTH, 
        DATEPART(QUARTER, CONVERT(Date,Date)) AS QUARTER,
        DATEPART(YEAR, CONVERT(Date,Date)) AS  YEAR,
        DATEPART(DAYOFYEAR,CONVERT(Date,Date)) AS DAY_OF_YEAR,
        DATEPART(WEEKDAY,CONVERT(Date,Date)) AS DAY_OF_WEEK
    FROM
        dbo.staging_payment
);

SELECT TOP 10 * FROM [dbo].[dim_date];
























