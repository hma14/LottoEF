	
CREATE PROCEDURE [dbo].[spSaveSession](@uid	VARCHAR(20), @ses VARCHAR(32))
	AS
	IF (SELECT COUNT(*) FROM tblSession WHERE userName=@uid) = 0
		INSERT INTO tblSession VALUES(@uid, @ses)
	ELSE
		UPDATE tblSession SET sessionID=@ses WHERE userName=@uid
		
