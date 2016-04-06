CREATE TABLE [dbo].[NewJerseyPick6Lotto] (
    [DrawNumber] INT          NOT NULL,
    [DrawDate]   VARCHAR (25) NULL,
    [Number1]    INT          NULL,
    [Number2]    INT          NULL,
    [Number3]    INT          NULL,
    [Number4]    INT          NULL,
    [Number5]    INT          NULL,
    [Number6]    INT          NULL,
    PRIMARY KEY CLUSTERED ([DrawNumber] ASC)
);


GO
CREATE NONCLUSTERED INDEX [_dta_index_NewJerseyPick6Lotto_7_1549248574__K6]
    ON [dbo].[NewJerseyPick6Lotto]([Number4] ASC);

