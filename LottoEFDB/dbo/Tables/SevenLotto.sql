CREATE TABLE [dbo].[SevenLotto] (
    [DrawNumber] INT          NOT NULL,
    [DrawDate]   VARCHAR (25) NULL,
    [Number1]    INT          NULL,
    [Number2]    INT          NULL,
    [Number3]    INT          NULL,
    [Number4]    INT          NULL,
    [Number5]    INT          NULL,
    [Number6]    INT          NULL,
    [Number7]    INT          NULL,
    [Special]    INT          NULL,
    CONSTRAINT [PK__SevenLot__63C2D4A8FFE3E7F1] PRIMARY KEY CLUSTERED ([DrawNumber] ASC)
);

