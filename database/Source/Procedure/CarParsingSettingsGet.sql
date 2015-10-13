CREATE PROCEDURE [dbo].[CarParsingSettingsGet]
    (
        @pSiteUrl   NVARCHAR(1000) 
    )
AS
BEGIN
    SELECT  CarBrandXPath, 
            ModelXPath, 
            ModelYearXPath, 
            PriceXPath, 
            MileageXPath, 
            EngineSizeXPath,	
            ColorXPath, 
            BodyTypeXPath, 
            EngineTypeXPath, 
            TransmissionTypeXPath, 
            DriveTypeXPath,		
            DescriptionXPath, 
            PageCreatedOnXPath, 
            SellerTypeXPath, 
            ConditionXPath, 
            IsSwapXPath
    FROM    dbo.CarParsingSettings
    WHERE   SiteURL = @pSiteUrl
    ;
END
