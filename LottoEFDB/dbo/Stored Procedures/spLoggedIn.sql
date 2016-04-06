
CREATE PROCEDURE [dbo].[spLoggedIn](@uid VARCHAR(20), @flag INTEGER)
	AS
		UPDATE tblUsers 
		SET isLoggedIn = @flag
		WHERE @uid = UserName
