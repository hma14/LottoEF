CREATE TABLE [dbo].[EuroMillions_LuckyStars] (
    [DrawNumber] INT          NOT NULL,
    [DrawDate]   VARCHAR (25) NULL,
    [Star1]      INT          NULL,
    [Star2]      INT          NULL,
    PRIMARY KEY CLUSTERED ([DrawNumber] ASC)
);

