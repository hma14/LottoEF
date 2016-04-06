CREATE TABLE [dbo].[tblUsers] (
    [UserName]     VARCHAR (20)  NOT NULL,
    [PasswordHash] VARCHAR (200) NOT NULL,
    [userFName]    VARCHAR (50)  NOT NULL,
    [userLName]    VARCHAR (50)  NOT NULL,
    [userEmail]    VARCHAR (50)  NOT NULL,
    [userRole]     VARCHAR (20)  CONSTRAINT [DF__tblUsers__userRo__07C12930] DEFAULT ('Member') NULL,
    [signupDate]   DATETIME      NULL,
    [expiryDate]   DATETIME      NULL,
    [isLoggedIn]   INT           CONSTRAINT [DF__tblUsers__isLogg__08B54D69] DEFAULT ((0)) NULL,
    [userCity]     NVARCHAR (50) NULL,
    [userCountry]  NVARCHAR (50) NULL,
    CONSTRAINT [PK_tblUsers] PRIMARY KEY CLUSTERED ([UserName] ASC),
    CONSTRAINT [signup_check] CHECK ([signupDate]<[expiryDate])
);

