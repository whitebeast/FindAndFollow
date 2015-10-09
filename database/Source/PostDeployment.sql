PRINT '---- Start Post-Deployment script----'
GO
USE [$(msdb)]
GO
:r .\System\SQLJob\GetDailyCurrencyRates.sql
GO
USE [$(FindAndFollow)]
GO
:r .\Script\PostDeployment\CurrencyInitial.sql 
GO
:r .\Script\PostDeployment\CarParsingSettingsInitial.sql 
GO
PRINT '---- End Post-Deployment script----'
GO
