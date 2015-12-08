CREATE PROCEDURE [dbo].[CarParsingMergeCar]
(
    @pDebug BIT = 0
)
AS
BEGIN
    SET NOCOUNT ON
    ;
    IF OBJECT_ID('tempdb..#CarParsing') IS NOT NULL DROP TABLE #CarParsing
    ;
    IF OBJECT_ID('tempdb..#Car') IS NOT NULL DROP TABLE #Car
    ;
    CREATE TABLE #Car
        (
            CarId           INT,
            OwnerPhone      NVARCHAR(300),
            OriginalURL     NVARCHAR(1000),
            Price           MONEY,
            Mileage         INT,
            SellerType      TINYINT,
            Description     NVARCHAR(4000),
            PageCreatedOn   DATETIME2
        )
    ;
    DECLARE @XML                XML,
            @ErrorNumber        INT             = 0, 
            @ErrorSeverity      INT             = 1,
            @ErrorState         INT             = 16,
            @ErrorObject        NVARCHAR(126)   = OBJECT_NAME(@@PROCID),
            @ErrorMessageShort  NVARCHAR(1000),
            @ErrorMessageFull   NVARCHAR(MAX)
    ;
    BEGIN TRY
        BEGIN TRANSACTION
        
        DELETE FROM dbo.CarParsing WHERE PageStatusId != 1;
        ;
        -- load and parse data
        SELECT  
                CASE 
                    WHEN COALESCE(cb.CarBrandId,cbm.CarBrandId) IS NULL THEN 'CarBrand Error'
                    WHEN COALESCE(cm.CarModelId,cmm.CarModelId) IS NULL THEN 'CarModel Error' 
                    WHEN s.SiteId                               IS NULL THEN 'Site Error'
                    WHEN c.CityId                               IS NULL THEN 'City Error'
                    WHEN cn.CountryId                           IS NULL THEN 'Country Error'
                    WHEN pl.PlaceId                             IS NULL THEN 'Place Error'
                    WHEN col.ColorId                            IS NULL THEN 'Color Error'
                    WHEN cp.CarBrand                            IS NULL THEN 'Original CarBrand Error'
                    WHEN cp.Model                               IS NULL THEN 'Original CarModel Error'
                    WHEN cp.ModelYear                           IS NULL THEN 'Original ModelYear Error'
                    WHEN cp.Color                               IS NULL THEN 'Original Color Error'
                    WHEN cp.EngineType                          IS NULL THEN 'Original EngineType Error'
                    WHEN cp.EngineSize                          IS NULL THEN 'Original EngineSize Error'
                    WHEN cp.BodyType                            IS NULL THEN 'Original BodyType Error'
                    --WHEN cp.Mileage                             IS NULL THEN 'Original Mileage Error'
                    WHEN cp.Condition                           IS NULL THEN 'Original Condition Error'
                    WHEN cp.TransmissionType                    IS NULL THEN 'Original TransmissionType Error'
                    --WHEN cp.DriveType                           IS NULL THEN 'Original DriveType Error'
                    WHEN cp.Price                               IS NULL THEN 'Original Price Error'
                    --WHEN cp.OwnerPhone                          IS NULL THEN 'Original OwnerPhone Error'
                    WHEN cp.City                                IS NULL THEN 'Original City Error'
                    WHEN cp.Country                             IS NULL THEN 'Original Country Error'
                    ELSE NULL
                END AS ErrorType,
                cp.CarParsingId,
                COALESCE(cb.CarBrandId,cbm.CarBrandId) AS CarBrandId,
                COALESCE(cb.Name,cb2.Name) AS CarBrand,
                cp.CarBrand AS OriginalCarBrand,
                COALESCE(cm.CarModelId,cmm.CarModelId) AS CarModelId,
                COALESCE(cm.Name,cm2.Name) AS Model,
                cp.Model AS OriginalCarModel,
                s.SiteId,
                cp.SiteId AS SiteURL,
                c.CityId,
                cp.City,
                cn.CountryId,
                cp.Country,
                pl.PlaceId,
                cp.Price,
                cp.BodyType,
                cp.ModelYear,
                cp.EngineType,
                cp.EngineSize,
                cp.TransmissionType,
                cp.DriveType,
                cp.Condition,
                cp.Mileage,
                col.ColorId,
                cp.Color,
                cp.SellerType,
                cp.IsSwap,
                cp.Description,
                cp.OwnerPhone,
                cp.CarImages,
                cp.OptionList,
                cp.OriginalURL,
                cp.PageCreatedOn
        INTO    #CarParsing
        FROM    (
                    SELECT  cp.CarParsingId,
                            cp.CarBrand,
                            cp.Model,
                            cp.SiteId,
                            cp.City,
                            cp.Country,
                            cp.Price,
                            dbo.MappingType('BodyType',cp.BodyType) AS BodyType,
                            cp.ModelYear,
                            dbo.MappingType('EngineType',cp.EngineType) AS EngineType,
                            cp.EngineSize,
                            dbo.MappingType('TransmissionType',cp.TransmissionType) AS TransmissionType,
                            dbo.MappingType('DriveType',cp.DriveType) AS DriveType,
                            dbo.MappingType('Condition',cp.Condition) AS Condition,
                            cp.Mileage,
                            cp.Color,
                            dbo.MappingType('SellerType',cp.SellerType) AS SellerType,
                            cp.IsSwap,
                            cp.Description,
                            cp.OwnerPhone,
                            cp.CarImages,
                            cp.OptionList,
                            cp.SiteUrl AS OriginalURL,
                            cp.PageCreatedOn
                    FROM    dbo.CarParsing cp
                    WHERE cp.PageStatusId = 1 -- Downloaded page (default)    	
        ) AS cp
        LEFT JOIN dbo.CarBrand AS cb ON cb.Name = cp.CarBrand
        LEFT JOIN dbo.CarBrandMapping AS cbm 
            ON  cb.CarBrandId IS NULL
            AND cp.CarBrand LIKE cbm.BrandMask
        LEFT JOIN dbo.CarBrand AS cb2 ON cb2.CarBrandId = cbm.CarBrandId
        LEFT JOIN dbo.CarModel AS cm ON cm.Name = cp.Model AND cm.CarBrandId = COALESCE(cb.CarBrandId,cb2.CarBrandId)
        LEFT JOIN dbo.[Site] AS s ON s.SiteUrl = cp.SiteId
        LEFT JOIN dbo.Color AS col ON col.Name = cp.Color
        LEFT JOIN dbo.City AS c ON c.Name = cp.City
        LEFT JOIN dbo.Country AS cn ON cn.Name = cp.Country
        LEFT JOIN dbo.Place AS pl ON pl.CityId = c.CityId AND pl.CountryId = cn.CountryId
        LEFT JOIN dbo.CarModelMapping AS cmm 
            ON  cm.CarModelId IS NULL 
            AND cp.Model LIKE cmm.ModelMask 
            AND cp.Model NOT LIKE cmm.ModelNotMask 
            AND cmm.CarBrandId = cb.CarBrandId
        LEFT JOIN dbo.CarModel AS cm2 ON cm2.CarModelId = cmm.CarModelId
        WHERE NOT EXISTS (SELECT 1 FROM dbo.CarBrandException AS cbe WHERE cp.CarBrand LIKE cbe.ExceptionMask)
        ;

        -- write wrong data info to Log table
        IF EXISTS (SELECT 1 FROM #CarParsing WHERE ErrorType IS NOT NULL) BEGIN
            SELECT @XML = (
                SELECT  cp.ErrorType,
                        cp.CarParsingId,
                        cp.CarBrand,
                        cp.OriginalCarBrand,
                        cp.Model,
                        cp.OriginalCarModel,
                        cp.SiteId,
                        cp.City,
                        cp.Country,
                        cp.Price,
                        cp.BodyType,
                        cp.ModelYear,
                        cp.EngineType,
                        cp.EngineSize,
                        cp.TransmissionType,
                        cp.DriveType,
                        cp.Condition,
                        cp.Mileage,
                        cp.Color,
                        cp.SellerType,
                        cp.IsSwap,
                        cp.Description,
                        cp.OwnerPhone,
                        cp.CarImages,
                        cp.OptionList,
                        cp.OriginalURL,
                        cp.PageCreatedOn
                FROM #CarParsing AS cp 
                WHERE cp.ErrorType IS NOT NULL
                FOR XML PATH, ROOT
            )
            ;
            SELECT  @ErrorMessageShort = 'Wrong data in CarParsing table',
                    @ErrorMessageFull = dbo.XMLToJSON(@XML)
            ;
            EXECUTE dbo.ErrorLogInsert
                        @pErrorNumber = @ErrorNumber, 
                        @pErrorSeverity = @ErrorSeverity,
                        @pErrorState = @ErrorState,
                        @pErrorObject = @ErrorObject,
                        @pErrorMessageShort = @ErrorMessageShort,
                        @pErrorMessageFull = @ErrorMessageFull,
                        @pSendEmail = 1
            ;
            IF @pDebug = 1 BEGIN
                PRINT 'Merge errors:' + CHAR(10) + @ErrorMessageFull;
            END
            ;
        END
        ;
        -- merge with Car table
        MERGE dbo.Car AS target
        USING 
            (
                SELECT  cp.CarModelId,
                        cp.SiteId,
                        cp.PlaceId,
                        cp.Price,
                        cp.BodyType,
                        cp.ModelYear,
                        cp.EngineType,
                        cp.EngineSize,
                        cp.TransmissionType,
                        cp.DriveType,
                        cp.Condition,
                        cp.Mileage,
                        cp.ColorId,
                        cp.SellerType,
                        cp.IsSwap,
                        cp.Description,
                        cp.OriginalURL,
                        cp.PageCreatedOn,
                        cp.CarImages,
                        cp.OptionList,
                        cp.OriginalCarBrand,
                        cp.OriginalCarModel
                FROM #CarParsing AS cp  
                WHERE cp.ErrorType IS NULL        
               ) AS source
        ON target.OriginalURL = source.OriginalURL 
        WHEN MATCHED AND target.PageCreatedOn <> source.PageCreatedOn
            THEN 
                UPDATE 
                SET
                    CarModelId = source.CarModelId,
                    SiteId = source.SiteId,
                    PlaceId = source.PlaceId,
                    Price = source.Price,
                    BodyType = source.BodyType,
                    ModelYear = source.ModelYear,
                    EngineType = source.EngineType,
                    EngineSize = source.EngineSize,
                    TransmissionType = source.TransmissionType,
                    DriveType = source.DriveType,
                    Condition = source.Condition,
                    Mileage = source.Mileage,
                    ColorId = source.ColorId,
                    SellerType = source.SellerType,
                    IsSwap = source.IsSwap,
                    Description = source.Description,
                    OriginalURL = source.OriginalURL,
                    PageCreatedOn = source.PageCreatedOn,
                    CarImages = source.CarImages,
                    OptionList = source.OptionList,
                    OriginalCarBrand = source.OriginalCarBrand,
                    OriginalCarModel = source.OriginalCarModel
        WHEN NOT MATCHED BY TARGET 
            THEN 
                INSERT 
                (
                    CarModelId,
                    SiteId,
                    PlaceId,
                    Price,
                    BodyType,
                    ModelYear,
                    EngineType,
                    EngineSize,
                    TransmissionType,
                    DriveType,
                    Condition,
                    Mileage,
                    ColorId,
                    SellerType,
                    IsSwap,
                    Description,
                    OriginalURL,
                    PageCreatedOn,
                    CarImages,
                    OptionList,
                    OriginalCarBrand,
                    OriginalCarModel
                )
                VALUES 
                (
                    source.CarModelId,
                    source.SiteId,
                    source.PlaceId,
                    source.Price,
                    source.BodyType,
                    source.ModelYear,
                    source.EngineType,
                    source.EngineSize,
                    source.TransmissionType,
                    source.DriveType,
                    source.Condition,
                    source.Mileage,
                    source.ColorId,
                    source.SellerType,
                    source.IsSwap,
                    source.Description,
                    source.OriginalURL,
                    source.PageCreatedOn,
                    source.CarImages,
                    source.OptionList,
                    source.OriginalCarBrand,
                    source.OriginalCarModel
                )
        --when not matched by source then delete 
        --OUTPUT  $action, deleted.*, inserted.*
        OUTPUT inserted.CarId,
               NULL,
               inserted.OriginalURL,
               inserted.Price,
               inserted.Mileage,
               inserted.SellerType,
               inserted.Description,
               inserted.PageCreatedOn
          INTO #Car
        ;   
        UPDATE cop
        SET cop.OwnerPhone = cp.OwnerPhone
        FROM #Car cop
        JOIN CarParsing cp ON cp.SiteUrl = cop.OriginalURL
        ;
        EXEC dbo.CarOwnerPhoneInsert 
        ;
        UPDATE cp
        SET PageStatusId = CASE WHEN t.ErrorType IS NULL THEN 2 ELSE 0 END
        FROM dbo.CarParsing cp
        JOIN #CarParsing t ON t.CarParsingId = cp.CarParsingId
        ;
        EXEC dbo.CarLogInsert
        ;
        COMMIT TRANSACTION
    END TRY        
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END
        EXECUTE dbo.ErrorLogInsert @pSendEmail = 1;
    END CATCH
    IF OBJECT_ID('tempdb..#CarParsing') IS NOT NULL DROP TABLE #CarParsing
    ;
    IF OBJECT_ID('tempdb..#Car') IS NOT NULL DROP TABLE #Car
    ;
    
END

/*

exec [dbo].[CarParsingMergeCar]

*/