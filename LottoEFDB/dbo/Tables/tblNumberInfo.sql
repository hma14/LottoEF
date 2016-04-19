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
    [Frequency] INT NULL, 
    CONSTRAINT [PK_tblNumberInfo] PRIMARY KEY ([Id]) 
)

GO
CREATE NONCLUSTERED INDEX [_dta_index_tblNumberInfo_23_1731589307__K3_1_2_4_5_6_7_8_9] ON [dbo].[tblNumberInfo]
(
	[LottoId] ASC
)
INCLUDE ( 	[Id],
	[Number],
	[DrawNo],
	[DrawDate],
	[Distance],
	[SavedDistance],
	[isHit],
	[Frequency]) WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
