 USE [MyDemoDb]
 GO

 CREATE TABLE [Persons] (
    [ID] smallint NOT NULL IDENTITY(1,1)
    , [Name] nvarchar(50) NOT NULL
	, [Age] int NULL
	, [Country] varchar(50) NOT NULL

	, CONSTRAINT [PK_Persons] PRIMARY KEY ( [ID] ASC )
 )
 GO

/*
 *  INSERT Statement
 ******************************************************/
 
 INSERT INTO [Persons]
	( [Name], [Age], [Country] )
 VALUES
	( N'First Person', 28, 'India' )
	, ( N'Second Person', 35, 'UK' )
	, ( N'Third Person', 38, 'UK' )
	, ( N'Fourth Person', 47, 'USA' )
	, ( N'Fifth Person', 29, 'India' );
 SELECT * FROM [Persons]
 GO

/*
 *  UPDATE Statement
 ******************************************************/

 UPDATE [Persons] 
	SET [Country] = 'United States of America'
	WHERE [Country] = 'USA'
 SELECT * FROM [Persons]
 GO

 UPDATE [Persons] 
	SET [Country] = 'United Kingdom'
	WHERE [ID] IN (2, 4)
 SELECT * FROM [Persons]
 GO

  UPDATE [Persons] 
	SET [Country] = 'United Kingdom'
	WHERE [ID] IN (select [id] from [persons] where [Country] = 'UK')
 SELECT * FROM [Persons]
 GO


 /*
 *  DELETE Statement
 ******************************************************/

 DELETE [Persons] 
	WHERE [ID] = 3
 SELECT * FROM [Persons]
 GO

 DELETE [Persons] 
 SELECT * FROM [Persons]
 GO


 /*
 *  Impact of DELETE Statement on the IDENTITY COLUMN
 ******************************************************/

 INSERT INTO [Persons]
	( [Name], [Age], [Country] )
 VALUES
	( N'New Person', 28, 'India' )
 GO

 SELECT * FROM [Persons]
 GO

/*
 *  TRUNCATE STATEMENT
 ******************************************************/

 TRUNCATE TABLE [Persons]
 GO
 SELECT * FROM [Persons]
 GO

 INSERT INTO [Persons]
	( [Name], [Age], [Country] )
 VALUES
	( N'New Person', 28, 'India' )
 GO

 SELECT * FROM [Persons]
 GO


 
 /*
 *  Different ways to drop user created objects
 ******************************************************/
 select * from sys.objects

 --- Example #1: using sys.objects
 IF EXISTS (SELECT [NAME] FROM sys.objects WHERE [NAME] = 'Persons' AND [type] = 'U')
	 DROP TABLE [MyDemoDb].[dbo].[Persons]
 GO


 --- Example #2: USING sys.tables
 IF EXISTS (SELECT [NAME] FROM sys.tables WHERE NAME = 'Persons')
	 DROP TABLE [Persons]
 GO
 
 --- Example #3: Using INFORMATION_SCHEMA.TABLES 
 IF (EXISTS (SELECT * 
				 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_CATALOG = 'MyDemoDb'
		          AND TABLE_SCHEMA = 'dbo' 
                  AND TABLE_NAME = 'Persons'))
 BEGIN
    DROP TABLE [dbo].[Persons]
 END
 GO

 --- Example #4: (recommended approach, as it works with any user-object)
 IF OBJECT_ID('dbo.Persons', 'U') IS NOT NULL
	DROP TABLE [Persons]
 GO
