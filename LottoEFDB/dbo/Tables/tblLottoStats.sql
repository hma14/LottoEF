CREATE TABLE [dbo].[tblLottoStats]
(
	[LottoId] INT NOT NULL PRIMARY KEY, 
    [DrawNo] INT NOT NULL, 
    [DrawDate] DATETIME NOT NULL, 
    [SumDrawNumbers] INT NOT NULL, 
    [NumberOdd] INT NOT NULL, 
    [NumberEven] INT NOT NULL
)
