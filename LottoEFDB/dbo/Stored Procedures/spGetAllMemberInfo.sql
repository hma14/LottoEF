
CREATE PROCEDURE [dbo].[spGetAllMemberInfo]
AS
	SELECT  userFName,userLName,userEmail,isLoggedIn
	FROM tblUsers
