USE [MyDemo]
GO



 IF (EXISTS (SELECT *
				 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_CATALOG = 'MyDemoDb'
		          AND TABLE_SCHEMA = 'dbo'
                  AND TABLE_NAME = 'Customers'))
 BEGIN
    DROP TABLE [dbo].[Customers]
 END
 GO

 




 -- IF OBJECT_ID('MyDemoDb.dbo.Customers2', 'U') IS NOT NULL
 IF OBJECT_ID('Customer2', 'U') IS NOT NULL
 BEGIN
	DROP TABLE [dbo].[Customers2]
 END
 GO


 /*
 *   List all tables in the database
 ******************************************************/

 SELECT * FROM sys.tables

 SELECT * FROM sys.objects


 
 /*
 *  Working with the WHERE Clause
 ******************************************************/

 USE [Northwind]
 GO

 --- Example #1:
 SELECT *
 FROM [Customers]
 WHERE COUNTRY = 'France'

 --- Example #2: using the AND clause
 SELECT [CustomerID], [CompanyName], [Country]
	FROM [Customers]
	WHERE [Country] = 'Germany' AND [Country] = 'UK'
 GO

 --- Example #3: using the OR clause
 SELECT [CustomerID], [CompanyName], [Country]
	FROM [Customers]
	WHERE [Country] = 'Germany' OR [Country] = 'UK'
 GO

 --- Example #4: using the IN clause
 SELECT [CustomerID], [CompanyName], [Country]
	FROM [Customers]
	WHERE [Country] IN ('Germany', 'UK')
 GO

 -- Example #5: using the EXISTS clause and a SUB-QUERY
 SELECT [CustomerID], [CompanyName], [Country]
	FROM [Customers]
	WHERE NOT EXISTS
		( SELECT * FROM [Orders] WHERE Customers.CustomerID = Orders.CustomerID )
 GO

 -- Example #6: working with Dates
 SELECT *
	FROM [Orders]
	WHERE [OrderDate] < '1996-08-05' AND [OrderDate] > '1996-08-10'
	ORDER BY [OrderDate]
 SELECT [OrderID], [OrderDate], [CustomerID]
	FROM [Orders]
	WHERE ([OrderDate] BETWEEN '1996-08-05' AND '1996-08-10')
	ORDER BY [OrderDate]
 SELECT [OrderID], [OrderDate], [CustomerID]
	FROM [Orders]
	WHERE [OrderDate] BETWEEN '19960805' AND '19960810'
	ORDER BY [OrderDate]
 GO


 /*
 *  Understanding the ALL and DISTINCT Clause
 ******************************************************/
 SELECT [SupplierID], [CompanyName], [City], [Region], [Country] FROM [Suppliers]
 GO

 SELECT COUNT( [Region] )
	 FROM [Suppliers]
 SELECT COUNT( ALL [Region] )
	 FROM [Suppliers]
 SELECT COUNT( DISTINCT [Region] )
	 FROM [Suppliers]
 GO



/*
 *  Working with OFFSET and FETCH
 ******************************************************/

 SELECT [CustomerID], [CompanyName], [City], [Country]
	FROM [Customers]
	ORDER BY [Country], [City]

 --- Example #1: Skipping the first 3 rows
 SELECT [CustomerID], [CompanyName], [City], [Country]
	FROM [Customers]
	ORDER BY [Country], [City]
		OFFSET 3 ROWS
 GO

 --- Example #2: Skipping the first 3 rows, and fetching the next 5 rows
 SELECT [CustomerID], [CompanyName], [City], [Country]
	FROM [Customers]
	ORDER BY [Country], [City]
		OFFSET 3 ROWS
		FETCH NEXT 5 ROWS ONLY
 GO

 --- Example #3: Another way of skipping the first 3 rows, and fetching the next 5 rows
 SELECT [CustomerID], [CompanyName], [City], [Country]
	FROM [Customers]
	ORDER BY [Country], [City]
		OFFSET 3 ROWS
		FETCH FIRST 5 ROWS ONLY
 GO


/*
 *  Understanding TOP clause
 ******************************************************/

 SELECT [ProductID], SUM([Quantity]) AS TotalQuantity
	 FROM [Order Details]
	 GROUP BY [ProductID]
	 ORDER BY [TotalQuantity] DESC
 GO

 --- Example #1: get the top 10 rows
 SELECT TOP 10
	 [ProductID], SUM([Quantity]) AS TotalQuantity
	 FROM [Order Details]
	 GROUP BY [ProductID]
	 ORDER BY [TotalQuantity] DESC
 GO

 --- Example #2: get the top 10 percent rows
 SELECT TOP 10 PERCENT
	 [ProductID], SUM([Quantity]) AS TotalQuantity
	 FROM [Order Details]
	 GROUP BY [ProductID]
	 ORDER BY [TotalQuantity] DESC
 GO
 

 
