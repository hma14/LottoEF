CREATE PROCEDURE spViewAlltblUsers
AS
SELECT (userFName + ' ' + userLName) AS 'Full Name', 
	userEmail AS 'Email', 
	userRole AS 'Role', 
	CONVERT(DATE, signupDate, 103) as 'Signup Date',
	CONVERT(DATE, expiryDate, 103) as 'Expiry Date',
	isLoggedIn AS 'IsLoggedIn', 
	userCity AS 'City',
	userCountry AS 'Country'
	FROM tblUsers
	ORDER BY expiryDate DESC
