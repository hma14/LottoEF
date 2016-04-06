
CREATE PROCEDURE [dbo].[spRemoveAllReceipts](@uid VARCHAR(20))
	AS
		DELETE FROM tblReceipt WHERE userName=@uid
		
