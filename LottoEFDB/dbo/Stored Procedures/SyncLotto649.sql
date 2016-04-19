CREATE PROCEDURE [dbo].[SyncLotto649]
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

FROM [dbo].[Lottery] as a
	join CHANGETABLE(CHANGES [dbo].[Lottery], @lastversion) AS CT on CT.DrawNumber= a.DrawNumber