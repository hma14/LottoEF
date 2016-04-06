CREATE PROCEDURE spIsEmailInBlackList(@email VARCHAR(50))
	AS
	select count(*) from tblBlackList 
	where Email = @email
