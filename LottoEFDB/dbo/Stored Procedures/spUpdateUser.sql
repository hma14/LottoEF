	
CREATE PROCEDURE spUpdateUser (
	@userName		VARCHAR(20),
	@passwordHash	VARCHAR(200),
	@userFName		VARCHAR(50),
	@userLName		VARCHAR(50),
	@userEmail		VARCHAR(50),
	@userCity		VARCHAR(50),
	@userCountry	VARCHAR(50),
	@userRole       VARCHAR(20),
	@signupDate     DATETIME,
	@expiryDate     DATETIME,
	@isLoggedIn     INTEGER

	)          
AS
	UPDATE tblUsers 
		SET passwordHash = @passwordHash,
		userFName = @userFName,
		userLName = @userLName, 
		userEmail = @userEmail,		
		userRole = @userRole,
		signupDate = @signupDate ,
		expiryDate = @expiryDate,
		isLoggedIn = @isLoggedIn,
		userCity = @userCity,
		userCountry = @userCountry
		
		WHERE userName = @userName
