	
CREATE PROCEDURE [dbo].[spFindPassword](@email VARCHAR(50))
	AS
	SELECT passwordHash
	FROM tblUsers
	WHERE @email=userEmail
