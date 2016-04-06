	
CREATE PROCEDURE [dbo].[spGetProvinceID] (@name  VARCHAR(50))
	AS
	SELECT ID FROM tblProvinceState
	WHERE Name=@name 
