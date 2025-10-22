/*
============================================
Stored Procedure: Load Bronze Layer (Source -> bronze)
========================================
Script Purpose:
  This stored procedure loads data into the 'bronze' schema from external CSV files.
  It performs the followin actions;
  - Truncates the bronze tables before loading data
  - used the BULK INSERT command to load data from the csv files to bronze tables.

Parameters:
None.
This stored procedure does not accept any parameters or return any values

Usage Example:
  EXEC bronze.load_bronze;
=================================================================================
*/

EXEC bronze.load_bronze 

CREATE OR ALTER PROCEDURE bronze.load_bronze 
AS
BEGIN
    BEGIN TRY
        DECLARE @start_time DATETIME, @end_time DATETIME;

        PRINT '++++++++++++++++++++++++++++++++++++++++++++++';
        PRINT '        STARTING BRONZE LAYER LOAD';
        PRINT '++++++++++++++++++++++++++++++++++++++++++++++';

        ----------------------------------------------------
        -- CRM: CUSTOMER INFO
        ----------------------------------------------------
        PRINT '>> Loading: crm_cust_info';
        SET @start_time = GETDATE();

        PRINT '   Truncating Table: bronze.crm_cust_info';
        TRUNCATE TABLE [bronze].[crm_cust_info];

        PRINT '   Inserting Data Into: bronze.crm_cust_info';
        BULK INSERT [bronze].[crm_cust_info]
        FROM 'C:\Users\admin\Desktop\SQL WAREHOUSE PROJECT\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT '   Load Duration (crm_cust_info): ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(10)) + ' seconds';
        PRINT '----------------------------------------------------';

        ----------------------------------------------------
        -- CRM: PRODUCT INFO
        ----------------------------------------------------
        PRINT '>> Loading: crm_prd_info';
        SET @start_time = GETDATE();

        PRINT '   Truncating Table: bronze.crm_prd_info';
        TRUNCATE TABLE [bronze].[crm_prd_info];

        PRINT '   Inserting Data Into: bronze.crm_prd_info';
        BULK INSERT [bronze].[crm_prd_info]
        FROM 'C:\Users\admin\Desktop\SQL WAREHOUSE PROJECT\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT '   Load Duration (crm_prd_info): ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(10)) + ' seconds';
        PRINT '----------------------------------------------------';

        ----------------------------------------------------
        -- CRM: SALES DETAILS
        ----------------------------------------------------
        PRINT '>> Loading: crm_sales_details';
        SET @start_time = GETDATE();

        PRINT '   Truncating Table: bronze.crm_sales_details';
        TRUNCATE TABLE [bronze].[crm_sales_details];

        PRINT '   Inserting Data Into: bronze.crm_sales_details';
        BULK INSERT [bronze].[crm_sales_details]
        FROM 'C:\Users\admin\Desktop\SQL WAREHOUSE PROJECT\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT '   Load Duration (crm_sales_details): ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(10)) + ' seconds';
        PRINT '----------------------------------------------------';

        ----------------------------------------------------
        -- ERP: CUSTOMER AZ12
        ----------------------------------------------------
        PRINT '>> Loading: erp_cust_az12';
        SET @start_time = GETDATE();

        PRINT '   Truncating Table: bronze.erp_cust_az12';
        TRUNCATE TABLE [bronze].[erp_cust_az12];

        PRINT '   Inserting Data Into: bronze.erp_cust_az12';
        BULK INSERT [bronze].[erp_cust_az12]
        FROM 'C:\Users\admin\Desktop\SQL WAREHOUSE PROJECT\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT '   Load Duration (erp_cust_az12): ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(10)) + ' seconds';
        PRINT '----------------------------------------------------';

        ----------------------------------------------------
        -- ERP: LOCATION A101
        ----------------------------------------------------
        PRINT '>> Loading: erp_loc_a101';
        SET @start_time = GETDATE();

        PRINT '   Truncating Table: bronze.erp_loc_a101';
        TRUNCATE TABLE [bronze].[erp_loc_a101];

        PRINT '   Inserting Data Into: bronze.erp_loc_a101';
        BULK INSERT [bronze].[erp_loc_a101]
        FROM 'C:\Users\admin\Desktop\SQL WAREHOUSE PROJECT\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT '   Load Duration (erp_loc_a101): ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(10)) + ' seconds';
        PRINT '----------------------------------------------------';

        ----------------------------------------------------
        -- ERP: PX CATEGORY GIV2
        ----------------------------------------------------
        PRINT '>> Loading: erp_px_cat_giv2';
        SET @start_time = GETDATE();

        PRINT '   Truncating Table: bronze.erp_px_cat_giv2';
        TRUNCATE TABLE [bronze].[erp_px_cat_giv2];

        PRINT '   Inserting Data Into: bronze.erp_px_cat_giv2';
        BULK INSERT [bronze].[erp_px_cat_giv2]
        FROM 'C:\Users\admin\Desktop\SQL WAREHOUSE PROJECT\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT '   Load Duration (erp_px_cat_giv2): ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(10)) + ' seconds';
        PRINT '----------------------------------------------------';

        PRINT '++++++++++++++++++++++++++++++++++++++++++++++';
        PRINT '       BRONZE LAYER LOAD COMPLETED SUCCESSFULLY';
        PRINT '++++++++++++++++++++++++++++++++++++++++++++++';

    END TRY
    BEGIN CATCH
        PRINT '=============================================';
        PRINT '   ERROR OCCURRED DURING LOADING BRONZE LAYER';
        PRINT '   ERROR MESSAGE: ' + ERROR_MESSAGE();
        PRINT '=============================================';
    END CATCH
END;
