﻿CREATE PROCEDURE [dbo].[CarParsingMergeCar]
(
    @pDebug BIT = 0
)
AS
BEGIN
    SET NOCOUNT ON
    ;
    IF OBJECT_ID('tempdb..#CarParsing') IS NOT NULL DROP TABLE #CarParsing
    ;
    IF OBJECT_ID('tempdb..#CarOwnerPhone') IS NOT NULL DROP TABLE #CarOwnerPhone
    ;
    CREATE TABLE #CarOwnerPhone 
        (
            CarId       INT,
            OwnerPhone  NVARCHAR(300),
            OriginalURL NVARCHAR(1000)
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
        -- load and parse data
        SELECT  CASE 
                    WHEN cb.CarBrandId IS NULL THEN 'CarBrand Error'
                    WHEN cm.CarModelId IS NULL THEN 'CarModel Error' 
                    WHEN s.SiteId IS NULL THEN 'Site Error'
                    WHEN c.CityId IS NULL THEN 'City Error'
                    WHEN pl.PlaceId IS NULL THEN 'Place Error'
                    WHEN col.ColorId IS NULL THEN 'Color Error'
                    ELSE NULL
                END AS ErrorType,
                cp.CarParsingId,
                cb.CarBrandId,
                cp.CarBrand,
                cm.CarModelId,
                cp.Model,
                s.SiteId,
                cp.SiteId AS SiteURL,
                c.CityId,
                cp.City,
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
                            dbo.MappingModel(cp.Model) AS Model,
                            cp.SiteId,
                            cp.City,
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
        LEFT JOIN dbo.CarModel AS cm ON cm.Name = cp.Model AND cm.CarBrandId = cb.CarBrandId
        LEFT JOIN dbo.[Site] AS s ON s.SiteUrl = cp.SiteId
        LEFT JOIN dbo.Color AS col ON col.Name = cp.Color
        LEFT JOIN dbo.City AS c ON c.Name = cp.City
        LEFT JOIN dbo.Place AS pl ON pl.CityId = c.CityId AND pl.CountryId = s.CountryId
        ;

        -- write wrong data info to Log table
        IF EXISTS (SELECT 1 FROM #CarParsing WHERE ErrorType IS NOT NULL) BEGIN
            SELECT @XML = (
                SELECT  cp.ErrorType,
                        cp.CarBrand,
                        cp.Model,
                        cp.SiteId,
                        cp.City,
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
                        @pErrorMessageFull = @ErrorMessageFull
            ;
            IF @pDebug = 1 BEGIN
                PRINT 'Merge errors:';
                RAISERROR(@ErrorMessageFull,0,1) WITH NOWAIT;
            END
            ;
        END
        ;
        -- insert into Car table
        INSERT INTO [dbo].[Car]
               ([CarModelId]
               ,[SiteId]
               ,[PlaceId]
               ,[Price]
               ,[BodyType]
               ,[ModelYear]
               ,[EngineType]
               ,[EngineSize]
               ,[TransmissionType]
               ,[DriveType]
               ,[Condition]
               ,[Mileage]
               ,[ColorId]
               ,[SellerType]
               ,[IsSwap]
               ,[Description]
               ,[OriginalURL]
               ,[PageCreatedOn]
               ,[CarImages]
               ,[OptionList])
        OUTPUT
            inserted.CarId,
            NULL,
            inserted.OriginalURL
        INTO #CarOwnerPhone
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
                cp.OptionList
        FROM #CarParsing AS cp  
        WHERE cp.ErrorType IS NULL        
        ;   
        UPDATE cop
        SET cop.OwnerPhone = cp.OwnerPhone
        FROM #CarOwnerPhone cop
        JOIN CarParsing cp ON cp.SiteUrl = cop.OriginalURL
        ;
        EXEC dbo.CarOwnerPhoneInsert
        ;
        UPDATE cp
        SET PageStatusId = CASE WHEN t.ErrorType IS NULL THEN 2 ELSE 0 END
        FROM dbo.CarParsing cp
        JOIN #CarParsing t ON t.CarParsingId = cp.CarParsingId
        ;
        COMMIT TRANSACTION
    END TRY        
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END
        EXECUTE dbo.ErrorLogInsert;
    END CATCH
    IF OBJECT_ID('tempdb..#CarParsing') IS NOT NULL DROP TABLE #CarParsing
    ;
    IF OBJECT_ID('tempdb..#CarOwnerPhone') IS NOT NULL DROP TABLE #CarOwnerPhone
    ;
    
END

/*

exec [dbo].[CarParsingMergeCar]

*/