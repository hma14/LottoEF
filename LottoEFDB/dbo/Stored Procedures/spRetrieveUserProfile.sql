	
CREATE PROCEDURE [dbo].[spRetrieveUserProfile](@uid VARCHAR(20))
	AS
	SELECT  * FROM tblUsers
	WHERE UserName = @uid
	
