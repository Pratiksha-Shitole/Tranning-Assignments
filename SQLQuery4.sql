USE [Northwind]
GO

 /*
 *  ORDER BY clause
 ******************************************************/
 
 --- Example #1: Using the Ordinal Clause
 SELECT [CustomerID], [CompanyName], [City], [Country]
	FROM [Customers]
	ORDER BY 4, 3
 GO

 --- Example #2: The recommended approach
 SELECT [CustomerID], [CompanyName], [City], [Country]
	FROM [Customers]
	ORDER BY [Country], [City]
 GO

 --- Example #3: Defining the sort order
 SELECT [CustomerID], [CompanyName], [City], [Country]
	FROM [Customers]
	ORDER BY [Country] DESC, [City] ASC
 GO

 --- Example #4: Sorting on a column not displayed
 SELECT [CustomerID], [CompanyName], [City], [Country]
	FROM [Customers]
	ORDER BY [Country], [City], [PostalCode] DESC
 
 --- Example #5: Sorting on the alias of a column
 SELECT [CustomerID], [CompanyName] AS cn, [City], [Country]
	FROM [Customers]
	ORDER BY cn

 --- Example #6: Sorting on a computed column
 SELECT [CustomerID], [CompanyName], [ADDRESS] = ( [Country] + ', ' + [City] )
	FROM [Customers]
	ORDER BY [ADDRESS]
 GO




/*
 *  GROUP BY clause (to compute aggregates like COUNT, MAX, MIN, SUM, AVG, etc)
 ******************************************************/

 ---- Example #1
 SELECT COUNT([CustomerID]) AS [Number of Customers], [Country]
	FROM [Customers]
	GROUP BY [Country]
 GO

 ---- Example #2
 SELECT COUNT([CustomerID]) AS [NumberOfCustomers], [Country]
	FROM [Customers]
	GROUP BY [Country]
	ORDER BY COUNT([CustomerID]) DESC
 SELECT COUNT([CustomerID]) AS [NumberOfCustomers], [Country]
	FROM [Customers]
	GROUP BY [Country]
	ORDER BY [NumberOfCustomers] DESC
 GO

 ---- Example #3
 SELECT [Customers].[CompanyName]
		, COUNT([Orders].[OrderID]) AS [NumberOfOrders]
    FROM [Orders]
		 LEFT JOIN [Customers] ON [Orders].[CustomerID] = [Customers].[CustomerID]
	GROUP BY [Customers].[CompanyName]
 GO

 ---- Example #4
 SELECT [Customers].[CustomerID]
        , [Customers].[CompanyName]
		, COUNT([Orders].[OrderID]) AS [NumberOfOrders]
    FROM [Orders]
		 LEFT JOIN [Customers] ON [Orders].[CustomerID] = [Customers].[CustomerID]
	GROUP BY
		[Customers].[CustomerID]
		, [Customers].[CompanyName]
 GO



 /*
 *  HAVING clause (needs GROUP BY)
 ******************************************************/

 ---- Example #1
 SELECT [Customers].[CustomerID]
        , [Customers].[CompanyName]
		, COUNT([Orders].[OrderID]) AS [NumberOfOrders]
    FROM [Orders]
		 LEFT JOIN [Customers] ON [Orders].[CustomerID] = [Customers].[CustomerID]
	-- WHERE [Customers].[Country] = 'France' OR [Customers].[Country] = 'UK'
	GROUP BY [Customers].[CustomerID], [Customers].[CompanyName]
		HAVING COUNT([Orders].[OrderID]) > 15		-- like a WHERE Clause ON GROUP BY
 GO

 ---- Example #2
 SELECT [Customers].[CustomerID]
		, [Customers].[CompanyName]
		, COUNT([Orders].[OrderID]) AS [NumberOfOrders]
    FROM [Orders]
		 LEFT JOIN [Customers] ON [Orders].[CustomerID] = [Customers].[CustomerID]
	GROUP BY [Customers].[CustomerID], [Customers].[CompanyName]
		HAVING COUNT([Orders].[OrderID]) > 15		-- you CANNOT use Column Alias
	ORDER BY [NumberOfOrders] DESC				-- you CAN use Column Alias
 GO

