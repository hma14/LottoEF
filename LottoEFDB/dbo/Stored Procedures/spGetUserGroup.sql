
CREATE PROCEDURE [dbo].[spGetUserGroup]
	@userName varchar(20)
AS
	SELECT userRole FROM tblUsers
	WHERE UserName = @userName
