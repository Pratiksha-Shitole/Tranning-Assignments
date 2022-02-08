USE [MyDemoDb]
GO



CREATE TABLE [Employees]
(
	[Id] int NOT NULL IDENTITY(101, 1)
	, [Name] varchar(50)
)
GO

INSERT INTO [Employees]
	( [Name] )
VALUES
	( 'First Employee' )
	, ( 'Second Employee' )
	, ( 'Third Employee' )
	, ( 'Fourth Employee' )
	, ( 'Fifth Employee' )
GO

SELECT * FROM [Employees]
GO

DELETE FROM [Employees] WHERE ID IN (102, 104)
GO

SELECT * FROM [Employees]
GO



INSERT INTO [Employees]
	( [Id], [Name] )
VALUES
	( 102, 'New Second Employee' )
GO

SELECT * FROM [Employees]
GO




SET IDENTITY_INSERT [Employees] ON;
INSERT INTO [Employees] ( [Id], [Name] ) VALUES 
	( 102, 'New Second Employee' )
SET IDENTITY_INSERT [Employees] OFF
GO

SELECT * FROM [Employees]
GO


	
DROP TABLE [Employees]
GO
