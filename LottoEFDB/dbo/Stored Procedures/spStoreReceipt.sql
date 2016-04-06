	
CREATE PROCEDURE [dbo].[spStoreReceipt](@uid			VARCHAR(20), 
								@TransactionID  VARCHAR(25),
								@CCType 		VARCHAR(20),
								@CCNumber		VARCHAR(20),
								@CCExpiryDate	VARCHAR(20),
								@FullName       VARCHAR(20),
								@MemberPlan     VARCHAR(25),
								@StartDate      VARCHAR(12),
								@ExpiredDate    VARCHAR(12)
								)
	AS
		INSERT INTO tblReceipt VALUES(@uid, @TransactionID, 
									  @CCType, @CCNumber,@CCExpiryDate,
									  @FullName, @MemberPlan, 
									  @StartDate, @ExpiredDate);
		
