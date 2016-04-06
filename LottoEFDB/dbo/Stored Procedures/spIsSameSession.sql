CREATE PROCEDURE [dbo].[spIsSameSession](@uid	VARCHAR(20), @ses VARCHAR(32))
	AS
	SELECT COUNT(*) FROM tblSession 
	WHERE userName=@uid AND sessionID=@ses
