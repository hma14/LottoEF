CREATE TABLE [dbo].[aspnet_Applications] (
    [ApplicationName]        NVARCHAR (256)   NOT NULL,
    [LoweredApplicationName] NVARCHAR (256)   NOT NULL,
    [ApplicationId]          UNIQUEIDENTIFIER CONSTRAINT [DF__aspnet_Ap__Appli__19DFD96B] DEFAULT (newid()) NOT NULL,
    [Description]            NVARCHAR (256)   NULL,
    CONSTRAINT [PK__aspnet_A__C93A4C98091BC0DE] PRIMARY KEY NONCLUSTERED ([ApplicationId] ASC),
    CONSTRAINT [UQ__aspnet_A__17477DE45B6A7098] UNIQUE NONCLUSTERED ([LoweredApplicationName] ASC),
    CONSTRAINT [UQ__aspnet_A__30910331C3AAA83E] UNIQUE NONCLUSTERED ([ApplicationName] ASC)
);


GO
CREATE CLUSTERED INDEX [aspnet_Applications_Index]
    ON [dbo].[aspnet_Applications]([LoweredApplicationName] ASC);

