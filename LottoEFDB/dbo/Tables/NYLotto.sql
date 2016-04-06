CREATE TABLE [dbo].[NYLotto] (
    [DrawNumber] INT          NOT NULL,
    [DrawDate]   VARCHAR (25) NULL,
    [Number1]    INT          NULL,
    [Number2]    INT          NULL,
    [Number3]    INT          NULL,
    [Number4]    INT          NULL,
    [Number5]    INT          NULL,
    [Number6]    INT          NULL,
    [Bonus]      INT          NULL,
    CONSTRAINT [PK__NYLotto__63C2D4A8F5D1B636] PRIMARY KEY CLUSTERED ([DrawNumber] ASC)
);

