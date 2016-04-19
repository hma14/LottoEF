CREATE PROCEDURE [dbo].[SyncBC49]
	@lastversion bigint
AS

	SELECT CHANGE_TRACKING_CURRENT_VERSION() AS CurrentVersion

	SELECT 
	a.DrawNumber 
	,a.DrawDate
	,a.Number1
	,a.Number2
	,a.Number3
	,a.Number4
	,a.Number5
	,a.Number6
	,a.Bonus
	--,case when CT.SYS_CHANGE_COLUMNS is null then 0 else
	--CHANGE_TRACKING_IS_COLUMN_IN_MASK(COLUMNPROPERTY(OBJECT_ID('BC49'), 'DrawNumber', 'ColumnId'), CT.SYS_CHANGE_COLUMNS) 
	--+CHANGE_TRACKING_IS_COLUMN_IN_MASK(COLUMNPROPERTY(OBJECT_ID('BC49'), 'DrawDate', 'ColumnId'), CT.SYS_CHANGE_COLUMNS) END
	--FieldsChanged
--FROM (select name from dbo.LottoName where name = @name) as a 
FROM [dbo].[BC49] as a
	join CHANGETABLE(CHANGES [dbo].[BC49], @lastversion) AS CT on CT.DrawNumber= a.DrawNumber

--WHERE case when CT.SYS_CHANGE_COLUMNS is null then 0 else
--	CHANGE_TRACKING_IS_COLUMN_IN_MASK(COLUMNPROPERTY(OBJECT_ID(@name), 'DrawNumber', 'ColumnId'), CT.SYS_CHANGE_COLUMNS) 
--	+CHANGE_TRACKING_IS_COLUMN_IN_MASK(COLUMNPROPERTY(OBJECT_ID(@name), 'DrawDate', 'ColumnId'), CT.SYS_CHANGE_COLUMNS) END > 0

