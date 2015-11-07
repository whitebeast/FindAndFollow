CREATE PROCEDURE [dbo].[CarParsingSettingsGet]
    (
        @pSiteUrl   NVARCHAR(1000) 
    )
AS
BEGIN
    SELECT  CarBrandXPath, 
            ModelXPath, 
            ModelYearXPath, 
            CityXPath,
            PriceXPath, 
            MileageXPath, 
            EngineSizeXPath,	
            ColorXPath, 
            BodyTypeXPath, 
            EngineTypeXPath, 
            TransmissionTypeXPath, 
            DriveTypeXPath,		
            DescriptionXPath, 
			OwnerPhoneXPath,
            PageCreatedOnXPath, 
            SellerTypeXPath, 
            ConditionXPath, 
            IsSwapXPath
    FROM    dbo.CarParsingSettings
    WHERE   SiteURL = @pSiteUrl
    ;
END
