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
                cp.OriginalURL
        INTO    #CarParsing
        FROM    (
                    SELECT  cp.CarParsingId,
                            cp.CarBrand,
                            CASE 
                                WHEN cp.Model LIKE 'A4 %' THEN 'A4' 
                                ELSE cp.Model
                            END AS Model,
                            cp.SiteId,
                            cp.Price,
                            CASE cp.BodyType
                                WHEN N'Седан' THEN 1
                                WHEN N'Универсал' THEN 2
                                WHEN N'Хетчбэк' THEN 3
                                WHEN N'Минивэн' THEN 4
                                WHEN N'Внедорожник' THEN 5 
                                WHEN N'Купе' THEN 6
                                WHEN N'Кабриолет' THEN 7 
                                WHEN N'Микроавтобус' THEN 8 
                                WHEN N'Грузовик' THEN 9
                                WHEN N'Пикап' THEN 10
                                WHEN N'Родстер' THEN 11
                                WHEN N'Автобус' THEN 12
                                ELSE 0 
                            END AS BodyType,
                            cp.ModelYear,
                            CASE cp.EngineType
                                WHEN N'Бензиновый' THEN 1
                                WHEN N'Дизельный' THEN 2
                                WHEN N'Газ' THEN 3
                                WHEN N'Гибридный бензиновый' THEN 4
                                WHEN N'Гибридный дизельный' THEN 5
                                WHEN N'Электрический' THEN 6
                                ELSE 0 
                            END AS EngineType,
                            cp.EngineSize,
                            CASE cp.TransmissionType
                                WHEN N'Автомат' THEN 1
                                WHEN N'Механика' THEN 2
                                ELSE 0
                            END AS TransmissionType,
                            CASE cp.DriveType
                                WHEN N'Передний' THEN 1
                                WHEN N'Задний' THEN 2
                                WHEN N'Полный' THEN 3  
                                ELSE 0
                            END AS DriveType,
                            CASE cp.Condition
                                WHEN N'Новый' THEN 1
                                WHEN N'С пробегом' THEN 2
                                WHEN N'Аварийный' THEN 3
                                ELSE 0
                            END AS Condition,
                            cp.Mileage,
                            cp.Color,
                            CASE cp.SellerType
                                WHEN N'Частное' THEN 1
                                WHEN N'Автохаус' THEN 2
                                WHEN N'Дилер' THEN 3
                                ELSE 0
                            END AS SellerType,
                            cp.IsSwap,
                            cp.Description,
                            cp.SiteUrl AS OriginalURL
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
                        cp.OriginalURL
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
            SELECT  CONVERT(sysname, CURRENT_USER),
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
               ,[OriginalURL])
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
                cp.OriginalURL
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