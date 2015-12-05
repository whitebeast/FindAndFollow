PRINT 'Populate CarParsingSettings table...'
;
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
           ,[PageCreatedOnXPath]
           ,[CityXPath]
           ,[OwnerPhoneXPath]
           ,[CarImagesXPath]
           ,[OptionListXPath]
           ,[MainPageUrlsXPath]              
           ,[MainPageUrlsXPathNodeValue]     
           ,[MainPageUrlsXPathAttributeValue]
           ,[MainPageUrlsXPathRemoveText]    
           ,[IsContentExistXpath]            
           ,[CarImagesNodeValue]             
           ,[CarImagesAttributeValue]        
           ,[CountryXPath]
           ,[LastUploadDate]
           )
-- av.by
SELECT     'av.by' AS SiteUrlXPath,
           10708341 AS CurrentId,
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
           '//div[contains(@class,''b-card-message'')]/p' AS DescriptionXPath,
           '/html/body/div[2]/div[1]/div[2]/div/div[2]/header/ul/li[3]' AS PageCreatedOnXPath,
           '/html/body/div[2]/div[1]/div[2]/div/div[2]/div[2]/div[1]/div[3]' AS CityXPath,
           '/html/body/div[2]/div[1]/div[2]/div/div[2]/div[2]/div[1]/div[3]/ul' AS OwnerPhoneXPath,
           '/html[1]/body[1]/div[2]/div[1]/div[2]/div[1]/div[2]/div[2]/div[2]/div[1]/div[1]' AS CarImagesXPath,
           '//div[contains(@class,''b-card-options'')]' AS OptionListXPath,
           '/html/body/div[2]/div[1]/div[2]/div/div[2]/div[3]' AS MainPageUrlsXPath,
           './/div[@class=''b-listing-item-title'']//a[@href]' AS MainPageUrlsXPathNodeValue,
           'href' AS MainPageUrlsXPathAttributeValue,
           'public.php?event=View&public_id=' AS MainPageUrlsXPathRemoveText,
           '/html[1]/body[1]/div[2]/div[1]/div[2]/div[1]/div[2]/div[1]' AS IsContentExistXpath,
           'a[@href]' AS CarImagesNodeValue,
           'href' AS CarImagesAttributeValue,
           '/html/body/div[2]/div[1]/div[2]/div/div[2]/div[2]/div[1]/div[3]' AS CountryXPath,
           '2015-12-05' AS LastUploadDate
UNION ALL
-- abw.by-private      
SELECT     'abw.by-private' AS SiteUrl,
           8346113 AS CurrentId,
           'http://www.abw.by/allpublic/sell/' AS DownloadMaskURL,
           '//*[@id="news"]/tr[2]/td/table[3]/tr[1]/td/div/div[1]/a[1]' AS CarBrandXPath,
           '//*[@id="news"]/tr[2]/td/table[3]/tr[1]/td/div/div[1]/a[2]' AS ModelXPath,
           '//*[@id="news"]/tr[2]/td/table[3]/tr[1]/td/div/div[1]/span[1]/span[2]' AS PriceXPath,
           '//*[@id=\"news\"]/tr[2]/td/div[2]/table/tr[8]/td[2]' AS BodyTypeXPath,
           '//*[@id=\"news\"]/tr[2]/td/div[2]/table/tr[1]/td[2]' AS ModelYearXPath,
           '//*[@id=\"news\"]/tr[2]/td/div[2]/table/tr[4]/td[2]' AS EngineTypeXPath,
           '//*[@id=\"news\"]/tr[2]/td/div[2]/table/tr[5]/td[2]' AS EngineSizeXPath,
           '//*[@id=\"news\"]/tr[2]/td/div[2]/table/tr[7]/td[2]' AS TransmissionTypeXPath,
           '//*[@id=\"news\"]/tr[2]/td/div[2]/table/tr[10]/td[2]' AS DriveTypeXPath,
           '/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/div[2]/table[1]/tr[11]/td[2]' AS ConditionXPath,
           '//*[@id=\"news\"]/tr[2]/td/div[2]/table/tr[3]/td[2]' AS MileageXPath,
           '//*[@id=\"news\"]/tr[2]/td/div[2]/table/tr[2]/td[2]' AS ColorXPath,
           '/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]/table[2]/tr[1]/td[1]/script[2]' AS SellerTypeXPath,
           NULL AS IsSwapXPath,
           '//*[@id="news"]/tr[2]/td/div[5]/font' AS DescriptionXPath,
           '//p[@align="right"]' AS PageCreatedOnXPath,
           '/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]' AS CityXPath,
           NULL AS OwnerPhoneXPath,
           '//*[@id="news"]/tr[2]/td/div[2]/div[3]' AS CarImagesXPath,
           '//*[@id="news"]/tr[2]/td/table[4]/tbody' AS OptionListXPath,
           '//*[@id="advertsListContainer"]' AS MainPageUrlsXPath,            
           './/div[@class=''a_m_o'']//a[@href]' AS MainPageUrlsXPathNodeValue,     
           'href' AS MainPageUrlsXPathAttributeValue,
           '/allpublic/sell/' AS MainPageUrlsXPathRemoveText,    
           '/html/body/div/h1' AS IsContentExistXpath,            
           './/a[@rel=''group'']' AS CarImagesNodeValue,             
           'href' AS CarImagesAttributeValue,
           '/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]' AS CountryXPath,
           '2015-12-05' AS LastUploadDate
