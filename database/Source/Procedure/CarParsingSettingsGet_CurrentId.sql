CREATE PROCEDURE [dbo].[CarParsingSettingsGet_CurrentId]
    @pSiteURL NVARCHAR(1000)
AS
BEGIN
    SELECT CurrentId
    FROM dbo.CarParsingSettings
    WHERE SiteURL = @pSiteURL
END