CREATE PROCEDURE dbo.CarParsingClean
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            SET NOCOUNT ON;

            DELETE FROM dbo.CarParsing 
            WHERE IsPageExist = 0
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