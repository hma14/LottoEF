	
	
CREATE PROCEDURE [dbo].[spAllDrawNumbers](@db int, @dnum VARCHAR(5)) 
	AS
	DECLARE @dbtable NVARCHAR(25), @sql  VARCHAR(500)
	SET @dbtable = (SELECT DISTINCT name from LottoName where id=@db)
	SET @sql = 'SELECT DrawNumber FROM ' + @dbtable +
			' WHERE CAST(DrawNumber AS VARCHAR(5)) like ' + '''' + @dnum + '%' + '''' + 
			' ORDER BY DrawNumber DESC'
	

	EXEC(@sql)