UNION ALL
-- abw.by-autoagency      
SELECT     'abw.by-autoagency' AS SiteUrl,
           8346113 AS CurrentId,
           'http://www.abw.by/allpublic/sell/' AS DownloadMaskURL,
           '///*[@id="news"]/tr[2]/td/table[4]/tr[1]/td/div/div[1]/a[1]' AS CarBrandXPath,
           '//*[@id="news"]/tr[2]/td/table[4]/tr[1]/td/div/div[1]/a[2]' AS ModelXPath,
           '//*[@id="news"]/tr[2]/td/table[4]/tr[1]/td/div/div[1]/span[1]/span[2]' AS PriceXPath,
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
           '//p[@align="right"]' AS PageCreatedOnXPath,
           '/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]' AS CityXPath,
           NULL AS OwnerPhoneXPath,
           '//*[@id="news"]/tr[2]/td/div[2]/div[3]' AS CarImagesXPath,
           '//*[@id="news"]/tr[2]/td/table[5]/tbody' AS OptionListXPath,
           '//*[@id="advertsListContainer"]' AS MainPageUrlsXPath,            
           './/div[@class=''a_m_o'']//a[@href]' AS MainPageUrlsXPathNodeValue,     
           'href' AS MainPageUrlsXPathAttributeValue,
           '/allpublic/sell/' AS MainPageUrlsXPathRemoveText,    
           '/html/body/div/h1' AS IsContentExistXpath,            
           './/a[@rel=''group'']' AS CarImagesNodeValue,             
           'href' AS CarImagesAttributeValue,
           '/html[1]/body[1]/table[1]/tr[1]/td[2]/table[1]/tr[2]/td[1]' AS CountryXPath,
           '2015-12-05' AS LastUploadDate
