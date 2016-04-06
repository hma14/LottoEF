	
CREATE PROCEDURE [dbo].[spCountUsers] 
	AS
	SELECT COUNT(UserName) 
	FROM tblUsers
	WHERE userRole = 'Member'
