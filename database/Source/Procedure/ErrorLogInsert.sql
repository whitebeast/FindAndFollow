CREATE PROCEDURE [dbo].[ErrorLogInsert]
    (
        @pErrorNumber       INT = NULL, 
        @pErrorSeverity     INT = NULL, 
        @pErrorState        INT = NULL, 
        @pErrorObject       NVARCHAR(126) = NULL, 
        @pIsService         BIT = 0,
        @pErrorLine         INT = NULL, 
        @pErrorMessageShort NVARCHAR(1000) = 'System error',
        @pErrorMessageFull  NVARCHAR(4000) = NULL        
    )
AS
BEGIN
    SET NOCOUNT ON;

    SELECT  @pErrorNumber       = COALESCE(@pErrorNumber, ERROR_NUMBER()),  
            @pErrorSeverity     = COALESCE(@pErrorSeverity, ERROR_SEVERITY()),
            @pErrorState        = COALESCE(@pErrorState, ERROR_STATE()),
            @pErrorObject       = COALESCE(@pErrorObject, ERROR_PROCEDURE()),
            @pErrorLine         = COALESCE(@pErrorLine, ERROR_LINE()),
            @pErrorMessageFull  = COALESCE(@pErrorMessageFull, ERROR_MESSAGE())
    ;
    BEGIN TRY
        -- Return if there is no error information to log
        IF @pErrorNumber IS NULL
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
            [ErrorNumber],
	        [ErrorSeverity],
	        [ErrorState],
	        [ErrorObject],
            [IsService],
	        [ErrorLine],
            [ErrorMessageShort],
            [ErrorMessageFull],
            [UserName]
            ) 
        VALUES 
            (
            @pErrorNumber, 
            @pErrorSeverity, 
            @pErrorState, 
            @pErrorObject,
            @pIsService, 
            @pErrorLine, 
            @pErrorMessageShort,
            @pErrorMessageFull,
            CONVERT(sysname, SUSER_NAME())
            );
        
        EXEC msdb.dbo.sp_send_dbmail
			@recipients = 'Administrator',
			@subject = N'Error notification',
			@body = @pErrorMessageFull,
			@body_format = 'HTML',
			@profile_name = 'FindAndFollow.Notification Mailer';

        IF ERROR_MESSAGE() IS NOT NULL EXECUTE [dbo].[ErrorInfoGet];

    END TRY
    BEGIN CATCH
        PRINT 'An error occurred in stored procedure ErrorLogInsert:';
        EXECUTE [dbo].[ErrorInfoGet];
        RETURN -1;
    END CATCH
END;