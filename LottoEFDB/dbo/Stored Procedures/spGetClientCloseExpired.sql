	
CREATE PROCEDURE [dbo].[spGetClientCloseExpired]
	AS
	SELECT UserName, userFName + ' ' + userLName AS 'Client Name', userEmail AS Email, CONVERT(CHAR, expiryDate, 101) AS 'Expiry Date'
	FROM tblUsers
	WHERE (DATEDIFF(day, expiryDate, GETDATE() + 30) >= 0) AND 
		  (DATEDIFF(day, expiryDate, GETDATE()) < 0) AND
		  (userRole != 'Admin')
