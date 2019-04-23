

PRINT 'Hello World'

PRINT 'Having fun with' + ' TSQL and MS SQL SERVER!'

DECLARE @myVariable INT 
SET @myVariable = 6
PRINT @myVariable


DECLARE @var1 INT, @var2 INT
SET @var1 = 7
SET @var2 = 5
PRINT 'Variable 1= ' + CONVERT(VARCHAR(5),@var1) + char(13) + 'Variable 2= ' + CONVERT(VARCHAR(50),@var2) + CHAR(13) + 'Total: '
PRINT @var1 + @var2

IF @var1 != 3
	BEGIN
		PRINT 'Variable 1 is NOT ' + CONVERT(VARCHAR(5),@var1) + CHAR(13)
	END
ELSE
	BEGIN
		PRINT 'Variable 1 is not <= ' + CONVERT(VARCHAR(5),@var1) + CHAR(13)
	END

DECLARE @vvar1 INT, @vvar2 INT
SET @vvar1 = 4
SET @vvar2 = 5

IF @vvar1 < 2
	BEGIN
		PRINT '@vvar1 < 2'
	END
ELSE IF @vvar1 > 1 AND @vvar1 < 3
	BEGIN
		PRINT '@vvar1 > 1 AND @vvar1 < 3'
	END
ELSE IF @vvar1 = 4 OR @vvar1 < 6
	BEGIN
		PRINT '@vvar1 = 4 OR @vvar1 < 6'
	END
ELSE
	PRINT '@var1 does not qualify!'


