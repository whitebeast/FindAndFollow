CREATE PROCEDURE [dbo].[CarLogInsert]
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION
            INSERT INTO dbo.CarLog
                (
                    [CarId],
                    [Price],
                    [Mileage],
                    [SellerType],
                    [Description],
                    [PageCreatedOn]
                )
            SELECT 
                    [CarId],
                    [Price],
                    [Mileage],
                    [SellerType],
                    [Description],
                    [PageCreatedOn]
            FROM    #Car
            ;
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END

        EXECUTE dbo.ErrorLogInsert @pSendEmail = 1;
    END CATCH
END

/*

exec dbo.CarLogInsert

*/