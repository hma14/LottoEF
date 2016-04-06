CREATE TABLE [dbo].[tblCountry] (
    [ID]   INT          IDENTITY (1, 1) NOT NULL,
    [Name] VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_tblCountry] PRIMARY KEY CLUSTERED ([Name] ASC)
);

