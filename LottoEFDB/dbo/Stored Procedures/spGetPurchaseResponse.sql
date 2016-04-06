
CREATE PROCEDURE [dbo].[spGetPurchaseResponse] AS
	SELECT payerEmail AS 'Payer Email', paymentStatus AS 'Payment Status', txnType AS 'Transaction Type'
	FROM tblPurchaseResponse
