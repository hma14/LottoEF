CREATE TABLE [dbo].[OregonMegabucks] (
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
CREATE STATISTICS [_dta_stat_1581248688_6]
    ON [dbo].[OregonMegabucks]([Number4]);

