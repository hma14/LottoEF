
CREATE PROCEDURE [dbo].[SelectAll](@db int) 
	AS
	DECLARE @dbtable NVARCHAR(25), @sql  VARCHAR(500)
	SET @dbtable = (SELECT DISTINCT name from LottoName where id=@db)	
	SET @sql = 'SELECT * FROM ' + @dbtable	
	EXEC(@sql)
