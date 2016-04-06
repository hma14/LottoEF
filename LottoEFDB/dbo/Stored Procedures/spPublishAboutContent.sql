

CREATE PROCEDURE [dbo].[spPublishAboutContent]
	@content TEXT
AS
	UPDATE tblAboutPageContent
	SET aboutContent = @content
	WHERE aboutRowIndex = '1'
