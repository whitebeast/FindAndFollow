CREATE PROCEDURE [dbo].[CarOwnerPhoneInsert]
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            SET NOCOUNT ON;

            INSERT INTO [dbo].[CarOwnerPhone]
                (
                    [CarId],
                    [Phone]
                )
            SELECT  t.CarId,
                    f.Stringvalue 
            FROM #CarOwnerPhone t
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

        EXECUTE dbo.ErrorLogInsert;
    END CATCH
END