		
CREATE PROCEDURE [dbo].[spRemoveExpiredClient]
	AS
	DELETE FROM tblUsers
	WHERE userRole = 'Expired'
