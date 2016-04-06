
CREATE PROCEDURE [dbo].[spIsUserExist] (@userName varchar(20))
AS
	--SELECT COUNT(UserName) FROM tblUsers WHERE UserName = @userName
	SELECT COUNT(UserName) 
	FROM tblUsers
	WHERE UserName=@userName AND userRole <> 'Expired'