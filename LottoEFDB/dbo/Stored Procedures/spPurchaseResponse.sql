
CREATE PROCEDURE [dbo].[spPurchaseResponse] (@payerEmail VARCHAR(25), @paymentStatus VARCHAR(25), @txnType VARCHAR(25)) AS
	INSERT INTO tblPurchaseResponse VALUES(@payerEmail, @paymentStatus, @txnType)
