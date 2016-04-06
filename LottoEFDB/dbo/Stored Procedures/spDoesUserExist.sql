

CREATE PROCEDURE [dbo].[spDoesUserExist]
	@userName varchar(20)
AS
	IF EXISTS(
		SELECT * FROM tblUsers
		WHERE UserName = @userName)
		
		SELECT 'TRUE'
	ELSE
		SELECT 'FALSE'
