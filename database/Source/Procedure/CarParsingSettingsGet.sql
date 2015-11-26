﻿CREATE PROCEDURE [dbo].[CarParsingSettingsGet]
    (
        @pSiteUrl   NVARCHAR(1000) 
    )
AS
BEGIN
    SELECT  
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
            DownloadMaskURL  
    FROM    dbo.CarParsingSettings
    WHERE   SiteURL = @pSiteUrl
    ;
END
