CREATE TABLE [dbo].[BritishLotto] (
    [DrawNumber] INT          NOT NULL,
    [DrawDate]   VARCHAR (25) NULL,
    [Number1]    INT          NULL,
    [Number2]    INT          NULL,
    [Number3]    INT          NULL,
    [Number4]    INT          NULL,
    [Number5]    INT          NULL,
    [Number6]    INT          NULL,
    [Bonus]      INT          NULL,
    CONSTRAINT [PK__BritishL__63C2D4A8A3AC4921] PRIMARY KEY CLUSTERED ([DrawNumber] ASC)
);

