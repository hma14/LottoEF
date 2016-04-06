

CREATE PROCEDURE [dbo].[spUpdatePassword](@email VARCHAR(50), @oldPassword VARCHAR(200))
	AS
	UPDATE tblUsers 
	SET passwordHash = @oldPassword
	WHERE @email=userEmail
