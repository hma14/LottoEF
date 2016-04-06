
--CREATE PROCEDURE spGetMemberInfoByCity(@cityName VARCHAR(20)) 
--	AS
--	SELECT userFName,userLName,userEmail,isLoggedIn, userPhone, userStreet, userStreet2, userCity,
--	userProvince,userPostalCode,userCountry
--	FROM tblUsers
--	WHERE @cityName=userCity
--GO
--CREATE PROCEDURE spShowCityList
--	AS
--		SELECT * FROM tblCityList ORDER BY cityName
--GO


CREATE PROCEDURE [dbo].[spGetLottoName]
	AS
		SELECT * from Lottos ORDER BY name ASC
