-- Drop the external file format if it exists
IF EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseDelimitedTextFormat')
BEGIN
    DROP EXTERNAL FILE FORMAT SynapseDelimitedTextFormat;
END

IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseDelimitedTextFormat') 
	CREATE EXTERNAL FILE FORMAT [SynapseDelimitedTextFormat] 
	WITH ( FORMAT_TYPE = DELIMITEDTEXT ,
	       FORMAT_OPTIONS (
			 FIELD_TERMINATOR = ',',
			 STRING_DELIMITER = '"',
			 FIRST_ROW = 2,
			 USE_TYPE_DEFAULT = TRUE
			))
GO

-- Drop the external data source if it exists
IF EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'nenaprojectcontainer_nenaprojectacc_dfs_core_windows_net')
BEGIN
    DROP EXTERNAL DATA SOURCE nenaprojectcontainer_nenaprojectacc_dfs_core_windows_net;
END

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'nenaprojectcontainer_nenaprojectacc_dfs_core_windows_net') 
	CREATE EXTERNAL DATA SOURCE [nenaprojectcontainer_nenaprojectacc_dfs_core_windows_net] 
	WITH (
		LOCATION = 'abfss://nenaprojectcontainer@nenaprojectacc.dfs.core.windows.net' 
	)
GO

CREATE EXTERNAL TABLE staging_rider (
	[Rider_Id] bigint,
	[Address] nvarchar(4000),
	[First_Name] nvarchar(4000),
	[Last_Name] nvarchar(4000),
	[Birthday] varchar(50),
	[Account_start_date] varchar(50),
	[Account_end_date] varchar(50),
	[Is_member] bit
	)
	WITH (
	LOCATION = 'Source/publicrider.csv',
	DATA_SOURCE = [nenaprojectcontainer_nenaprojectacc_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
	)
GO

SELECT TOP 100 * FROM dbo.staging_rider
GO