
CREATE PROCEDURE [dbo].[spGetAmount](@transID VARCHAR(25)) AS
	SELECT CONVERT(DECIMAL(6, 2), ROUND(amount, 2)) AS Amount 
	FROM tblTransactions
	WHERE transactionID=@transID
