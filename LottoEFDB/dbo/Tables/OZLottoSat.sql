CREATE TABLE [dbo].[OZLottoSat] (
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


GO
CREATE NONCLUSTERED INDEX [_dta_index_OZLottoSat_7_1652200936__K6]
    ON [dbo].[OZLottoSat]([Number4] ASC);

