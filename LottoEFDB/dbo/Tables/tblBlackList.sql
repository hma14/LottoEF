CREATE TABLE [dbo].[tblBlackList] (
    [ListID] INT           IDENTITY (1, 1) NOT NULL,
    [UserID] NVARCHAR (25) NOT NULL,
    [Email]  NVARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([ListID] ASC)
);

