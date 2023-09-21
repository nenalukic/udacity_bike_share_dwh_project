
-- CREATE dim_payment TABLE
IF OBJECT_ID('dbo.dim_station') IS NOT NULL
BEGIN
    DROP EXTERNAL TABLE dbo.dim_station
END

CREATE EXTERNAL TABLE [dbo].[dim_station] WITH(
    LOCATION = 'Star_Schema/dim_station',
    DATA_SOURCE = [my1projectcontainer_my1projectacc_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
) AS (
    SELECT
        station_id,
	    name,
	    latitude,
	    longitude
FROM 
	staging_station
);

SELECT TOP 10 * FROM dbo.dim_station;