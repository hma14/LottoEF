CREATE TABLE [dbo].[FloridaFantasy5] (
    [DrawNumber] INT          NOT NULL,
    [DrawDate]   VARCHAR (25) NULL,
    [Number1]    INT          NULL,
    [Number2]    INT          NULL,
    [Number3]    INT          NULL,
    [Number4]    INT          NULL,
    [Number5]    INT          NULL,
    PRIMARY KEY CLUSTERED ([DrawNumber] ASC)
);


GO
CREATE NONCLUSTERED INDEX [_dta_index_FloridaFantasy5_7_1625772849__K6]
    ON [dbo].[FloridaFantasy5]([Number4] ASC);

