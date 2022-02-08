USE [MyDemoDb]
GO

/*
 *	Preparation for the demos!
 ******************************************************/

 CREATE TABLE [Numbers] (
	[NumberID] smallint NOT NULL PRIMARY KEY
	, [Number] varchar(30) NOT NULL
 )
 GO

 INSERT INTO [Numbers]
	([NumberID], [Number])
 VALUES
	( 1, 'One' )
	, ( 2, 'Two' )
	, ( 3, 'Three' )
 GO

 CREATE TABLE [Positions] (
	[PositionNo] int NOT NULL
	, [Position] varchar(30) NOT NULL
 )
 GO

 INSERT INTO [Positions]
	( [PositionNo], [Position] )
 VALUES
	( 1, 'First' )
	, ( 3, 'Third' )
	, ( 4, 'Fourth' )
 GO

 SELECT * FROM [Numbers]
 SELECT * FROM [Positions]
 GO



 /*
 *  Understanding INNER JOIN
 ******************************************************/

 SELECT * FROM [Numbers]
 SELECT * FROM [Positions]
 GO

 --- The ANSI SQL-89 syntax for INNER JOIN
 SELECT *
	FROM [Numbers] AS n,
	     [Positions] AS p
	WHERE n.NumberID = p.PositionNo
 GO

 --- same as above - the recommended model
 --- NOTE: inner join is logically a Cartesian product followed by the application of a filter.
 SELECT *
	FROM [Numbers] AS n
	INNER JOIN [Positions] AS p ON n.NumberID = p.PositionNo
 GO

 --- same as above - alternate to the recommended model
 SELECT *
	FROM [Numbers] AS n
	JOIN [Positions] AS p ON n.NumberID = p.PositionNo
 GO



/*
 *  Understanding CROSS JOIN
 ******************************************************/
 SELECT * FROM [Numbers]
 SELECT * FROM [Positions]
 GO

 --- The Cartesian Join
 SELECT *
	FROM [Numbers] AS n
	CROSS JOIN [Positions] AS p
 GO

 --- The problem in the ANSI SQL-89 syntax
 --- If you forget the WHERE clause, the result is a Cartesian Join
 SELECT *
	FROM [Numbers] AS n, [Positions] AS p
 GO



 /*
 *  Understanding OUTER JOINs
 ******************************************************/
 SELECT * FROM [Numbers]
 SELECT * FROM [Positions]
 GO

 SELECT *
	FROM [Numbers] AS n
	LEFT JOIN [Positions] AS p ON n.NumberID = p.PositionNo
 GO

 SELECT *
	FROM [Numbers] AS n
	RIGHT JOIN [Positions] AS p ON n.NumberID = p.PositionNo
 GO

 SELECT *
	FROM [Numbers] AS n
	FULL OUTER JOIN [Positions] AS p ON n.NumberID = p.PositionNo
 GO



 SELECT *
	FROM [Numbers] AS n
	LEFT JOIN [Positions] AS p ON n.NumberID = p.PositionNo
 WHERE p.PositionNo IS NULL
 GO



 /*
 *  Understanding SELF JOIN
 ******************************************************/

 CREATE TABLE [Employees] (
	[ID] int NOT NULL PRIMARY KEY
	, [EmployeeName] varchar(50) NOT NULL
	, [Designation] varchar(30) NOT NULL
	, [ManagerID] int NULL
 )
 GO

 INSERT INTO [Employees]
	( [ID], [EmployeeName], [Designation], [ManagerID] )
 VALUES
	( 1, 'First Employee', 'CEO', NULL )
	, ( 2, 'Second Employee', 'Sales Manager', 1 )
	, ( 3, 'Third Employee', 'Salesman', 2 )
	, ( 4, 'Fourth Employee', 'Salesman', 2 )
	, ( 5, 'Fifth Employee', 'Accounts Manager', 1 )
	, ( 6, 'Sixth Employee', 'Accountant', 5 )
 GO

 SELECT * FROM [Employees]
 GO

 SELECT a.[ID]
        , a.[EmployeeName]
		, a.[Designation]
        , a.[ManagerID]
		, b.[ID] AS [IdOfSubordinate]
        , b.[EmployeeName] AS [NameOfSubordinate]
		, b.[Designation] AS [DesignationOfSubordinate]
 FROM [Employees] AS a
	  LEFT JOIN [Employees] AS b ON a.[ID] = b.[ManagerID]
 GO

 SELECT a.ID AS [ManagerId],
        a.EmployeeName AS [ManagerName],
		a.Designation AS [ManagerDesignation],
		a.ManagerID AS [ReportingManagerID],
		b.ID AS [EmployeeID],
        b.EmployeeName AS [EmployeeName],
		b.Designation AS [EmployeeDesignation]
 FROM [Employees] AS a
	  RIGHT JOIN [Employees] AS b ON a.ID = b.ManagerID
 GO

 SELECT a.ID, a.EmployeeName, a.Designation, a.ManagerID,
        b.ID, b.EmployeeName, b.Designation
 FROM [Employees] AS a, [Employees] as b
 WHERE a.ID = b.ManagerID
 GO



 /*
 *	Cleanup
 ******************************************************/

 IF OBJECT_ID('dbo.Numbers') IS NOT NULL DROP TABLE [Numbers]
 IF OBJECT_ID('dbo.Positions') IS NOT NULL DROP TABLE [Positions]
 IF OBJECT_ID('dbo.Employees') IS NOT NULL  DROP TABLE [Employees]
 GO