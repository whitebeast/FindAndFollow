CREATE PROCEDURE [dbo].[CurrencyMerge] 
    (
	    @pDebug                 bit = 0
    ) 
AS 
BEGIN
set nocount on;
	DECLARE	 @ErrCode           Int
		    ,@Handle            Int
		    ,@URL               SysName
            ,@xml               nvarchar(max)
    ;
	SELECT  @URL = 'http://www.nbrb.by/Services/XmlExRatesRef.aspx';

    EXEC @ErrCode = dbo.HTTPCall @URL, @XML out   IF (@ErrCode != 0) RETURN @@Error;
	EXEC @ErrCode = sys.sp_xml_preparedocument @Handle OUT, @XML   IF  (@ErrCode != 0) BEGIN RAISERROR('Error parsing XML',18,1) RETURN @@Error END;

    MERGE [dbo].[Currency] AS target
    USING 
        (
            SELECT
                    0 as CurrencyId
                   ,'BYR' as CharCode
                   ,'Belorussian Ruble' as EnglishName
            UNION ALL
            SELECT	
                    CurrencyId
                   ,CharCode
                   ,EnglishName
	        FROM	OpenXML(@Handle,'//DailyExRates/Currency')
	        WITH	( 
                        CurrencyId      int             './@Id',
                        CharCode        varchar(3)      './CharCode',
                        EnglishName     varchar(255)    './EnglishName'
                    )
		) as source
    on target.CurrencyId = source.CurrencyId
    when matched 
    then update set
                CharCode = source.CharCode
               ,EnglishName = source.EnglishName
    when not matched by target then insert 
        (
                CurrencyId
               ,CharCode
               ,EnglishName
		)
    values 
		(
                source.CurrencyId
               ,source.CharCode
               ,source.EnglishName
		)
    when not matched by source then delete;

    if @pDebug = 1 select @xml;
        
	EXEC @ErrCode = sys.sp_xml_removedocument @Handle;
END
