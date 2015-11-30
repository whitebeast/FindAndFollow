CREATE PROCEDURE [dbo].[CarParsingSettingsGet]
    (
        @pSiteUrl   NVARCHAR(1000) 
    )
AS
BEGIN
    SELECT  
            DownloadMaskURL,
            CarBrandXPath,    
            ModelXPath,           
            CityXPath,            
            CountryXPath,
            PriceXPath,           
            BodyTypeXPath,        
            ModelYearXPath,       
            EngineTypeXPath,      
            EngineSizeXPath,     
            TransmissionTypeXPath,
            DriveTypeXPath,       
            ConditionXPath,       
            MileageXPath,         
            ColorXPath,           
            SellerTypeXPath,      
            IsSwapXPath,          
            DescriptionXPath,     
            OwnerPhoneXPath,		
            CarImagesXPath,     
            OptionListXPath,  
            PageCreatedOnXPath,
            MainPageUrlsXPath,            
            MainPageUrlsXPathNodeValue,     
            MainPageUrlsXPathAttributeValue,
            MainPageUrlsXPathRemoveText,    
            IsContentExistXpath,            
            CarImagesNodeValue,             
            CarImagesAttributeValue        
    FROM    dbo.CarParsingSettings
    WHERE   SiteURL = @pSiteUrl
    ;
END
