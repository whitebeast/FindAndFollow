CREATE PROCEDURE [dbo].[CarParsingSettingsGet_CurrentId]
    @pSiteURL NVARCHAR(1000)
AS
BEGIN
    SELECT  CurrentId,
            LastUploadDate
    FROM dbo.CarParsingSettings
    WHERE SiteURL = @pSiteURL
END