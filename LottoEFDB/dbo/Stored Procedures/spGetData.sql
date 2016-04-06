
CREATE PROCEDURE [dbo].[spGetData] AS
	SELECT transEntry AS 'Transaction Entry', transactionID AS 'Transaction ID',
		CONVERT(DECIMAL(6, 2), ROUND(amount, 2)) AS Amount, customerName As 'Customer Name', transType AS 'Transaction Type'
	FROM tblTransactions
	ORDER BY transEntry
