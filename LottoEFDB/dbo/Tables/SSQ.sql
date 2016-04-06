CREATE TABLE [dbo].[SSQ] (
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
CREATE NONCLUSTERED INDEX [_dta_index_SSQ_7_1152723159__K6]
    ON [dbo].[SSQ]([Number4] ASC);

