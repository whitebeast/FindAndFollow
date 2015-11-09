IF NOT EXISTS (SELECT 1 FROM msdb.dbo.sysmail_account AS sa WHERE NAME = 'FindAndFollow.Notification@gmail.com') BEGIN 
    PRINT 'Configuring Email account';
    EXECUTE msdb.dbo.sysmail_add_account_sp
            @account_name = 'FindAndFollow.Notification@gmail.com',
            @email_address = 'FindAndFollow.Notification@gmail.com',
            @display_name = N'Notification service',
            @description = N'Notification account for FindAndFollow project',
            @mailserver_name = 'smtp.gmail.com',
            @port = 587,
            @username = 'FindAndFollow.Notification@gmail.com',
            @password = 'VsKexibt!',
            @use_default_credentials = 0,
            @enable_ssl = 1
END;    

IF NOT EXISTS (SELECT 1 FROM msdb.dbo.sysmail_profile AS sp WHERE NAME = 'FindAndFollow.Notification Mailer') BEGIN
    PRINT 'Configuring Email profile';	
    EXECUTE msdb.dbo.sysmail_add_profile_sp
            @profile_name = 'FindAndFollow.Notification Mailer'
    EXECUTE msdb.dbo.sysmail_add_profileaccount_sp
            @profile_name = 'FindAndFollow.Notification Mailer',
            @account_name = 'FindAndFollow.Notification@gmail.com',
            @sequence_number = 1;
    EXECUTE msdb.dbo.sysmail_add_principalprofile_sp
            @profile_name = 'FindAndFollow.Notification Mailer',
            @principal_id = 0,
            @is_default = 1;
END;

IF NOT EXISTS (SELECT 1 FROM msdb.dbo.sysoperators AS s WHERE s.name = 'Administrator') BEGIN
    PRINT 'Configuring Email operator'
    EXEC msdb.dbo.sp_add_operator @name=N'Administrator', 
            @enabled=1, 
            @pager_days=0, 
            @email_address=N'aliaksandr.anisimau@outlook.com;whitebeast@tut.by'
END;    
        
/*
DECLARE @AccountName VARCHAR(100) = 'FindAndFollow.Notification@gmail.com',
        @ProfileName VARCHAR(100) = 'FindAndFollow.Notification Mailer';

IF EXISTS (SELECT 1 FROM msdb.dbo.sysmail_account AS sa WHERE NAME = @AccountName) BEGIN
    PRINT 'Deleting Email account';                                                                                   	
    EXEC msdb.dbo.sysmail_delete_account_sp 
        @account_name = @AccountName
END;

IF EXISTS (SELECT * FROM msdb.dbo.sysmail_profile AS sp WHERE NAME = @ProfileName) BEGIN
    PRINT 'Deleting Email profile';
    EXEC msdb.dbo.sysmail_delete_profileaccount_sp 
        @profile_name = @ProfileName
        
    EXEC msdb.dbo.sysmail_delete_profile_sp
        @profile_name = @ProfileName
END;    

IF EXISTS (SELECT 1 FROM msdb.dbo.sysoperators AS s WHERE s.name = 'Administrator') BEGIN
    PRINT 'Deleting Email operator'
    EXEC msdb.dbo.sp_delete_operator @name = 'Administrator' ;
END;
 */