
CREATE PROCEDURE [dbo].[spGetTransactionID](@uid VARCHAR(20))
	AS
		SELECT  TransactionID FROM tblReceipt WHERE userName=@uid
		
