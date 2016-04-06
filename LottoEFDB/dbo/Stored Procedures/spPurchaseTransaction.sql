
CREATE PROCEDURE [dbo].[spPurchaseTransaction] (@transID VARCHAR(25), @amount MONEY, @name VARCHAR(25)) AS
	INSERT INTO tblTransactions VALUES (@transID, @amount, @name, 'Purchase')
