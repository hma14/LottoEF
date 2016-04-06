CREATE TABLE [dbo].[EuroJackpot_Euros] (
    [DrawNumber] INT          NOT NULL,
    [DrawDate]   VARCHAR (25) NULL,
    [Euro1]      INT          NULL,
    [Euro2]      INT          NULL,
    PRIMARY KEY CLUSTERED ([DrawNumber] ASC)
);

