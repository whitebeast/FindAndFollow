PRINT 'Populate CarParsingSettings table...'
;
-- av.by
IF NOT EXISTS (SELECT 1 FROM dbo.CarParsingSettings)
INSERT INTO [dbo].[CarParsingSettings]
           ([SiteUrl]
           ,[CurrentId]
           ,[DownloadMaskURL]
           ,[CarBrandXPath]
           ,[ModelXPath]
           ,[PriceXPath]
           ,[BodyTypeXPath]
           ,[ModelYearXPath]
           ,[EngineTypeXPath]
           ,[EngineSizeXPath]
           ,[TransmissionTypeXPath]
           ,[DriveTypeXPath]
           ,[ConditionXPath]
           ,[MileageXPath]
           ,[ColorXPath]
           ,[SellerTypeXPath]
           ,[IsSwapXPath]
           ,[DescriptionXPath]
           ,[PageCreatedOnXPath])
SELECT     'av.by' AS SiteUrlXPath,
           NULL AS CurrentId,
           'http://www.av.by/public/public.php?event=View&public_id=' AS DownloadMaskURL,
           '/html/body/div[2]/div[1]/div[2]/div/div[2]/div[1]/ul/li[2]/a' AS CarBrandXPath,
           '/html/body/div[2]/div[1]/div[2]/div/div[2]/div[1]/ul/li[3]/a' AS ModelXPath,
           '/html/body/div[2]/div[1]/div[2]/div/div[2]/div[2]/div[1]/div[1]/div[1]/span' AS PriceXPath,
           '/html/body/div[2]/div[1]/div[2]/div/div[2]/div[2]/div[1]/div[2]/dl[5]/dd' AS BodyTypeXPath,
           '/html/body/div[2]/div[1]/div[2]/div/div[2]/div[2]/div[1]/div[2]/dl[1]/dd' AS ModelYearXPath,
           '/html/body/div[2]/div[1]/div[2]/div/div[2]/div[2]/div[1]/div[2]/dl[6]/dd' AS EngineTypeXPath,
           '/html/body/div[2]/div[1]/div[2]/div/div[2]/div[2]/div[1]/div[2]/dl[3]/dd/text()' AS EngineSizeXPath,
           '/html/body/div[2]/div[1]/div[2]/div/div[2]/div[2]/div[1]/div[2]/dl[9]/dd' AS TransmissionTypeXPath,
           '/html/body/div[2]/div[1]/div[2]/div/div[2]/div[2]/div[1]/div[2]/dl[11]/dd' AS DriveTypeXPath,
           '/html[1]/body[1]/div[2]/div[1]/div[2]/div[1]/div[2]/div[2]/div[2]/div[3]/ul[3]' AS ConditionXPath,
           '/html/body/div[2]/div[1]/div[2]/div/div[2]/div[2]/div[1]/div[2]/dl[2]/dd' AS MileageXPath,
           '/html/body/div[2]/div[1]/div[2]/div/div[2]/div[2]/div[1]/div[2]/dl[4]/dd' AS ColorXPath,
           '/html/body/div[2]/div[1]/div[2]/div/div[2]/div[2]/div[1]/div[3]/small/text()[2]' AS SellerTypeXPath,
           '/html/body/div[2]/div[1]/div[2]/div/div[2]/div[2]/div[1]/div[4]/h5' AS IsSwapXPath,
           '/html/body/div[2]/div[1]/div[2]/div/div[2]/div[2]/div[2]/div[3]/h4' AS DescriptionXPath,
           '/html/body/div[2]/div[1]/div[2]/div/div[2]/header/ul/li[3]' AS PageCreatedOnXPath
UNION ALL
-- abw.by-private      
SELECT     'abw.by-private' AS SiteUrl,
           NULL AS CurrentId,
           'http://www.abw.by/allpublic/sell/' AS DownloadMaskURL,
           '/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/table[3]/tr[1]/td[1]/div[1]/span[1]/a[1]' AS CarBrandXPath,
           '/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/table[3]/tr[1]/td[1]/div[1]/span[1]/a[2]' AS ModelXPath,
           '//*[@id=\"news\"]/tr[2]/td/div[2]/table/tr[11]/td[2]/div/span[2]' AS PriceXPath,
           '//*[@id=\"news\"]/tr[2]/td/div[2]/table/tr[8]/td[2]' AS BodyTypeXPath,
           '//*[@id=\"news\"]/tr[2]/td/div[2]/table/tr[1]/td[2]' AS ModelYearXPath,
           '//*[@id=\"news\"]/tr[2]/td/div[2]/table/tr[4]/td[2]' AS EngineTypeXPath,
           '//*[@id=\"news\"]/tr[2]/td/div[2]/table/tr[5]/td[2]' AS EngineSizeXPath,
           '//*[@id=\"news\"]/tr[2]/td/div[2]/table/tr[7]/td[2]' AS TransmissionTypeXPath,
           '//*[@id=\"news\"]/tr[2]/td/div[2]/table/tr[10]/td[2]' AS DriveTypeXPath,
           '/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/div[4]/table[1]/tbody[1]' AS ConditionXPath,
           '//*[@id=\"news\"]/tr[2]/td/div[2]/table/tr[3]/td[2]' AS MileageXPath,
           '//*[@id=\"news\"]/tr[2]/td/div[2]/table/tr[2]/td[2]' AS ColorXPath,
           '/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/table[2]/tr[1]/td[1]/script[2]' AS SellerTypeXPath,
           NULL AS IsSwapXPath,
           '/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/div[5]/font[1]' AS DescriptionXPath,
           '/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/p[5]' AS PageCreatedOnXPath
