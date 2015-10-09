PRINT 'Populate CarParsingSettings table...'
-- av.by
IF NOT EXISTS (SELECT 1 FROM dbo.CarParsingSettings WHERE SiteUrlXPath = 'av.by')
INSERT INTO [dbo].[CarParsingSettings]
           ([CurrentId]
           ,[CarBrandXPath]
           ,[ModelXPath]
           ,[SiteUrlXPath]
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
           ,[IsCustomsClearedXPath]
           ,[IsSwapXPath]
           ,[DescriptionXPath]
           ,[PageCreatedOnXPath])
SELECT     0 AS CurrentId,
           '/html/body/div[2]/div[1]/div[2]/div/div[2]/div[1]/ul/li[2]/a' AS CarBrandXPath,
           '/html/body/div[2]/div[1]/div[2]/div/div[2]/div[1]/ul/li[3]/a' AS ModelXPath,
           'av.by' AS SiteUrlXPath,
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
           NULL AS IsCustomsClearedXPath,
           '/html/body/div[2]/div[1]/div[2]/div/div[2]/div[2]/div[1]/div[4]/h5' AS IsSwapXPath,
           '/html/body/div[2]/div[1]/div[2]/div/div[2]/div[2]/div[2]/div[3]/h4' AS DescriptionXPath,
           '/html/body/div[2]/div[1]/div[2]/div/div[2]/header/ul/li[3]' AS PageCreatedOnXPath
;
-- abw.by       
IF NOT EXISTS (SELECT 1 FROM dbo.CarParsingSettings WHERE SiteUrlXPath = 'abw.by')
INSERT INTO [dbo].[CarParsingSettings]
           ([CurrentId]
           ,[CarBrandXPath]
           ,[ModelXPath]
           ,[SiteUrlXPath]
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
           ,[IsCustomsClearedXPath]
           ,[IsSwapXPath]
           ,[DescriptionXPath]
           ,[PageCreatedOnXPath])
SELECT
           0 AS CurrentId,
           '/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/table[3]/tr[1]/td[1]/div[1]/span[1]/a[1]' AS CarBrandXPath,
           '/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/table[3]/tr[1]/td[1]/div[1]/span[1]/a[2]' AS ModelXPath,
           'abw.by' AS SiteUrlXPath,
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
           NULL AS IsCustomsClearedXPath,
           NULL AS IsSwapXPath,
           '/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/div[5]/font[1]' AS DescriptionXPath,
           '/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/p[5]' AS PageCreatedOnXPath
;
-- ab.onliner.by
IF NOT EXISTS (SELECT 1 FROM dbo.CarParsingSettings WHERE SiteUrlXPath = 'ab.onliner.by')
INSERT INTO [dbo].[CarParsingSettings]
           ([CurrentId]
           ,[CarBrandXPath]
           ,[ModelXPath]
           ,[SiteUrlXPath]
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
           ,[IsCustomsClearedXPath]
           ,[IsSwapXPath]
           ,[DescriptionXPath]
           ,[PageCreatedOnXPath])
SELECT
           0 AS CurrentId,
           '//*[@id=\"minWidth\"]/div/div[4]/div/div[2]/div[1]/div/ul/li/div/div/div/div[1]/p[1]/span[1]/strong' AS CarBrandXPath,
           '//*[@id=\"minWidth\"]/div/div[4]/div/div[2]/div[1]/div/ul/li/div/div/div/div[1]/p[1]/span[1]/strong' AS ModelXPath,
           'ab.onliner.by' AS SiteUrlXPath,
           '//*[@id=\"minWidth\"]/div/div[4]/div/div[2]/div[1]/div/ul/li/div/div/div/div[1]/div[5]/span/span/strong' AS PriceXPath,
           '//*[@id=\"minWidth\"]/div/div[4]/div/div[2]/div[1]/div/ul/li/div/div/div/div[1]/p[2]/text()[1]' AS BodyTypeXPath,
           '//*[@id=\"minWidth\"]/div/div[4]/div/div[2]/div[1]/div/ul/li/div/div/div/div[1]/p[1]/span[2]/span[1]/strong' AS ModelYearXPath,
           '//*[@id=\"minWidth\"]/div/div[4]/div/div[2]/div[1]/div/ul/li/div/div/div/div[1]/p[2]/text()[1]' AS EngineTypeXPath,
           '//*[@id=\"minWidth\"]/div/div[4]/div/div[2]/div[1]/div/ul/li/div/div/div/div[1]/p[2]/strong' AS EngineSizeXPath,
           '//*[@id=\"minWidth\"]/div/div[4]/div/div[2]/div[1]/div/ul/li/div/div/div/div[1]/p[2]/text()[1]' AS TransmissionTypeXPath,
           NULL AS DriveTypeXPath,
           NULL AS ConditionXPath,
           '//*[@id=\"minWidth\"]/div/div[4]/div/div[2]/div[1]/div/ul/li/div/div/div/div[1]/p[1]/span[2]/span[2]/strong' AS MileageXPath,
           '//*[@id=\"minWidth\"]/div/div[4]/div/div[2]/div[1]/div/ul/li/div/div/div/div[1]/p[2]/text()[1]' AS ColorXPath,
           NULL AS SellerTypeXPath,
           NULL AS IsCustomsClearedXPath,
           NULL AS IsSwapXPath,
           '//*[@id=\"minWidth\"]/div/div[4]/div/div[2]/div[1]/div/ul/li/div/div/div/div[1]/p[5]' AS DescriptionXPath,
           '//*[@id=\"minWidth\"]/div/div[4]/div/div[2]/div[1]/div/ul/li/div/div/small/text()' AS PageCreatedOnXPath
;