

CREATE PROCEDURE [dbo].[spGetAllEmail] 
	AS
		SELECT userEmail FROM tblUsers
