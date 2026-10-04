USE DataWarehouse;
GO  

IF OBJECT_ID('bronze.erp_cust_az12', 'U') IS NOT NULL
    DROP TABLE bronze.erp_cust_az12;
GO  

CREATE TABLE bronze.erp_cust_az12 (
    cid        NVARCHAR(50),
    bdate      DATE,
    gen        NVARCHAR(50),
    
);
GO