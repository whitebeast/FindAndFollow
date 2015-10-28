CREATE PROCEDURE [dbo].[CarParsingSettingsUpdate_CurrentId]
    @pSiteURL NVARCHAR(1000),
    @pCurrentId INT
AS
BEGIN
BEGIN TRY
    BEGIN TRANSACTION
        SET NOCOUNT ON;

        UPDATE t
        SET t.CurrentId = @pCurrentId
        FROM dbo.CarParsingSettings t
        WHERE t.SiteURL = @pSiteURL
        ;
    COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END

        EXECUTE dbo.ErrorLogInsert;
    END CATCH
END