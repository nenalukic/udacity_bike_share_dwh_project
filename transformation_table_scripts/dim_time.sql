--Create dim_date table
IF OBJECT_ID('dbo.dim_time') IS NOT NULL
BEGIN
    DROP TABLE dbo.dim_time;
END

CREATE TABLE dbo.dim_time (
    time_id serial PRIMARY KEY,
    time_column time,
    hour int,
    minute int,
    second int
);

-- Insert values with incremented timestamps for 24 hours, starting from midnight
INSERT INTO dbo.dim_time (time_column, hour, minute, second)
select t.time_column,
		extract(hour from t.time_column) as hour_column,
    	extract(minute from t.time_column) as minute_column,
    	extract(second from t.time_column) as second_column
from (SELECT time '00:00:00' + (interval '1 second' * generate_series(0, 86399)) as time_column) t;

CREATE UNIQUE INDEX time_column_idx ON dbo.dim_time (time_column);

select TOP 10 * from dbo.dim_time;