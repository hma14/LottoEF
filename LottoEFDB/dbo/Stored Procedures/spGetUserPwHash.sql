
-- create stored procedure to retrieve user details
CREATE PROCEDURE [dbo].[spGetUserPwHash]
	@userName varchar(20)
AS
	SELECT PasswordHash 
	FROM tblUsers
	WHERE UserName = @userName
