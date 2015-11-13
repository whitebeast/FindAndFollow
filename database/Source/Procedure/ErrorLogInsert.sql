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
    IF OBJECT_ID('tempdb..##tErrorLog')  IS NOT NULL DROP TABLE ##tErrorLog;
    CREATE TABLE ##tErrorLog 
        (
            [ErrorNumber] [int] NOT NULL,
            [ErrorSeverity] [int] NULL,
            [ErrorState] [int] NULL,
            [ErrorObject] [nvarchar](126) NULL,
            [IsService] [bit] NULL,
            [ErrorLine] [int] NULL,
            [ErrorMessageShort] [nvarchar](1000) NOT NULL,
            [ErrorMessageFull] [nvarchar](4000) NOT NULL,
            [UserName] [sysname] NOT NULL,
            [CreatedOn] [datetime2](7) NOT NULL
        )
    ;
    DECLARE @tableHTML NVARCHAR(MAX)

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
        OUTPUT 
            inserted.ErrorNumber,
            inserted.ErrorSeverity,
            inserted.ErrorState,
            inserted.ErrorObject,
            inserted.IsService,
            inserted.ErrorLine,
            inserted.ErrorMessageShort,
            inserted.ErrorMessageFull,
            inserted.UserName,
            inserted.CreatedOn
        INTO ##tErrorLog
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
        
        SET @tableHTML =
                N'<H2>Error notification from database service.</H2>' +
                N'<table border="1">';
        
        SET @tableHTML = @tableHTML +
        N'<tr>'+
            N'<th>ErrorNumber</th>' +
            N'<th>ErrorSeverity</th>' +
            N'<th>ErrorState</th>' +
            N'<th>ErrorObject</th>' +
            N'<th>IsService</th>' +
            N'<th>ErrorLine</th>' +
            N'<th>ErrorMessageShort</th>' +
            --N'<th>ErrorMessageFull</th>' +
            N'<th>UserName</th>' +
            N'<th>CreatedOn</th>' +
        N'</tr>' +
                CAST ( ( 
                    SELECT  
                        td=REPLACE([ErrorNumber],'"',''),'',
                        td=REPLACE([ErrorSeverity],'"',''),'',
                        td=REPLACE([ErrorState],'"',''),'',
                        td=REPLACE([ErrorObject],'"',''),'',
                        td=REPLACE([IsService],'"',''),'',
                        td=REPLACE([ErrorLine],'"',''),'',
                        td=REPLACE([ErrorMessageShort],'"',''),'',
                        --td=REPLACE([ErrorMessageFull],'"',''),'',
                        td=REPLACE([UserName],'"',''),'',
                        td=REPLACE(CONVERT(VARCHAR,[CreatedOn],121),'"','') 
                    FROM ##tErrorLog 
                    FOR XML PATH('tr'), TYPE 
                ) AS NVARCHAR(MAX) ) +
        N'</table>';   
        ;

        EXEC msdb.dbo.sp_send_dbmail
            @recipients = 'aliaksandr.anisimau@outlook.com;whitebeast@tut.by',
            @subject = N'Error notification',
            @body = @tableHTML,
            @body_format = 'HTML',
            @profile_name = 'FindAndFollow.Notification Mailer',
            @importance = 'high',
            @query = 'SELECT * FROM ##tErrorLog',
            @attach_query_result_as_file = 1 ;

        IF ERROR_MESSAGE() IS NOT NULL EXECUTE [dbo].[ErrorInfoGet];

    END TRY
    BEGIN CATCH
        PRINT 'An error occurred in stored procedure ErrorLogInsert:';
        EXECUTE [dbo].[ErrorInfoGet];
        RETURN -1;
    END CATCH
    IF OBJECT_ID('tempdb..##tErrorLog')  IS NOT NULL DROP TABLE ##tErrorLog;
END;