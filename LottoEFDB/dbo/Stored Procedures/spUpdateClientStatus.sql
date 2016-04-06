CREATE PROCEDURE spUpdateClientStatus
	AS
	UPDATE tblUsers SET userRole = 'Expired'
	WHERE (DATEDIFF(day, expiryDate, GETDATE()) >= 0) AND 
	  (userRole != 'Admin')	
