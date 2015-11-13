CREATE PROCEDURE [dbo].[CarParsingSettingsGet]
    (
        @pSiteUrl   NVARCHAR(1000) 
    )
AS
BEGIN
    SELECT  
            CarBrandXPath,    
            ModelXPath,           
            CityXPath,            
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
            PageCreatedOnXPath   
    FROM    dbo.CarParsingSettings
    WHERE   SiteURL = @pSiteUrl
    ;
END
