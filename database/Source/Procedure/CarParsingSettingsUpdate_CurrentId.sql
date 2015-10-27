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
        EXECUTE dbo.ErrorInfoGet;
        -- If we have an open transaction and this sproc opened it then rollback to the save point, unless the
        -- transaction is doomed. If it is doomed then rollback all transactions if there are no previous transactions.
        IF (XACT_STATE() = 1) AND (@@TRANCOUNT > 0) ROLLBACK TRANSACTION;
        ELSE IF (XACT_STATE() = -1) AND (@@TRANCOUNT = 0) ROLLBACK TRANSACTION;
    END CATCH
END