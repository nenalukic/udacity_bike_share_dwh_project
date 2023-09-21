

-- CREATE dim_payment TABLE
IF OBJECT_ID('dbo.fact_payment') IS NOT NULL
BEGIN
    DROP EXTERNAL TABLE dbo.fact_payment
END

CREATE EXTERNAL TABLE [dbo].[fact_payment] WITH(
    LOCATION = 'Star_Schema/fact_payment',
    DATA_SOURCE = [my1projectcontainer_my1projectacc_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
) AS (
    SELECT
        sp.payment_id,    
        sp.rider_id,
	    sp.amount,
        sp.date
FROM 
	staging_payment sp
    JOIN staging_rider sr ON sr.rider_id = sp.rider_id;
);

SELECT TOP 10 * FROM dbo.fact_payment;