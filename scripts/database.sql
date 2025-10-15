/*
========================================================================
-- Create Database Warehouse 
========================================================================

Script Purpose:

	This script creates a new database named Datawarehouse after cheking if it already exists.
	If thr database exists, it is dropped and recreated. Additionally the script sets up three schemas within the database: bronze, silver and gold:

	Warning: 
	Running this script will drop the entire Datawarehouse database if it exist
	All data in the database will be permanently deleted. Proceed with caution andensure you have proper backups before running this script. 
*/

USE master;
GO

  -- Drop and recreate the warehouse
  If EXISTS (SELECT 1 from sys.databases WHERE name = 'DataWarehouse')
  BEGIN 
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP DATABASE DataWarehouse;
END;
GO 

  
--Create the DataWarehouse database
CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

  -- Create the Schemas
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO
