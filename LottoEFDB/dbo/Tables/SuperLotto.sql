CREATE TABLE [dbo].[SuperLotto] (
    [DrawNumber] INT          NOT NULL,
    [DrawDate]   VARCHAR (25) NULL,
    [Number1]    INT          NULL,
    [Number2]    INT          NULL,
    [Number3]    INT          NULL,
    [Number4]    INT          NULL,
    [Number5]    INT          NULL,
    CONSTRAINT [PK__SuperLot__63C2D4A8B90E67E9] PRIMARY KEY CLUSTERED ([DrawNumber] ASC)
);


GO
CREATE STATISTICS [_dta_stat_1790629422_6]
    ON [dbo].[SuperLotto]([Number4]);

