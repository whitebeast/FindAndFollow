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

USE [$(FindAndFollow)]
GO
DECLARE @DateBegin  DATE,
	    @DateEnd    DATE = GETDATE()
;	        
SELECT  @DateBegin = DATEADD(DAY,1-DAY(@DateEnd),@DateEnd)
;
EXEC [CurrencyRateGet] 
     @pCurrencyCode = 'USD',
     @pFromDate     = @DateBegin,
     @pToDate       = @DateEnd
;
EXEC [CurrencyRateGet] 
     @pCurrencyCode = 'EUR',
     @pFromDate     = @DateBegin,
     @pToDate       = @DateEnd
;
EXEC [CurrencyRateGet] 
     @pCurrencyCode = 'RUB',
     @pFromDate     = @DateBegin,
     @pToDate       = @DateEnd
;               
PRINT '---- End Post-Deployment script----'
GO