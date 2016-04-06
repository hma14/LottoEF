CREATE TABLE [dbo].[tblDistance]
(
	[LottoId] INT NOT NULL PRIMARY KEY, 
    [DrawNo] INT NOT NULL, 
    [Distance] INT NOT NULL, 
    [Hits] INT NOT NULL DEFAULT (0)
)
