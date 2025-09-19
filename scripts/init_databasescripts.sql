/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a new database named 'DataWarehouse' after checking if it already exists. 
    If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas 
    within the database: 'bronze', 'silver', and 'gold'.
	
WARNING:
    Running this script will drop the entire 'DataWarehouse' database if it exists. 
    All data in the database will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.
*/

USE MASTER
go


-- DROP AND CREATE A DATABASE 'Datawarehouse'

IF EXISTS  (SELECT  1 from sys.databases where name = 'SALESDWH' )
BEGIN
		ALTER DATABASE SALESDWH SET SINGLE_USER WITH ROLLBACK IMMEDIATELY;
		DROP DATABASE SALESDWH;
END 
GO

CREATE DATABASE SALESDWH;
GO



USE SALESDWH;
GO


--- BRONZE

IF EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'BRONZE')
BEGIN
    DROP SCHEMA BRONZE;
END
GO

CREATE SCHEMA Bronze;
GO
---- SILVER

IF EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'Silver')
BEGIN
    DROP SCHEMA Silver;
END
GO

CREATE SCHEMA Silver;
GO
--- GOLD

IF EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'Gold')
BEGIN
    DROP SCHEMA Gold;
END
GO

Create SCHEMA Gold;
GO
CREATE SCHEMA Silver;
