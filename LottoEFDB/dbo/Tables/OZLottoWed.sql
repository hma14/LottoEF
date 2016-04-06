CREATE TABLE [dbo].[OZLottoWed] (
    [DrawNumber] INT          NOT NULL,
    [DrawDate]   VARCHAR (25) NULL,
    [Number1]    INT          NULL,
    [Number2]    INT          NULL,
    [Number3]    INT          NULL,
    [Number4]    INT          NULL,
    [Number5]    INT          NULL,
    [Number6]    INT          NULL,
    [Supp1]      INT          NULL,
    [Supp2]      INT          NULL,
    PRIMARY KEY CLUSTERED ([DrawNumber] ASC)
);

