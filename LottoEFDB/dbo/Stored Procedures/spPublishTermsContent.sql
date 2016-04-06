

CREATE PROCEDURE [dbo].[spPublishTermsContent]
	@content TEXT
AS
	UPDATE tblTermsPageContent
	SET termsContent = @content
	WHERE termsRowIndex = '1'
