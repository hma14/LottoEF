	
CREATE PROCEDURE [dbo].[spGetClientExpired]
	AS
	UPDATE tblUsers SET userRole = 'Expired'
	WHERE (DATEDIFF(day, expiryDate, GETDATE()) >= 0) AND 
	  (userRole != 'Admin')	

	SELECT UserName, userFName + ' ' + userLName AS 'Client Name', userEmail AS Email, userRole AS Membership, CONVERT(CHAR, expiryDate, 101) AS 'Expiry Date'
	FROM tblUsers
	WHERE (userRole = 'Expired')
