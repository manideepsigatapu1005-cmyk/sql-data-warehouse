USE DataWarehouse;
GO


IF OBJECT_ID('bronze.crm_sales_details', 'U') IS NOT NULL
    DROP TABLE bronze.crm_sales_details;
GO


cREATE TABLE bronze.crm_sales_details (
    sls_ord_num         NVARCHAR(50),
    sls_prd_key         NVARCHAR(50),
    sls_cust_id         INT,
    sls_order_dt        INT,
    sls_ship_dt         INT,
    sls_due_dt          INT,
    sls_sales_          INT,
    sls_quantity        INT,
    sls_price           INT,
);