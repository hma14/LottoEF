
CREATE PROCEDURE [dbo].[spGetAboutContent]
AS
	SELECT aboutContent 
	FROM tblAboutPageContent
	WHERE aboutRowIndex = '1'
