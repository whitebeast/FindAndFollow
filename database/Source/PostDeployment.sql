PRINT '---- Start Post-Deployment script----'
GO
USE [$(msdb)]
GO
:r .\System\SQLJob\GetDailyCurrencyRates.sql
GO

USE [$(FindAndFollow)]
GO
EXEC dbo.CurrencyMerge
GO

PRINT '---- End Post-Deployment script----'
GO