	
	
CREATE PROCEDURE [dbo].[spGetUserRole](@uid VARCHAR(20))
	AS
	SELECT userRole
	FROM tblUsers
	WHERE @uid=UserName
