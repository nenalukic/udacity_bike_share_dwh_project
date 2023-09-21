IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseDelimitedTextFormat') 
	CREATE EXTERNAL FILE FORMAT [SynapseDelimitedTextFormat] 
	WITH ( FORMAT_TYPE = DELIMITEDTEXT ,
	       FORMAT_OPTIONS (
			 FIELD_TERMINATOR = ',',
			 STRING_DELIMITER = '"',
			 USE_TYPE_DEFAULT = FALSE
			))
GO

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'nenaprojectcontainer_nenaprojectacc_dfs_core_windows_net') 
	CREATE EXTERNAL DATA SOURCE [nenaprojectcontainer_nenaprojectacc_dfs_core_windows_net] 
	WITH (
		LOCATION = 'abfss://data@udacitybikeshareadls.dfs.core.windows.net', 
		TYPE = HADOOP 
	)
GO

CREATE EXTERNAL TABLE staging_trip (
	[trip_id] nvarchar(4000),
	[rideable_type] nvarchar(4000),
	[start_at] varchar(50),
	[ended_at] varchar(50),
	[start_station_id] nvarchar(4000),
	[end_station_id] nvarchar(4000),
	[rider_id] bigint
	)
	WITH (
	LOCATION = 'Source/publictrip.csv',
	DATA_SOURCE = [nenaprojectcontainer_nenaprojectacc_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
	)
GO


SELECT TOP 100 * FROM dbo.staging_trip
GO