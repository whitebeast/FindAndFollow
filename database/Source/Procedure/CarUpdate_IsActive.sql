CREATE PROCEDURE [dbo].[CarUpdate_IsActive]
    @pCarId INT,
    @pIsActive BIT = 0
AS
BEGIN
BEGIN TRY
    BEGIN TRANSACTION
        SET NOCOUNT ON;

        UPDATE  dbo.Car 
        SET     IsActive = @pIsActive 
        WHERE   CarId = @pCarId
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

