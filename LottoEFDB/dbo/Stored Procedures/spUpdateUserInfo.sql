
CREATE PROCEDURE [dbo].[spUpdateUserInfo] (
	@userName		VARCHAR(20),
	@passwordHash	VARCHAR(200),
	@userFName		VARCHAR(50),
	@userLName		VARCHAR(50),
	@userEmail		VARCHAR(50)
	)          
AS
	UPDATE tblUsers 
		SET passwordHash = @passwordHash,
		userFName = @userFName,
		userLName = @userLName, 
		userEmail = @userEmail
		WHERE userName = @userName
