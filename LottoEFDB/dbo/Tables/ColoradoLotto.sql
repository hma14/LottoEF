CREATE TABLE [dbo].[ColoradoLotto] (
    [DrawNumber] INT          NOT NULL,
    [DrawDate]   VARCHAR (25) NULL,
    [Number1]    INT          NULL,
    [Number2]    INT          NULL,
    [Number3]    INT          NULL,
    [Number4]    INT          NULL,
    [Number5]    INT          NULL,
    [Number6]    INT          NULL,
    CONSTRAINT [PK__Colorado__63C2D4A89D15C68B] PRIMARY KEY CLUSTERED ([DrawNumber] ASC)
);

