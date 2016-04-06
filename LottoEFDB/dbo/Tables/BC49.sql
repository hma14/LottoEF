CREATE TABLE [dbo].[BC49] (
    [DrawNumber] INT          NOT NULL,
    [DrawDate]   VARCHAR (25) NULL,
    [Number1]    INT          NULL,
    [Number2]    INT          NULL,
    [Number3]    INT          NULL,
    [Number4]    INT          NULL,
    [Number5]    INT          NULL,
    [Number6]    INT          NULL,
    [Bonus]      INT          NULL,
    CONSTRAINT [PK__BC49__63C2D4A8EA99034E] PRIMARY KEY CLUSTERED ([DrawNumber] ASC)
);

GO
ALTER TABLE dbo.[BC49]
ENABLE CHANGE_TRACKING
WITH (TRACK_COLUMNS_UPDATED = ON)
GO

GO
CREATE NONCLUSTERED INDEX [_dta_index_BC49_7_347148282__K6]
    ON [dbo].[BC49]([Number4] ASC);

