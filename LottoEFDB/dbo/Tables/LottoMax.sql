CREATE TABLE [dbo].[LottoMax] (
    [DrawNumber] INT          NOT NULL,
    [DrawDate]   VARCHAR (25) NULL,
    [Number1]    INT          NULL,
    [Number2]    INT          NULL,
    [Number3]    INT          NULL,
    [Number4]    INT          NULL,
    [Number5]    INT          NULL,
    [Number6]    INT          NULL,
    [Number7]    INT          NULL,
    [Bonus]      INT          NULL,
    PRIMARY KEY CLUSTERED ([DrawNumber] ASC)
);

GO
ALTER TABLE dbo.[LottoMax]
ENABLE CHANGE_TRACKING
WITH (TRACK_COLUMNS_UPDATED = ON)
