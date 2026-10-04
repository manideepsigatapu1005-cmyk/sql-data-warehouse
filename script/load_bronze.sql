USE DataWarehouse;
GO

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
   DECLARE @startTime DATETIME ,
            @endTime DATETIME;
   BEGIN TRY
    print '===========================================';
    PRINT 'Loading Bronze layer...';
    print '===========================================';
    
    print '-------------------------------------------';
    print 'Loading CRM data...';
    print '-------------------------------------------';
    set @startTime = GETDATE();
    print 'truncating table: bronze.crm_cust_info';
    TRUNCATE TABLE bronze.crm_cust_info;
    print 'inserting data into table: bronze.crm_cust_info';
    BULK INSERT bronze.crm_cust_info
    FROM '/var/opt/mssql/data/datasets/source_crm/cust_info.csv'
    WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);
    set @endTime = GETDATE();
    print 'Time taken to load bronze.crm_cust_info: ' + CAST(DATEDIFF(SECOND, @startTime, @endTime) AS NVARCHAR) + ' seconds';
    print '-------------------------------------------';
    
    set @startTime = GETDATE(); 
    print 'truncating table: bronze.crm_prd_info';
    TRUNCATE TABLE bronze.crm_prd_info;
    print 'inserting data into table: bronze.crm_prd_info';
    BULK INSERT bronze.crm_prd_info
    FROM '/var/opt/mssql/data/datasets/source_crm/prd_info.csv'
    WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);

    set @endTime = GETDATE();
    print 'Time taken to load bronze.crm_prd_info: ' + CAST(DATEDIFF(SECOND, @startTime, @endTime) AS NVARCHAR) + ' seconds';
    print '-------------------------------------------';

    set @startTime = GETDATE(); 
    print 'truncating table: bronze.crm_sales_details';
    TRUNCATE TABLE bronze.crm_sales_details;
    print 'inserting data into table: bronze.crm_sales_details';
    BULK INSERT bronze.crm_sales_details
    FROM '/var/opt/mssql/data/datasets/source_crm/sales_details.csv'
    WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);
    set @endTime = GETDATE();
    print 'Time taken to load bronze.crm_sales_details: ' + CAST(DATEDIFF(SECOND, @startTime, @endTime) AS NVARCHAR) + ' seconds';
    print '-------------------------------------------';

    -- ===== ERP =====
    print '-------------------------------------------';
    print 'Loading ERP data...';
    print '-------------------------------------------';

    set @startTime = GETDATE();
    print 'truncating table: bronze.erp_loc_a101';
    TRUNCATE TABLE bronze.erp_loc_a101;
    print 'inserting data into table: bronze.erp_loc_a101';
    BULK INSERT bronze.erp_loc_a101
    FROM '/var/opt/mssql/data/datasets/source_erp/LOC_A101.csv'
    WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);
    set @endTime = GETDATE();
    print 'Time taken to load bronze.erp_loc_a101: ' + CAST(DATEDIFF(SECOND, @startTime, @endTime) AS NVARCHAR) + ' seconds';
    print '-------------------------------------------';
    
    set @startTime = GETDATE();

    print 'truncating table: bronze.erp_cust_az12';
    TRUNCATE TABLE bronze.erp_cust_az12;
    print 'inserting data into table: bronze.erp_cust_az12';
    BULK INSERT bronze.erp_cust_az12
    FROM '/var/opt/mssql/data/datasets/source_erp/CUST_AZ12.csv'
    WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);
    set @endTime = GETDATE();
    print 'Time taken to load bronze.erp_cust_az12: ' + CAST(DATEDIFF(SECOND, @startTime, @endTime) AS NVARCHAR) + ' seconds';
    print '-------------------------------------------';
    set @startTime = GETDATE();
    print 'truncating table: bronze.erp_px_cat_g1v2';
    TRUNCATE TABLE bronze.erp_px_cat_g1v2;
    print 'inserting data into table: bronze.erp_px_cat_g1v2';
    BULK INSERT bronze.erp_px_cat_g1v2
    FROM '/var/opt/mssql/data/datasets/source_erp/PX_CAT_G1V2.csv'
    WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);
    set @endTime = GETDATE();
    print 'Time taken to load bronze.erp_px_cat_g1v2: ' + CAST(DATEDIFF(SECOND, @startTime, @endTime) AS NVARCHAR) + ' seconds';
    print '-------------------------------------------';
    print 'Finished loading Bronze layer.';
    END TRY
    BEGIN CATCH
        PRINT 'Error occurred while loading Bronze layer: ';
        PRINT  'ERROR_MESSAGE(): ' + ERROR_MESSAGE();
        PRINT  'ERROR_NUMBER(): ' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT  'ERROR_STATE(): ' + CAST(ERROR_STATE() AS NVARCHAR);
    END CATCH
END;
GO