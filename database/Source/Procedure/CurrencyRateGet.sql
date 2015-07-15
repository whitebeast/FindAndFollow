CREATE PROCEDURE dbo.CurrencyRateGet 
     @pCurrencyCode             varchar(3) = 'USD'
    ,@pFromDate                 date = NULL
    ,@pToDate                   date = NULL
    ,@pDebug	                bit = 0

AS
BEGIN
	SET NOCOUNT ON;

	DECLARE	 @ErrCode           Int
		    ,@Handle            Int
		    ,@URL               SysName
            ,@xml               nvarchar(max)
            ,@ErrorMessage      varchar(2000)
            ,@CurrencyId        int
            ,@RowCnt            int
    ;
	
    if DATEDIFF(day,@pFromDate,@pToDate) > 365 raiserror('Time interval should be less than one year.',18,1);

    if coalesce(@pToDate,@pFromDate) is null begin
    select   @pFromDate = current_timestamp   
            ,@pToDate = current_timestamp
    end;
    
    select  @CurrencyId = max(CurrencyId)
    from    dbo.Currency
    where   CharCode = @pCurrencyCode;

    if @CurrencyId is null begin
        raiserror ('Entered CurrencyKey did not found. Please use correct CurrencyKey.',18,1);
        return;
    end;

    select @url = 'http://www.nbrb.by/Services/XmlExRatesDyn.aspx?curId=' + cast(@CurrencyId as varchar) + '&fromDate=' + cast(@pFromDate as varchar) + '&toDate=' + cast(@pToDate as varchar) + '';

    EXEC @ErrCode = dbo.HTTPCall @URL, @XML out   IF (@ErrCode != 0) RETURN @@Error;
	EXEC @ErrCode = sys.sp_xml_preparedocument @Handle OUT, @XML   IF  (@ErrCode != 0) BEGIN RAISERROR('Error parsing XML',18,1) RETURN @@Error END;

    if @pDebug = 1 select @XML;
	exec sp_xml_preparedocument  @Handle output, @XML;

    MERGE [dbo].[CurrencyRate] AS target
    USING 
        (
	        SELECT	@CurrencyId as CurrencyId,
                    RateDate,
                    Rate
	        FROM	OpenXML(@Handle,'//Currency/Record')
	        WITH	( 
                        RateDate        date    './@Date',
                        Rate            money   './Rate' 
                    )
            ) as source
    on target.CurrencyId = source.CurrencyId and target.RateDate = source.RateDate
    when matched 
    then update set
                Rate = source.Rate
    when not matched by target then insert 
        (
                CurrencyId
               ,RateDate
               ,Rate
        )
    values (
                source.CurrencyId
               ,source.RateDate
               ,source.Rate
    )
    --when not matched by source then delete
    ;
    
	exec sp_xml_removedocument @Handle;
END
GO

/*

EXEC	[dbo].[CurrencyRateGet]
        @pCurrencyCode = 'USD',
		@pFromDate = '2014-01-01',
        @pToDate = '2014-02-19',
        @pDebug = 0
*/