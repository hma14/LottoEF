	
CREATE PROCEDURE [dbo].[spGetAllReceipt](@uid VARCHAR(20))
	AS
		SELECT * FROM tblReceipt WHERE userName=@uid
