/*
 * Demo of how to use TRANSACTION 
 ******************/


USE [MyDemoDb]
GO

CREATE TABLE [Employees]
(
	[Id] int NOT NULL UNIQUE
	, [Name] varchar(20) NOT NULL
)
GO

INSERT INTO [Employees]
	( [Id], [Name] )
VALUES
	( 1, 'First Employee' )
	, ( 2, 'Second Employee' )
	, ( 3, 'Third Employee' )
GO

---- Inserting an Employee with the same name!
INSERT INTO [Employees]
	( [Id], [Name] )
VALUES
	( 4, 'Second Employee' )
GO

SELECT * FROM [Employees]
GO


---- let us first delete the existing invalid row
DELETE [Employees]
	WHERE [Id] = 4
GO

SELECT * FROM [Employees]
GO

--- SOLUTION:

BEGIN TRANSACTION [AddEmployee]

INSERT INTO [Employees]
	( [Id], [Name] )
VALUES
	( 5, 'Fourth Employee' )
GO

SELECT * FROM [Employees]

DECLARE @found int
SELECT @found = COUNT(*) FROM [Employees] WHERE [Name] = 'Fourth Employee'

IF( @found > 1 )
	BEGIN
		ROLLBACK TRANSACTION [AddEmployee]
		PRINT 'Another Employee found with the same Name, so rolling back!'
	END
ELSE
	BEGIN
		COMMIT TRANSACTION
		Print 'Successfully added the new Employee'
	END

GO



SELECT * FROM [Employees]
GO

DROP TABLE [Employees]
GO
