CREATE TABLE [dbo].[Lottery] (
    [DrawNumber] INT          NOT NULL,
    [DrawDate]   VARCHAR (25) NULL,
    [Number1]    INT          NULL,
    [Number2]    INT          NULL,
    [Number3]    INT          NULL,
    [Number4]    INT          NULL,
    [Number5]    INT          NULL,
    [Number6]    INT          NULL,
    [Bonus]      INT          NULL,
    CONSTRAINT [PK__Lottery__63C2D4A8DA44B926] PRIMARY KEY CLUSTERED ([DrawNumber] ASC)
);
GO
ALTER TABLE dbo.[Lottery]
ENABLE CHANGE_TRACKING
WITH (TRACK_COLUMNS_UPDATED = ON)


GO
CREATE NONCLUSTERED INDEX [_dta_index_Lottery_7_539148966__K6]
    ON [dbo].[Lottery]([Number4] ASC);

