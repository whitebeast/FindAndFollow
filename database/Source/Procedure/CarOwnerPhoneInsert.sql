CREATE PROCEDURE [dbo].[CarOwnerPhoneInsert]
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            SET NOCOUNT ON;

            UPDATE  cop
            SET     cop.IsActual = 0
            FROM    dbo.CarOwnerPhone AS cop
            JOIN    #Car AS t ON t.CarId = cop.CarId
            WHERE   cop.IsActual = 1
            ;
            INSERT INTO [dbo].[CarOwnerPhone]
                (
                    [CarId],
                    [Phone]
                )
            SELECT  DISTINCT
                    t.CarId,
                    f.Stringvalue
            FROM #Car t
            CROSS APPLY dbo.ParseJSON (t.OwnerPhone) f
            WHERE   f.Name = 'phoneNumber'
                AND t.OwnerPhone IS NOT NULL
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