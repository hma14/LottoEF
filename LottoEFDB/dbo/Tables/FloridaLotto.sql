CREATE TABLE [dbo].[FloridaLotto] (
    [DrawNumber] INT          NOT NULL,
    [DrawDate]   VARCHAR (25) NULL,
    [Number1]    INT          NULL,
    [Number2]    INT          NULL,
    [Number3]    INT          NULL,
    [Number4]    INT          NULL,
    [Number5]    INT          NULL,
    [Number6]    INT          NULL,
    [Xtra]       INT          NULL,
    CONSTRAINT [PK__FloridaL__63C2D4A8C50123D6] PRIMARY KEY CLUSTERED ([DrawNumber] ASC)
);

