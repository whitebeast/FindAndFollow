CREATE PROCEDURE [dbo].[CarParsingMergeCar]
AS
BEGIN
    SET NOCOUNT ON
    ;
    IF OBJECT_ID('tempdb..#CarParsing') IS NOT NULL DROP TABLE #CarParsing
    ;
    DECLARE @XML XML
    ;
    BEGIN TRY
        BEGIN TRANSACTION
        -- load and parse data
        SELECT  CASE 
                    WHEN cb.CarBrandId IS NULL THEN 'CarBrand Error'
                    WHEN cm.CarModelId IS NULL THEN 'CarModel Error' 
                    WHEN s.SiteId IS NULL THEN 'Site Error'
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
                cp.OriginalURL,
                cp.PageCreatedOn
        INTO    #CarParsing
        FROM    (
                    SELECT  cp.CarParsingId,
                            cp.CarBrand,
                            dbo.MappingModel(cp.Model) AS Model,
                            cp.SiteId,
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
                            cp.SiteUrl AS OriginalURL,
                            cp.PageCreatedOn
                    FROM    dbo.CarParsing cp
                    WHERE cp.PageStatusId = 1 -- Downloaded page (default)    	
        ) AS cp
        LEFT JOIN dbo.CarBrand cb ON cb.Name = cp.CarBrand
        LEFT JOIN dbo.CarModel cm ON cm.Name = cp.Model AND cm.CarBrandId = cb.CarBrandId
        LEFT JOIN dbo.[Site] s ON s.SiteUrl = cp.SiteId
        LEFT JOIN dbo.Color AS col ON col.Name = cp.Color
        ;

        -- write wrong data info to Log table
        IF EXISTS (SELECT 1 FROM #CarParsing WHERE ErrorType IS NOT NULL) BEGIN
            SELECT @XML = (
                SELECT  cp.ErrorType,
                        cp.CarBrand,
                        cp.Model,
                        cp.SiteId,
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
                        cp.OriginalURL,
                        cp.PageCreatedOn
                FROM #CarParsing AS cp 
                WHERE cp.ErrorType IS NOT NULL
                FOR XML PATH, ROOT
            )
            ;
            INSERT INTO dbo.ErrorLog 
                (
                    [UserName]
                   ,[ErrorNumber]
                   ,[ErrorSeverity]
                   ,[ErrorState]
                   ,[ErrorProcedure]
                   ,[ErrorLine]
                   ,[ErrorMessage]    
                )
            SELECT  CONVERT(sysname, SUSER_NAME()),
                    0,
                    16,
                    0,
                    OBJECT_NAME(@@PROCID),
                    0,
                    dbo.XMLToJSON(@XML)
            ;
        END
        ;
        -- insert into Car table
        INSERT INTO [dbo].[Car]
               ([CarModelId]
               ,[SiteId]
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
               ,[PageCreatedOn])
        SELECT  cp.CarModelId,
                cp.SiteId,
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
                cp.PageCreatedOn
        FROM #CarParsing AS cp  
        WHERE cp.ErrorType IS NULL        
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
    
END