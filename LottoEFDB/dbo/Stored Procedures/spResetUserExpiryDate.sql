




CREATE PROCEDURE [dbo].[spResetUserExpiryDate](@userName VARCHAR(20), @days INT)
	AS
		update tblUsers 
		set expiryDate = (select DATEADD(day, @days, CURRENT_TIMESTAMP)),
		userRole='Member'
		WHERE UserName=@userName
		
