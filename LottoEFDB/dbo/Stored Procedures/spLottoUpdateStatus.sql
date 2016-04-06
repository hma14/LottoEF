-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spLottoUpdateStatus] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    declare @lotto nvarchar(100)
declare @sql nvarchar(1000)
declare @total int
declare @i int
declare @drawnumber varchar(5)
declare @drawdate varchar(25)

if object_id('tempdb..##temp_table') is not null
    drop table ##temp_table


create table ##temp_table 
(
	id int identity(1,1),
	LottoName varchar(100) null,
	DrawDate   varchar(25) null
)

set @i=0
set @total = (select count(*) from LottoName)

while (@i < @total)
begin
	set @lotto = (select distinct name from LottoName where id=@i)

	set @i = @i + 1
	set @sql = 'insert into ##temp_table (LottoName, DrawDate) values(''' + @lotto + ''', null)'
	
	exec(@sql)
	set @sql = 'update  ##temp_table ' + 
	'set  DrawDate = (select top 1 DrawDate from ' + @lotto + ' order by DrawNumber desc) where LottoName=''' + @lotto + ''''
	--print @sql
	exec(@sql)

end

select * from ##temp_table
END


