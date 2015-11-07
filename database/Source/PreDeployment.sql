sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO
sp_configure 'Ole Automation Procedures', 1;
GO
RECONFIGURE;
GO
sp_configure 'Database Mail XPs', 1
GO
RECONFIGURE;
GO
EXECUTE msdb.dbo.sysmail_add_account_sp
		@account_name = 'FindAndFollow.Notification@gmail.com',
		@description = N'Notification account for FindAndFollow project',
		@email_address = 'FindAndFollow.Notification@gmail.com',
		@display_name = N'Notification service',
		@replyto_address = 'no-reply@gmail.com',
		@mailserver_name = 'smtp.gmail.com',
		@port = 465,
		@username = 'FindAndFollow.Notification@gmail.com',
		@password = 'VsKexibt!',
		@enable_ssl = 1;
EXECUTE msdb.dbo.sysmail_add_profile_sp
		@profile_name = 'FindAndFollow.Notification Mailer';
EXECUTE msdb.dbo.sysmail_add_profileaccount_sp
		@profile_name = 'FindAndFollow.Notification Mailer',
		@account_name = 'FindAndFollow.Notification@gmail.com',
		@sequence_number = 1;
EXECUTE msdb.dbo.sysmail_add_principalprofile_sp
		@profile_name = 'FindAndFollow.Notification Mailer',
		@principal_id = 0,
		@is_default = 1;
USE [msdb]
GO
EXEC msdb.dbo.sp_add_operator @name=N'Administrator', 
		@enabled=1, 
		@pager_days=0, 
		@email_address=N'aliaksandr.anisimau@outlook.com;whitebeast@tut.by'
GO