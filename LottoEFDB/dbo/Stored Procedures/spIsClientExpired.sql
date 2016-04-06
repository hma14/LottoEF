
CREATE PROCEDURE [dbo].[spIsClientExpired] (@uid	VARCHAR(20), @email VARCHAR(50))
	AS	
	SELECT COUNT(*) 
	FROM tblUsers
	WHERE UserName=@uid AND userEmail=@email AND userRole = 'Expired'	