UNION ALL
-- ab.onliner.by
SELECT     'ab.onliner.by' AS SiteUrl,
           2339068 AS CurrentId,
           'http://ab.onliner.by/car/' AS DownloadMaskURL,
           '//*[@id="minWidth"]/div/div[4]/div/div[2]/div[1]/div/ul/li/div/div/div/div[1]/p[1]/span[1]/strong' AS CarBrandXPath,
           '//*[@id="minWidth"]/div/div[4]/div/div[2]/div[1]/div/ul/li/div/div/div/div[1]/p[1]/span[1]/strong' AS ModelXPath,
           '//*[@id="minWidth"]/div/div[4]/div/div[2]/div[1]/div/ul/li/div/div/div/div[1]/div[5]/span/span/strong' AS PriceXPath,
           '//*[@id="minWidth"]/div/div[4]/div/div[2]/div[1]/div/ul/li/div/div/div/div[1]/p[2]/text()[1]' AS BodyTypeXPath,
           '//*[@id="minWidth"]/div/div[4]/div/div[2]/div[1]/div/ul/li/div/div/div/div[1]/p[1]/span[2]/span[1]/strong' AS ModelYearXPath,
           '//*[@id="minWidth"]/div/div[4]/div/div[2]/div[1]/div/ul/li/div/div/div/div[1]/p[2]/text()[1]' AS EngineTypeXPath,
           '//*[@id="minWidth"]/div/div[4]/div/div[2]/div[1]/div/ul/li/div/div/div/div[1]/p[2]/strong' AS EngineSizeXPath,
           '//*[@id="minWidth"]/div/div[4]/div/div[2]/div[1]/div/ul/li/div/div/div/div[1]/p[2]/text()[2]' AS TransmissionTypeXPath,
           '//*[@id="minWidth"]/div/div[4]/div/div[2]/div[1]/div/ul/li/div/div/div/div[1]/p[2]/text()[2]' AS DriveTypeXPath,
           '/html[1]/body[1]/div[1]/div[1]/div[4]/div[1]/div[2]/div[1]/div[1]/ul[1]/li[1]/div[1]/div[1]/div[1]/div[1]/p[1]/span[2]/span[2]' AS ConditionXPath,
           '//*[@id="minWidth"]/div/div[4]/div/div[2]/div[1]/div/ul/li/div/div/div/div[1]/p[1]/span[2]/span[2]/strong' AS MileageXPath,
           '//*[@id="minWidth"]/div/div[4]/div/div[2]/div[1]/div/ul/li/div/div/div/div[1]/p[2]/text()[1]' AS ColorXPath,
           NULL AS SellerTypeXPath,
           '//*[@id="minWidth"]/div/div[4]/div/div[1]/div[2]/strong[2]' AS IsSwapXPath,
           '/html[1]/body[1]/div[1]/div[1]/div[4]/div[1]/div[2]/div[1]/div[1]/ul[1]/li[1]/div[1]/div[1]/div[1]/div[1]/p[4]/p[1]' AS DescriptionXPath,
           '//*[@id="minWidth"]/div/div[4]/div/div[2]/div[1]/div/ul/li/div/div/small/text()' AS PageCreatedOnXPath,
           '/html[1]/body[1]/div[1]/div[1]/div[4]/div[1]/div[2]/div[1]/div[1]/ul[1]/li[1]/div[1]/div[1]/div[1]/div[1]/p[3]' AS CityXPath,
           '/html[1]/body[1]/div[1]/div[1]/div[4]/div[1]/div[2]/div[1]/div[1]/ul[1]/li[1]/div[1]/div[1]/div[1]/div[2]/div[1]' AS OwnerPhoneXPath,
           '/html[1]/body[1]/div[1]/div[1]/div[4]/div[1]/div[2]/div[1]/div[1]/ul[1]/li[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/div[1]/table[1]/tr[1]' AS CarImagesXPath,
           '/html[1]/body[1]/div[1]/div[1]/div[4]/div[1]/div[2]/div[1]/div[1]/ul[1]/li[1]/div[1]/div[1]/div[1]/div[1]/div[3]' AS OptionListXPath,
           NULL AS MainPageUrlsXPath,            
           NULL AS MainPageUrlsXPathNodeValue,     
           NULL AS MainPageUrlsXPathAttributeValue,
           NULL AS MainPageUrlsXPathRemoveText,    
           NULL AS IsContentExistXpath,            
           './/img[@src]' AS CarImagesNodeValue,             
           'src' AS CarImagesAttributeValue,
           '/html[1]/body[1]/div[1]/div[1]/div[4]/div[1]/div[2]/div[1]/div[1]/ul[1]/li[1]/div[1]/div[1]/div[1]/div[1]/p[3]' AS CountryXPath,
           '2015-12-05' AS LastUploadDate
;

