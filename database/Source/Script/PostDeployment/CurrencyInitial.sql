PRINT 'Running CurrencyMerge sproc...'
EXEC dbo.CurrencyMerge

PRINT 'Populating CurrencyRate table...'
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
