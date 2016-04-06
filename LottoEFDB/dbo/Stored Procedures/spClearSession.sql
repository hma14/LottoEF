	
CREATE PROCEDURE [dbo].[spClearSession](@uid	VARCHAR(20))
	AS
		DELETE FROM tblSession WHERE userName=@uid
		
