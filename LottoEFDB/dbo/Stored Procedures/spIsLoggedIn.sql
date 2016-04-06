
CREATE PROCEDURE [dbo].[spIsLoggedIn](@uid VARCHAR(20))
	AS
		SELECT isLoggedIn from tblUsers 
		WHERE @uid = UserName
