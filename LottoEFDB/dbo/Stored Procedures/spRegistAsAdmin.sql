





--Tables and Procedures for Membership Management



--ALTER TABLE tblUsers
--DROP CONSTRAINT PK_tblUsers 
--GO

--ALTER TABLE tblUsers
--DROP CONSTRAINT FK_userProvince 
--GO


--ALTER TABLE tblUsers
--DROP CONSTRAINT FK_userCountry 
--GO


--ALTER TABLE tblUsers
--DROP CONSTRAINT signup_check 
--GO






-- Stored Procedures

CREATE PROCEDURE [dbo].[spRegistAsAdmin](@uid VARCHAR(20)) 
	AS
		UPDATE tblUsers SET userRole='Admin' WHERE UserName=@uid