/*
 *  Example of understanding the importance of TOP WITH TIES used with ORDER BY
 *  Ensures that all the items that satisfy the ORDER BY values are retrieved for the last match that qualifies
 ******************************************************/

 USE [MyDemoDb]
 GO

 IF OBJECT_ID('Products') IS NOT NULL
	DROP TABLE [dbo].[Products]
 GO

 CREATE TABLE [Products] (
	[ProductName] varchar(50),
	[ListPrice] money
 );
 GO

 INSERT INTO [Products]
	(ProductName, ListPrice)
 VALUES
	('Juice - V8 Splash', $36.46)
	, ('Wine - Soave Folonari', $6.51)
	, ('Thyme - Fresh', 48.97)
	, ('Blueberries - Frozen', $40.57)
	, ('Lamb - Shoulder, Boneless', $39.23)
	, ('Nut - Macadamia', $19.45)
	, ('Sauce - Plum', $48.97)
	, ('Water - Mineral, Natural', $40.57)
	, ('Syrup - Golden, Lyles', $38.02)
	, ('Grenadillo', $34.75);
 GO

 SELECT * 
	FROM [Products]
 SELECT * 
	FROM [Products] 
	ORDER BY [ListPrice] DESC
 SELECT TOP 3 * 
	FROM [Products] 
	ORDER BY [ListPrice] DESC
 SELECT TOP 3 WITH TIES * 
	FROM [Products] 
	ORDER BY [ListPrice] DESC
 --- NOTE: 40.57 is the last qualifier.
 ----      So, all records matching this value would be retrieved for the WITH TIES result!
 ----      because both the records share the same rank!
 GO

 DROP TABLE [Products]
 GO


/*
 *  Handling NULLs in queries
 ******************************************************/

 USE [Northwind]
 GO

 --- Sample data showing the values.  ORDER BY added to show clarity.
 SELECT [SupplierID], [CompanyName], [Region]
	FROM [Suppliers]
	ORDER BY [Region] ASC
 GO

 --- Incorrectly testing for NULLs
 SELECT [SupplierID], [CompanyName], [Region]
	FROM [Suppliers]
	WHERE [Region] = NULL			-- [Region] <> NULL
 GO

 --- Correctly testing for NULL
 SELECT [SupplierID], [CompanyName], [Region]
	FROM [Suppliers]
	WHERE [Region] IS NULL
 GO
 SELECT [SupplierID], [CompanyName], [Region]
	FROM [Suppliers]
	WHERE [Region] IS NOT NULL
 GO




 /*
 *  The CREATE TABLE statement revisited
 *  (a) Identity Column
 *  (b) Constraint - Primary Key
 *  (c) Constraint - Check Constraint
 *  (d) Constraint - Default Constraint
 ******************************************************/

 USE [MyDemo]
 GO

 CREATE TABLE [Persons] (
    [ID] smallint NOT NULL IDENTITY(1,1)
    , [Name] nvarchar(50) NOT NULL
    , [Age] int NULL
	, [Country] varchar(50) NOT NULL
			CONSTRAINT [DF_Persons_Country] DEFAULT 'India'
	, [City] varchar(50) NOT NULL
			CONSTRAINT [DF_Persons_City] DEFAULT 'Mumbai'

	, CONSTRAINT [PK_Persons] PRIMARY KEY ( [ID] ASC )
	, CONSTRAINT [CHK_Persons_Country] 
			CHECK ( [Country] IN ('India', 'USA', 'UK') )
	, CONSTRAINT [CHK_Persons_Age] 
			CHECK ( [Age] >= 18 )
	, CONSTRAINT [CHK_Persons_AgeLimit]
			CHECK (  [Age] >= 18 AND [Age] <= 60  AND [Country] = 'India' )
 )
 GO

 INSERT INTO [Persons]
	( [Name], [Age], [Country] )
 VALUES
	( N'First Person', 28, 'India' )
	, ( N'Second Person', 35, 'UK' )
 GO


 /*
 *  Working with Conditional Statements: 
 *  IF...ELSE block
 ******************************************************/

 USE [Northwind]
 GO


 --- Example: combining the EXISTS clause with an IF...ELSE statement block
 IF EXISTS (SELECT *
            FROM [Customers]
	        WHERE [COUNTRY] = 'India')
	 BEGIN
		PRINT 'Found'
	 END
 ELSE
	BEGIN
		PRINT 'Not found'
	END



 /*
 *  Working with Conditional Statements: 
 *  CASE statement (for conditional blocks)
 ******************************************************/

 ---- Example #1
 DECLARE @counter int = 3
 SELECT @counter
		, (CASE
				WHEN @counter = 1 THEN 'One'
				WHEN @counter = 2 THEN 'Two'
				WHEN @counter = 3 THEN 'Three'
		END) AS [In words]
 GO

 ---- Example #2
  SELECT [CustomerID], [CompanyName], [City], [Country]
	FROM [Customers]
	WHERE [Country] IN ('Brazil', 'France')
	ORDER BY
		[Country]
		, (CASE
			WHEN [Country] = 'Brazil' THEN [CustomerID]
			WHEN [Country] = 'France' THEN [City]
		END)
 GO


/*
 *  Working with Iterations
 ******************************************************/

 --- Example #1: Repeat previous statment "n" times using the GO statement
 DECLARE @var varchar(50) = 'hello world'
 PRINT @var
 GO 5

 -- Example #2: Using the WHILE loop
 DECLARE @counter int = 1
 WHILE @counter <= 5
 BEGIN
    PRINT @counter
    SET @counter = @counter + 1
 END
 GO

 DECLARE @counter int = 1
 PRINT @counter
 SET @counter = @counter + 1
 GO 5

