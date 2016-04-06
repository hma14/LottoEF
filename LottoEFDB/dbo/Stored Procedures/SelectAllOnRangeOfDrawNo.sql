
CREATE PROCEDURE [dbo].[SelectAllOnRangeOfDrawNo](@db int, @start int, @end int) 
	AS
	DECLARE @dbtable NVARCHAR(25), @sql  VARCHAR(500)
	SET @dbtable = (SELECT DISTINCT name from LottoName where id=@db)	
	SET @sql = 'SELECT * FROM ' + @dbtable + 
			' WHERE DrawNumber >= ' + str(@start) + ' AND DrawNumber <= ' + str(@end)	
	EXEC(@sql)
