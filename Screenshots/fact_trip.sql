
-- CREATE dim_payment TABLE
IF OBJECT_ID('dbo.fact_trip') IS NOT NULL
BEGIN
    DROP EXTERNAL TABLE dbo.fact_trip
END

CREATE EXTERNAL TABLE [dbo].[fact_trip] WITH(
    LOCATION = 'Star_Schema/fact_trip',
    DATA_SOURCE = [my1projectcontainer_my1projectacc_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
) AS (
    SELECT 
    st.trip_id,
    st.rider_id,
    st.rideable_type,
    st.start_station_id, 
    st.end_station_id, 
    DATEDIFF(SECOND , st.start_at, st.ended_at) / 60 AS duration_in_minutes,
    DATEDIFF(DAY, sr.birthday, st.start_at) / 365 AS rider_age,
    st.start_at,
    st.ended_at

FROM 
    staging_trip st
JOIN staging_rider sr ON sr.rider_id = st.rider_id
);

SELECT TOP 10 * FROM dbo.fact_trip;