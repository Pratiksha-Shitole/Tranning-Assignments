/*
 *  Understanding Type Conversion
 ******************************************************/
 
 DECLARE @intVar int = 10
 DECLARE @moneyVar money = @intVar		-- implicit type conversion
 SELECT @intVar AS [intVar], @moneyVar AS [moneyVar]
 GO

 DECLARE @moneyVar money = $34.35
 DECLARE @intVar int = @moneyVar		-- implicit type conversion - but loose precision
 SELECT @intVar AS [intVar], @moneyVar AS [moneyVar]
 GO


 /*
 *  Using CAST(): Converting to Data Type
 ******************************************************/

 --- Example #1: Converting to Binary Data Type
 SELECT CAST(32 AS binary(4)) AS resultBinary;

 --- Example #2: Converting to Integer Data Type
 DECLARE @var varchar(6) = '00009 '
 SELECT @var, CAST( @var AS int ) AS resultInt
 SELECT @var + 1, CAST( @var AS int ) + 1 AS resultInt
 SELECT @var + $1.45, CAST( @var AS money ) + $1.45 AS resultMoney
 GO

 --- Example #3: Converting to DateTime Data Type
 DECLARE @var varchar(15) = '2020-11-25'
 SELECT CAST( @var AS smalldatetime ) AS resultSmallDateTime
        , CAST( @var AS date ) AS resultDate
        , CAST( @var AS datetime ) AS resultDateTime
		, CAST( @var AS time ) AS resultTime
		, CAST( @var AS datetime2 ) AS resultDateTime2
 GO

 DECLARE @var varchar(15) = 'abcd'
 -- SELECT @var, CAST( @var AS int ) AS resultInt
 SELECT @var, TRY_CAST( @var AS int ) AS resultInt


 /*
 *  Using CONVERT(): Converting Data Type
 ******************************************************/

 SELECT GETDATE()

 -- CAST( GETDATE() AS varchar(20) )
 -- TRY_CAST( GETDATE() AS varchar(20) )

 --- convert date into the ISO Culture - Standard Date Formats
 SELECT GETDATE() AS dtGetDate
        , CONVERT( varchar(20), GETDATE(), 108 ) AS strDate108
        , CONVERT( varchar(20), GETDATE(), 107 ) AS strDate107
        , CONVERT( varchar(20), GETDATE(), 6 ) AS strDate6
        , CONVERT( varchar(20), GETDATE(), 106 ) AS strDate106
        , CONVERT( varchar(20), GETDATE(), 113 ) AS strDate113
 GO



/*
 *  Using FORMAT(): To custom format
 ******************************************************/

 --- Example #1: custom formatting dates
 SELECT FORMAT( getdate(), 'dd-MMM-yyyy' ) AS fld1
        , FORMAT( getdate(), 'dd-MMM-yyyy hh:mm:ss tt' ) AS fld2
        , FORMAT( getdate(), 'dddd, dd-MMM-yyyy hh:mm:ss tt' ) AS fld3
 GO

 --- Example #2: custom formatting dates
 DECLARE @d datetime = '2020-03-24'
 SELECT FORMAT( @d, 'dd-MMM-yyyy' ) AS fld1
        , FORMAT( @d, 'dd-MMM-yyyy hh:mm:ss' ) AS fld2
        , FORMAT( @d, 'dd-MMM-yyyy hh:mm:ss tt' ) AS fld3
        , FORMAT( @d, 'dddd, dd-MMM-yyyy hh:mm:ss tt' ) AS fld4
 GO

 --- Example #3: custom formatting with Culture
 SELECT FORMAT( getdate(), 'd', 'en-us' ) AS fld1
	    , FORMAT( getdate(), 'D', 'en-us' ) AS fld2
		, FORMAT( getdate(), 'd', 'zh-CHS' ) AS fld3	-- simplified chinese
		, FORMAT( getdate(), 'D', 'zh-CHS' ) AS fld3	-- simplified chinese
		, FORMAT( getdate(), 'D', 'fr-FR' ) AS fld2
		, FORMAT( getdate(), 'D', 'hi-IN' ) AS fld2
 GO

 --- Example #4: custom formatting numbers
 SELECT FORMAT( 12785.75, '########' ) AS fld1
        , FORMAT( 0.00, '##,##0.0000' ) AS fld2
        , FORMAT( 12345785.75, 'US$ ###,##0.00' ) AS fld2
        , FORMAT( 12345785.75, 'AU$ ##,###,##0.000000' ) AS fld4
 GO

 SELECT FORMAT(12, '00000')
 SELECT FORMAT(12, '####0')
 SELECT FORMAT( 9+3, REPLICATE('0', 5) )
 GO


/*
 *  Working with GUID
 ******************************************************/
 SELECT NEWID() AS [newID]
		, CAST('1C0E3B5C-EA7A-41DC-8E1C-D0A302BE558B' AS uniqueidentifier) AS [oldID]
 GO


 /*
 *  Behavior of '+' when concatenating NULL values
 ******************************************************/

 DECLARE @var1 varchar(10) = 'Hello'
 DECLARE @var2 varchar(10) = NULL
 DECLARE @var3 varchar(10) = 'world'
 SELECT @var1 + ',' + @var2 + ',' + @var3
 SELECT CONCAT(@var1, ',', @var2, ',', @var3)
 GO

 
