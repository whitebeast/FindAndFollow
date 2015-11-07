PRINT '---- Start Pre-Deployment script----'
GO
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
:r .\Script\PreDeployment\EmailProfile.sql
GO
PRINT '---- End Pre-Deployment script----'
GO