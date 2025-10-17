
/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from CSV files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/

create or alter procedure bronze.load_bronze AS
Begin

	BEGIN TRY
PRINT '================================================';
		PRINT 'Loading Bronze Layer';
		PRINT '================================================';

		PRINT '------------------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '------------------------------------------------';

truncate table bronze.cm_cust_info;

bulk insert bronze.cm_cust_info
from 'C:\Users\anish\OneDrive\Desktop\sqldatawarehouse\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'

with (
firstrow = 2,
fieldterminator = ',',
tablock
);

truncate table bronze.crm_prd_info

bulk insert bronze.crm_prd_info
from 'C:\Users\anish\OneDrive\Desktop\sqldatawarehouse\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
with (
firstrow = 2,
fieldterminator = ',',
tablock
);
truncate table bronze.crm_sales_details;
bulk insert bronze.crm_sales_details
from 'C:\Users\anish\OneDrive\Desktop\sqldatawarehouse\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
with (
firstrow = 2,
fieldterminator = ',',
tablock
);
PRINT '------------------------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '------------------------------------------------';
truncate table bronze.erp_cust_az12;
bulk insert bronze.erp_cust_az12
from 'C:\Users\anish\OneDrive\Desktop\sqldatawarehouse\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
with (
firstrow = 2,
fieldterminator = ',',
tablock
);
truncate table bronze.erp_loc_a101;
bulk insert bronze.erp_loc_a101
from 'C:\Users\anish\OneDrive\Desktop\sqldatawarehouse\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
with (
firstrow = 2,
fieldterminator = ',',
tablock
);
truncate table bronze.erp_px_cat_g1v2;
bulk insert bronze.erp_px_cat_g1v2
from 'C:\Users\anish\OneDrive\Desktop\sqldatawarehouse\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
with (
firstrow = 2,
fieldterminator = ',',
tablock
);
end try
BEGIN CATCH
		PRINT '=========================================='
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '=========================================='
	END CATCH

end
