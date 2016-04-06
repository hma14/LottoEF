	
CREATE PROCEDURE [dbo].[spGetReceipt](@uid VARCHAR(20), @TransactionID VARCHAR(25))
	AS
	SELECT TOP 1 [userName]
				  ,[TransactionID]
				  ,[CCType]
				  ,[CCNumber]
				  ,[CCExpiryDate]
				  ,[FullName]
				  ,[MemberPlan]
				  ,[StartDate]
				  ,[ExpiredDate]
	  FROM [lottotry].[dbo].[tblReceipt]
	  WHERE userName=@uid AND TransactionID=@TransactionID
	  ORDER BY StartDate DESC
