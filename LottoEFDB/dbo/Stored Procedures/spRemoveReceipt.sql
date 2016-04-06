	
CREATE PROCEDURE [dbo].[spRemoveReceipt](@uid VARCHAR(20), @transactionID VARCHAR(25))
	AS
		DELETE FROM tblReceipt WHERE userName=@uid AND TransactionID=@transactionID 
		
