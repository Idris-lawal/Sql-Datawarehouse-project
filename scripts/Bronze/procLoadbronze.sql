/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/
CREATE OR ALTER  PROCEDURE BRONZE.Load_bronze
as 
BEGIN
	DECLARE @STARTTIME DATETIME, @ENDTIME DATETIME, @BATCHSTARTTIME DATETIME, @BATCHENDTIME DATETIME
	BEGIN TRY
		SET @BATCHSTARTTIME = GETDATE()
		PRINT '==============================================================================================================';
		PRINT 'Loading Bronze layer';
		PRINT '==============================================================================================================';

		PRINT '----------------------------------------------------------------------------------------------------------------';
		PRINT 'Loading CRM tables';
		PRINT '----------------------------------------------------------------------------------------------------------------';

		--[Bronze].[CRM_cust_info]
		SET @STARTTIME = GETDATE()
		PRINT '>> Truncating Data [Bronze].[CRM_cust_info]'
		TRUNCATE TABLE [Bronze].[CRM_cust_info]

		PRINT '>> Inserting Data into [Bronze].[CRM_cust_info]'
		BULK INSERT [Bronze].[CRM_cust_info]
		FROM 'C:\Users\User\Desktop\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK 
		);
		SET @ENDTIME = GETDATE()
		PRINT '>> Load Duration:' + CAST(DATEDIFF(second,@STARTTIME,@ENDTIME) AS NVARCHAR) + ' Seconds';
		PRINT'-----------------------';

		--[Bronze].[CRM_prd_info]
		SET @STARTTIME = GETDATE()
		PRINT '>> Truncating Data [Bronze].[CRM_prd_info]'
		TRUNCATE TABLE [Bronze].[CRM_prd_info]

		PRINT '>> Inserting Data into [Bronze].[CRM_prd_info]'
		BULK INSERT [Bronze].[CRM_prd_info]
		FROM 'C:\Users\User\Desktop\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK 
		);
		SET @ENDTIME = GETDATE()
		PRINT '>> Load Duration:' + CAST(DATEDIFF(second,@STARTTIME,@ENDTIME) AS NVARCHAR) + ' Seconds';
		PRINT'-----------------------';


		--[Bronze].[CRM_sales_details]
		SET @STARTTIME = GETDATE()
		PRINT '>> Truncating Data [Bronze].[CRM_sales_details]'
		TRUNCATE TABLE [Bronze].[CRM_sales_details]

		PRINT '>> Inserting Data into [Bronze].[CRM_sales_details]'
		BULK INSERT [Bronze].[CRM_sales_details]
		FROM 'C:\Users\User\Desktop\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK 
		);
		SET @ENDTIME = GETDATE()
		PRINT '>> Load Duration:' + CAST(DATEDIFF(second,@STARTTIME,@ENDTIME) AS NVARCHAR) + ' Seconds';
		PRINT'-----------------------';


		PRINT '----------------------------------------------------------------------------------------------------------------';
		PRINT 'Loading ERP tables';
		PRINT '----------------------------------------------------------------------------------------------------------------';

		--[Bronze].[ERP_CUST_AZ12]
		SET @STARTTIME = GETDATE()
		PRINT '>> Truncating Data [Bronze].[ERP_CUST_AZ12]'
		TRUNCATE TABLE [Bronze].[ERP_CUST_AZ12]

		PRINT '>> Inserting Data into [Bronze].[ERP_CUST_AZ12]'
		BULK INSERT [Bronze].[ERP_CUST_AZ12]
		FROM 'C:\Users\User\Desktop\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK 
		);
		SET @ENDTIME = GETDATE()
		PRINT '>> Load Duration:' + CAST(DATEDIFF(second,@STARTTIME,@ENDTIME) AS NVARCHAR) + ' Seconds';
		PRINT'-----------------------';

		--[Bronze].[ERP_LOC_A101]
		SET @STARTTIME = GETDATE()
		PRINT '>> Truncating Data [Bronze].[ERP_LOC_A101]'
		TRUNCATE TABLE [Bronze].[ERP_LOC_A101]

		PRINT '>> Inserting Data into [Bronze].[ERP_LOC_A101]'
		BULK INSERT [Bronze].[ERP_LOC_A101]
		FROM 'C:\Users\User\Desktop\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK 
		);
		SET @ENDTIME = GETDATE()
		PRINT '>> Load Duration:' + CAST(DATEDIFF(second,@STARTTIME,@ENDTIME) AS NVARCHAR) + ' Seconds';
		PRINT'-----------------------';

		--[Bronze].[ERP_PX_CAT_G1V2]
		SET @STARTTIME = GETDATE()
		PRINT '>> Truncating Data [Bronze].[ERP_PX_CAT_G1V2]'
		TRUNCATE TABLE [Bronze].[ERP_PX_CAT_G1V2]

		PRINT '>> Inserting Data into [Bronze].[ERP_PX_CAT_G1V2]'
		BULK INSERT[Bronze].[ERP_PX_CAT_G1V2]
		FROM 'C:\Users\User\Desktop\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK 
		);
		SET @ENDTIME = GETDATE()
		PRINT '>> Load Duration:' + CAST(DATEDIFF(second,@STARTTIME,@ENDTIME) AS NVARCHAR) + ' Seconds';
		PRINT'-----------------------';

	END TRY

	BEGIN CATCH
		PRINT '====================================================================================================================='
		PRINT 'ERROR OCCURED DURING LOADING OF BRONZE LAYER'
		PRINT 'ERROR MESSAGE' + ERROR_MESSAGE()
		PRINT 'ERROR NUMBER' + CAST (ERROR_NUMBER() AS NVARCHAR)
		PRINT '====================================================================================================================='
	END CATCH
	SET @BATCHENDTIME = GETDATE()
	PRINT '>> BATCH Duration:' + CAST(DATEDIFF(second,@BATCHSTARTTIME,@BATCHENDTIME) AS NVARCHAR) + ' Seconds';
	PRINT'-----------------------';
END
