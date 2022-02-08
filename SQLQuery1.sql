
USE [Northwind]
GO

SELECT * FROM [Customers]
GO


print 'one'			-- INLINE COMMENT
PRINT 'two'
PRINT '----'
GO 5

-----------------------------------


CREATE DATABASE [MyDemoDb]
GO

USE [MyDemoDb]
GO

-----------------------------------

CREATE TABLE [Customer1]
(
	[Id] int NOT NULL
	, [Name] varchar(50) NOT NULL
	, [Address] varchar(200) NULL
);
GO

SELECT * FROM [MyDemoDb].[dbo].[Customer1]

SELECT * FROM [dbo].[Customer1]

SELECT * FROM [Customer1]

-----------------------------------

INSERT INTO [Customer1]
	( [Id], [Name], [Address] )
VALUES
	( 1, 'First Customer', 'address of the first customer' )
GO
INSERT INTO [Customer1]
	( [Id], [Name], [Address] )
VALUES
	( 1, 'Second Customer', 'address of the second customer' )      -- note duplicate ID
GO

SELECT * FROM [Customer1]

-----------------------------------

CREATE TABLE [Customers2]
(
    [Id] int NOT NULL UNIQUE
    , [Name] varchar(50) NOT NULL
    , [Address] varchar(200) NULL
);
GO

INSERT INTO [Customer2]
    ( [Id], [Name], [Address] )
VALUES
    ( 1, 'First Customer', 'address of the first customer' )
GO
INSERT INTO [Customer2]
    ( [Id], [Name], [Address] )
VALUES
    ( 1, 'Second Customer', 'address of the second customer' )      -- note duplicate ID
GO

SELECT * FROM [Customer2]

INSERT INTO [Customer2]
    ( [Id], [Name], [Address] )
VALUES
    ( 2, 'Second Customer', 'address of the first customer' )
    ( 3, 'Third Customer', 'address of the first customer' )
    ( 2, 'Fourth Customer', 'address of the first customer' )       -- note duplicate ID
    ( 5, 'Fifth Customer', 'address of the first customer' )
GO

SELECT * FROM [Customer2]

-----------------------------------

CREATE TABLE [Customers3]
(
	[Id] int NOT NULL
	, [Name] varchar(50) NOT NULL
	, [Address] varchar(200) NULL

	, CONSTRAINT [PK_Customer2] PRIMARY KEY ( [Id] ASC )
);
GO

-----------------------------------

INSERT INTO [Customers3]
	( [Id], [Name], [Address] )
VALUES
	( 3, 'Third Customer', 'address of the Third customer' )
	, ( 1, 'First Customer', 'address of the first customer' )
GO

SELECT * FROM [Customers3]
GO

INSERT INTO [Customers3]
	( [Id], [Name], [Address] )
VALUES
	( 3, 'Second Customer', 'address of the Second customer' ) -- try with duplicate id
GO
SELECT * FROM [Customers3]
GO

-----------------------------------

ALTER TABLE [Customers3]
	ADD [Country] varchar(100) NULL
		CONSTRAINT [CHK_Customer2_Country] CHECK ( [Country] IN ('India', 'USA') )
GO

-----------------------------------

INSERT INTO [Customers2]
	( [Id], [Name], [Address], [Country] )
VALUES
	( 4, 'Fourth Customer', 'address of the Fourth customer', 'India' )
GO

SELECT * FROM [Customers2]
GO

-----------------------------------

UPDATE [Customers2]
   SET [Country] = 'USA'
   WHERE [Id] = 3 OR [Id] = 1
UPDATE [Customers2]
   SET [Country] = 'USA'
   WHERE [Id] IN (1, 3)

SELECT * FROM [Customers2]
GO

-----------------------------------

DELETE FROM [Customers2]
	WHERE [Id] = 3
SELECT * FROM [Customers2]
GO

-----------------------------------

DECLARE @var1 int = 3
-- GO
DELETE FROM [Customers2]
	WHERE [Id] = @var1
GO

-- DECLARE @var2 int = @var1

-----------------------------------

DECLARE @author varchar(30) = 'Manoj Kumar Sharma'
DECLARE @company varchar(30)
SET @company = 'Microsoft'

PRINT @author
PRINT @company
PRINT @author + ', ' + @company
GO

-----------------------------------


SELECT * FROM [Customers2]
SELECT @@ROWCOUNT AS [NumberOfRecordsAffected]
GO

SELECT @@VERSION
GO

-----------------------------------


USE [Northwind]
SELECT [Country]
	FROM [Customers]
GO
SELECT DISTINCT [Country]
	FROM [Customers]
	ORDER BY [Country] DESC
GO

-----------------------------------

--- column alias
SELECT [CustomerID] AS [Id],
       [CompanyName] + ', ' + [Country] AS [Name]
FROM [Customers]


-----------------------------------

SELECT * FROM [Customers]
SELECT * FROM [Orders]
GO

SELECT [Orders].[OrderID]
	   , [Customers].[CustomerID]
	   , [Customers].[CompanyName]
	   , [Orders].[OrderDate]
FROM [Customers]
     , [Orders]
WHERE [Customers].[CustomerID] = [Orders].[CustomerID]

SELECT o.[OrderID]
	   , cust.[CustomerID]
	   , cust.[CompanyName] AS [Name]	-- Alias for a column
	   , o.[OrderDate]
FROM [Customers] AS cust				-- Alias for a table
     , [Orders] AS o
WHERE cust.[CustomerID] = o.[CustomerID]

-----------------------------------

