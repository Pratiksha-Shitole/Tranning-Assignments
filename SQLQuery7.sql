 USE [MyDemoDb]
 GO

 SELECT * FROM sys.tables

 /*
 *  SELECT ... INTO
 *  NOTE: Table should not exist
 ******************************************************/

 SELECT [CustomerID], [CompanyName], [City], [Country]
	INTO [CustomersSubset]
	FROM [Northwind].[dbo].[Customers]
	WHERE [Country] = 'France';
 GO

 SELECT * FROM [CustomersSubset]
 GO

 /*
 *  INSERT INTO ... SELECT
 *  NOTE: Table should exist
 ******************************************************/

 INSERT INTO [CustomersSubset]
	SELECT [CustomerID], [CompanyName], [City], [Country]
	FROM [Northwind].[dbo].[Customers]
	WHERE [Country] = 'Germany'
 GO

 SELECT * 
	FROM [CustomersSubset] 
	ORDER BY [Country]
 GO


/*
 *  Creating a VIEW
 *  Displaying the data using the View
 *  Understanding how to use the ORDER BY clause with a View
 ******************************************************/

 CREATE VIEW [dbo].[VW_Customers]
 AS
	SELECT [CustomerID], [CompanyName], [City], [Country]
		FROM [CustomersSubset]
		-- ORDER BY [CompanyName]			-- NOTE: ORDER BY not supported!
 GO

 SELECT * FROM [VW_Customers]
 SELECT * FROM [VW_Customers] ORDER BY [CompanyName]
 SELECT * FROM [VW_Customers] WHERE [Country] = 'France'
 GO


/*
 *  Demo of User Defined Scalar Function
 *  Check out Programmability -> Scalar-valued Functions
 *********************************/
 
 CREATE FUNCTION [dbo].[funcScalar] (
	@quantity int,
	@price money = 1		-- setting a default value.
 )
 RETURNS money				-- Returns a Scalar Value
 AS
	 BEGIN
		RETURN @quantity * @price
	 END
 GO

 --- Run #1:
 SELECT [dbo].[funcScalar] ( 5, $100.25 )
 GO

 --- Run #2: uses the default value set to @price
 SELECT [dbo].[funcScalar] ( 5, DEFAULT )
 GO


/*
 *  Demo of TVF (Table-Valued Function)
 *  Check out -> Programmability -> Table-valued Functions
 *********************************/

 CREATE FUNCTION [dbo].[func_GetCustomers] (
	@Country nvarchar(15)
 )
 RETURNS TABLE					-- Returns Table View
 AS
	RETURN (
		SELECT *
			FROM [CustomersSubset]
			WHERE [Country] = @Country
			-- ORDER BY [CompanyName]		-- NOTE: Order by not supported!
	);
 GO

 SELECT *
	FROM [dbo].[func_GetCustomers] ('France')
 SELECT *
	FROM [dbo].[func_GetCustomers] ('France')
	ORDER BY [CustomerID]
 GO

 

/*
 *  Creating a Stored Procedure
 ******************************************************/

 --- Example #1: A normal SP with INPUT paramater
 CREATE PROCEDURE [dbo].[sp_GetCustomerSubset] (
	@country nvarchar(15)
 )
 AS
	SELECT * 
	FROM [CustomersSubset] 
	WHERE [Country] = @country
 GO

 --- To execute the stored procedure
 --- NOTE: in the message tab, you should see rows affected.
 EXEC [sp_GetCustomerSubset] 'France'
 SELECT @@ROWCOUNT
 GO
 

 --- Example #2: With NOCOUNT ON
 CREATE PROCEDURE [dbo].[sp_GetCustomerSubsetNoCount] (
	@country nvarchar(15)
 )
 AS
	--- Deactivate the "Number of Rows Affected" counter
	SET NOCOUNT ON

	SELECT *
	FROM [CustomersSubset] 
	WHERE [Country] = @country

	--- Reactivate the "Number of Rows Affected" counter
	--- before exiting to reset the environment status quo
	SET NOCOUNT OFF
 GO

 --- To execute the stored procedure
 --- NOTE: in the message tab, you should NOT see rows affected.
 EXEC [sp_GetCustomerSubsetNoCount] 'France'
 SELECT @@ROWCOUNT
 GO




 --- Cleanup (NOTE: The Type of Object)
 IF OBJECT_ID('sp_GetCustomerSubset', 'P') IS NOT NULL
	DROP PROCEDURE [dbo].[sp_GetCustomerSubset]
 GO
 IF OBJECT_ID('sp_GetCustomerSubsetNoCount', 'P') IS NOT NULL
	DROP PROCEDURE [dbo].[sp_GetCustomerSubsetNoCount]
 GO
 IF OBJECT_ID('funcScalar', 'FN') IS NOT NULL
	DROP FUNCTION [dbo].[funcScalar]
 GO
 IF OBJECT_ID('func_GetCustomers', 'IF') IS NOT NULL
	DROP FUNCTION [dbo].[func_GetCustomers]
 GO
 IF OBJECT_ID('VW_Customers', 'V') IS NOT NULL
	DROP VIEW [VW_Customers]
 GO
 IF OBJECT_ID('CustomersSubset', 'U') IS NOT NULL
	DROP TABLE [CustomersSubset]
 GO
