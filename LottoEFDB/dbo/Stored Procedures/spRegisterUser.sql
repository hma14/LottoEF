CREATE PROCEDURE spRegisterUser (
	@userName		VARCHAR(20),
	@passwordHash	VARCHAR(200),
	@userFName		VARCHAR(50),
	@userLName		VARCHAR(50),
	@userEmail		VARCHAR(50),
	@userCity		VARCHAR(50),
	@userCountry	VARCHAR(50),
	@userRole		VARCHAR(20),
	@signupDate     DATETIME,
	@expiryDate     DATETIME,
	@isLoggedIn     INTEGER
	 )
AS
	INSERT INTO tblUsers VALUES(
		@userName,
		@passwordHash,
		@userFName,
		@userLName,
		@userEmail,	
		@userRole,
		CONVERT(char,@signupDate,101),
		CONVERT(char,@expiryDate,101),
		--@signupDate,
		--@expiryDate,
		@isLoggedIn,
		@userCity,
		@userCountry
	)
