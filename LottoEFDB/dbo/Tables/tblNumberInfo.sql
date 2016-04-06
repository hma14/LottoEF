CREATE TABLE [dbo].[tblNumberInfo]
(
	[Id] BIGINT IDENTITY(1,1) NOT NULL , 	
	[Number] INT NOT NULL , 	
	[LottoId] INT NOT NULL, 
	[DrawNo] INT NOT NULL, 
	[DrawDate] DATETIME NOT NULL, 
    [Distance] INT NOT NULL DEFAULT (0) , 
    [SavedDistance] INT NOT NULL DEFAULT (0) , 
    [isHit] BIT NOT NULL DEFAULT (0), 
    CONSTRAINT [PK_tblNumberInfo] PRIMARY KEY ([Id]) 
)

