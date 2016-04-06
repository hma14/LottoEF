
CREATE PROCEDURE [dbo].[spRefundTransaction] (@transID VARCHAR(25), @amount MONEY) AS
	UPDATE tblTransactions 
	SET amount = amount - @amount, transType = 'Refund'
	WHERE transactionID = @transID
