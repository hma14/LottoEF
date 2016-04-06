	
CREATE PROCEDURE [dbo].[spGetUserFullName](@uid VARCHAR(20))	
	AS
	SELECT userFName + ' ' + userLName 
	FROM tblUsers
	WHERE @uid = UserName
