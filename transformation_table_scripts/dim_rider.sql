

IF OBJECT_ID('dbo.dim_rider') IS NOT NULL
BEGIN
    DROP EXTERNAL TABLE dbo.dim_rider
END

CREATE EXTERNAL TABLE [dbo].[dim_rider] WITH(
    LOCATION = 'Star_Schema/dim_rider',
    DATA_SOURCE = [my1projectcontainer_my1projectacc_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
) AS (
    SELECT 
    rider_id,
    First_Name,
    Last_Name,
    Address,
    Birthday,
    Account_start_date,
    Account_end_date,
    Is_member
FROM staging_rider
);

-- Verify the output
SELECT TOP 10 * FROM dbo.dim_rider;