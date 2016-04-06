	
CREATE PROCEDURE [dbo].[spGetCountryID] (@name  VARCHAR(50))
	AS
	SELECT ID FROM tblCountry 
	WHERE Name=@name 
