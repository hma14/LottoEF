

CREATE PROCEDURE [dbo].[spLoginAuth](@uid VARCHAR(20), @pwd VARCHAR(200)) 
	AS
	SELECT COUNT(UserName) 
	FROM tblUsers
	WHERE @uid=UserName AND @pwd=PasswordHash AND userRole!='Expired'