UNION ALL
-- abw.by-autoagency      
SELECT     'abw.by-autoagency' AS SiteUrl,
           NULL AS CurrentId,
           'http://www.abw.by/allpublic/sell/' AS DownloadMaskURL,
           '/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/table[4]/tr[1]/td[1]/div[1]/span[1]/a[1]' AS CarBrandXPath,
           '/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/table[4]/tr[1]/td[1]/div[1]/span[1]/a[2]' AS ModelXPath,
           '/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/div[2]/table[1]/tr[11]/td[2]/div[1]/span[2]' AS PriceXPath,
           '/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/div[2]/table[1]/tr[8]/td[2]' AS BodyTypeXPath,
           '/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/div[2]/table[1]/tr[1]/td[2]' AS ModelYearXPath,
           '/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/div[2]/table[1]/tr[4]/td[2]' AS EngineTypeXPath,
           '/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/div[2]/table[1]/tr[5]/td[2]' AS EngineSizeXPath,
           '/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/div[2]/table[1]/tr[7]/td[2]' AS TransmissionTypeXPath,
           '/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/div[2]/table[1]/tr[10]/td[2]' AS DriveTypeXPath,
           '/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/div[4]/table[1]/tbody[1]' AS ConditionXPath,
           '/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/div[2]/table[1]/tr[3]/td[2]' AS MileageXPath,
           '/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/div[2]/table[1]/tr[2]/td[2]' AS ColorXPath,
           '/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/table[2]/tr[1]/td[1]/script[2]' AS SellerTypeXPath,
           NULL AS IsSwapXPath,
           '/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/div[5]/font[1]' AS DescriptionXPath,
           '/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/p[5]' AS PageCreatedOnXPath
UNION ALL
-- ab.onliner.by
SELECT     'ab.onliner.by' AS SiteUrl,
           NULL AS CurrentId,
           'http://ab.onliner.by/car/' AS DownloadMaskURL,
           '//*[@id=\"minWidth\"]/div/div[4]/div/div[2]/div[1]/div/ul/li/div/div/div/div[1]/p[1]/span[1]/strong' AS CarBrandXPath,
           '//*[@id=\"minWidth\"]/div/div[4]/div/div[2]/div[1]/div/ul/li/div/div/div/div[1]/p[1]/span[1]/strong' AS ModelXPath,
           '//*[@id=\"minWidth\"]/div/div[4]/div/div[2]/div[1]/div/ul/li/div/div/div/div[1]/div[5]/span/span/strong' AS PriceXPath,
           '//*[@id=\"minWidth\"]/div/div[4]/div/div[2]/div[1]/div/ul/li/div/div/div/div[1]/p[2]/text()[1]' AS BodyTypeXPath,
           '//*[@id=\"minWidth\"]/div/div[4]/div/div[2]/div[1]/div/ul/li/div/div/div/div[1]/p[1]/span[2]/span[1]/strong' AS ModelYearXPath,
           '//*[@id=\"minWidth\"]/div/div[4]/div/div[2]/div[1]/div/ul/li/div/div/div/div[1]/p[2]/text()[1]' AS EngineTypeXPath,
           '//*[@id=\"minWidth\"]/div/div[4]/div/div[2]/div[1]/div/ul/li/div/div/div/div[1]/p[2]/strong' AS EngineSizeXPath,
           '//*[@id=\"minWidth\"]/div/div[4]/div/div[2]/div[1]/div/ul/li/div/div/div/div[1]/p[2]/text()[2]' AS TransmissionTypeXPath,
           '//*[@id=\"minWidth\"]/div/div[4]/div/div[2]/div[1]/div/ul/li/div/div/div/div[1]/p[2]/text()[2]' AS DriveTypeXPath,
           '//*[@id=\"minWidth\"]/div/div[4]/div/div[2]/div[1]/div/ul/li/div/div/div/div[1]/div[3]' AS ConditionXPath,
           '//*[@id=\"minWidth\"]/div/div[4]/div/div[2]/div[1]/div/ul/li/div/div/div/div[1]/p[1]/span[2]/span[2]/strong' AS MileageXPath,
           '//*[@id=\"minWidth\"]/div/div[4]/div/div[2]/div[1]/div/ul/li/div/div/div/div[1]/p[2]/text()[1]' AS ColorXPath,
           NULL AS SellerTypeXPath,
           '//*[@id=\"minWidth\"]/div/div[4]/div/div[1]/div[2]/strong[2]' AS IsSwapXPath,
           '/html[1]/body[1]/div[1]/div[1]/div[4]/div[1]/div[2]/div[1]/div[1]/ul[1]/li[1]/div[1]/div[1]/div[1]/div[1]/p[4]/p[1]' AS DescriptionXPath,
           '//*[@id=\"minWidth\"]/div/div[4]/div/div[2]/div[1]/div/ul/li/div/div/small/text()' AS PageCreatedOnXPath
;