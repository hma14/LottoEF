CREATE TABLE [dbo].[aspnet_Users] (
    [ApplicationId]    UNIQUEIDENTIFIER NOT NULL,
    [UserId]           UNIQUEIDENTIFIER CONSTRAINT [DF__aspnet_Us__UserI__1DB06A4F] DEFAULT (newid()) NOT NULL,
    [UserName]         NVARCHAR (256)   NOT NULL,
    [LoweredUserName]  NVARCHAR (256)   NOT NULL,
    [MobileAlias]      NVARCHAR (16)    CONSTRAINT [DF__aspnet_Us__Mobil__1EA48E88] DEFAULT (NULL) NULL,
    [IsAnonymous]      BIT              CONSTRAINT [DF__aspnet_Us__IsAno__1F98B2C1] DEFAULT ((0)) NOT NULL,
    [LastActivityDate] DATETIME         NOT NULL,
    CONSTRAINT [PK__aspnet_U__1788CC4DC397CB4A] PRIMARY KEY NONCLUSTERED ([UserId] ASC),
    CONSTRAINT [FK__aspnet_Us__Appli__1CBC4616] FOREIGN KEY ([ApplicationId]) REFERENCES [dbo].[aspnet_Applications] ([ApplicationId])
);


GO
CREATE UNIQUE CLUSTERED INDEX [aspnet_Users_Index]
    ON [dbo].[aspnet_Users]([ApplicationId] ASC, [LoweredUserName] ASC);

