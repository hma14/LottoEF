CREATE TABLE [dbo].[aspnet_UsersInRoles] (
    [UserId] UNIQUEIDENTIFIER NOT NULL,
    [RoleId] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK__aspnet_U__AF2760AD0AA800A5] PRIMARY KEY CLUSTERED ([UserId] ASC, [RoleId] ASC),
    CONSTRAINT [FK__aspnet_Us__RoleI__503BEA1C] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[aspnet_Roles] ([RoleId]),
    CONSTRAINT [FK__aspnet_Us__UserI__4F47C5E3] FOREIGN KEY ([UserId]) REFERENCES [dbo].[aspnet_Users] ([UserId])
);

