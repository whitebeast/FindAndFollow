CREATE PROCEDURE [dbo].[ErrorLogInsert]
    (
        @pSource         NVARCHAR(20) = NULL,
        @pExMessage      NVARCHAR(1000) = NULL,
        @pExStackTrace   NVARCHAR(2000) = NULL
    )
AS
BEGIN
    SET NOCOUNT ON;

    IF @pSource = 'SERVICE'
    BEGIN
        BEGIN TRY
            INSERT [dbo].[ErrorLog] 
                (
                [UserName], 
                [ErrorNumber], 
                [ErrorSeverity], 
                [ErrorState], 
                [ErrorProcedure], 
                [ErrorLine], 
                [ErrorMessage]
                ) 
            VALUES 
                (
                CONVERT(sysname, CURRENT_USER), 
                0,
                NULL,
                NULL,
                @pExMessage,
                NULL,
                @pExStackTrace
                );
        END TRY
        BEGIN CATCH
            PRINT 'An error occurred in stored procedure ErrorLogInsert: service';
            EXECUTE [dbo].[ErrorInfoGet];
            RETURN -1;
        END CATCH
    END

    IF @pSource IS NULL
    BEGIN
        BEGIN TRY
            -- Return if there is no error information to log
            IF ERROR_NUMBER() IS NULL
                RETURN;

            -- Return if inside an uncommittable transaction.
            -- Data insertion/modification is not allowed when 
            -- a transaction is in an uncommittable state.
            IF XACT_STATE() = -1
            BEGIN
                PRINT 'Cannot log error since the current transaction is in an uncommittable state. ' 
                    + 'Rollback the transaction before executing uspLogError in order to successfully log error information.';
                RETURN;
            END

            INSERT [dbo].[ErrorLog] 
                (
                [UserName], 
                [ErrorNumber], 
                [ErrorSeverity], 
                [ErrorState], 
                [ErrorProcedure], 
                [ErrorLine], 
                [ErrorMessage]
                ) 
            VALUES 
                (
                CONVERT(sysname, CURRENT_USER), 
                ERROR_NUMBER(),
                ERROR_SEVERITY(),
                ERROR_STATE(),
                ERROR_PROCEDURE(),
                ERROR_LINE(),
                ERROR_MESSAGE()
                );

        END TRY
        BEGIN CATCH
            PRINT 'An error occurred in stored procedure ErrorLogInsert: database';
            EXECUTE [dbo].[ErrorInfoGet];
            RETURN -1;
        END CATCH
    END
END;
