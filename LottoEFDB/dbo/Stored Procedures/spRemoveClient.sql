
	
CREATE PROCEDURE [dbo].[spRemoveClient](@uid VARCHAR(20))
	AS
	DELETE FROM tblUsers
	WHERE UserName = @uid
