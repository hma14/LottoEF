create procedure spBlackList(@uid varchar(20), @email varchar(50))
	AS
	INSERT INTO tblBlackList VALUES(@uid, @email)
