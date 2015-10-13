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
        EXECUTE dbo.ErrorInfoGet;
        -- If we have an open transaction and this sproc opened it then rollback to the save point, unless the
        -- transaction is doomed. If it is doomed then rollback all transactions if there are no previous transactions.
        IF (XACT_STATE() = 1) AND (@@TRANCOUNT > 0) ROLLBACK TRANSACTION;
        ELSE IF (XACT_STATE() = -1) AND (@@TRANCOUNT = 0) ROLLBACK TRANSACTION;
    END CATCH
END