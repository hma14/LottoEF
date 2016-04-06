CREATE TABLE [dbo].[FloridaLucky] (
    [DrawNumber] INT          NOT NULL,
    [DrawDate]   VARCHAR (25) NULL,
    [Number1]    INT          NULL,
    [Number2]    INT          NULL,
    [Number3]    INT          NULL,
    [Number4]    INT          NULL,
    [Lb]         INT          NULL,
    PRIMARY KEY CLUSTERED ([DrawNumber] ASC)
);

