 USE [MyDemoDb]
 GO

/*
 *  Working with MASTER and TRANSACTION TABLE
 *  (a) Naming Convention for table, column, CHK, DF, PK and FK
 *  (b) Using IDENTITY column
 *  (c) Using PRIMARY KEY and FOREIGN KEY
 *  (d) Using CONSTRAINTS - DEFAULT VALUES
 *  (e) Using CONSTRAINTS - CHECK constraints for Validation
 *  (f) Using CHECK CONSTRAINTS for Enumerations
 *  (g) Altering the Table Schema
 ******************************************************/

 CREATE TABLE [Countries]		-- pluralized NAME
 (
	[Code] varchar(3) NOT NULL 
	, [Name] varchar(50) NOT NULL

	, CONSTRAINT [PK_Countries] PRIMARY KEY ( [Code] ASC )
 )
 GO
 
 CREATE TABLE [Persons]			-- pluralized NAME
 (
    [PersonId] smallint NOT NULL IDENTITY(1,1)
    , [Name] varchar(50) NOT NULL
    , [Age] int NULL 
	, [CountryCode] varchar(3) NOT NULL		-- Recommendation: name should match with the FK Table's PK
	, [CreatedOn] datetime NOT NULL
	, [IsActive] bit NOT NULL 
		CONSTRAINT [DF_Persons_IsActive] DEFAULT (1) 
	, [IsEnabled] bit NOT NULL 
		CONSTRAINT [DF_Persons_IsEnabled] DEFAULT (1)
	, [Gender] varchar(9) NOT NULL

	, CONSTRAINT [PK_Persons] PRIMARY KEY CLUSTERED ( [PersonId] ASC )
	, CONSTRAINT [FK_Persons_Countries] FOREIGN KEY ([CountryCode]) REFERENCES [Countries] ([Code])
	, CONSTRAINT [CHK_Age] CHECK ( [Age] >= 18 AND [Age] <= 65 )
	, CONSTRAINT [CHK_Gender] CHECK ( [Gender] IN ('Male', 'Female', 'Unknown') )
 )
 GO

 ALTER TABLE [Persons]
	-- ADD CONSTRAINT [DF_CreatedOn] DEFAULT ( getdate() ) FOR [CreatedOn]
	ADD CONSTRAINT [DF_CreatedOn] DEFAULT ( sysdatetimeoffset() ) FOR [CreatedOn]
 GO

 INSERT INTO [Countries] 
	( [Code], [Name] )
 VALUES
	( 'IN', 'India' )
	, ( 'USA', 'United States of America' )
 GO

 INSERT INTO [Persons]
	( [Name], [Age], [CountryCode], [Gender] )
 VALUES
	('First Person', 22, 'IN', 'Male')
 GO

 INSERT INTO [Persons]
	( [Name], [Age], [CountryCode], [Gender] )
 VALUES
	('Second Person', 34, 'IN', 'Invalid')
 GO


 --- Cleanup (NOTE: The Type of Object)
 IF OBJECT_ID('Persons', 'U') IS NOT NULL
	DROP TABLE [Persons]
 GO
 IF OBJECT_ID('Countries', 'U') IS NOT NULL
	DROP TABLE [Countries]
 GO
