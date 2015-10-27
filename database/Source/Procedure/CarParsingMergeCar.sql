CREATE PROCEDURE [dbo].[CarParsingMergeCar]
AS
BEGIN
    SET NOCOUNT ON
    ;
    IF OBJECT_ID('tempdb..#CarParsing') IS NOT NULL DROP TABLE #CarParsing
    ;
    -- load and parse data
    SELECT  CASE 
                WHEN cb.CarBrandId IS NULL THEN 'CarBrand'
                WHEN cm.CarModelId IS NULL THEN 'CarModel' 
                WHEN s.SiteId IS NULL THEN 'Site'
                WHEN col.ColorId IS NULL THEN 'Color'
                ELSE NULL
            END AS ErrorType,
            cb.CarBrandId,
            cp.CarBrand,
            cm.CarModelId,
            CASE 
                WHEN cp.Model LIKE 'A4 %' THEN 'A4' 
                ELSE cp.Model
            END AS Model,
            s.SiteId,
            cp.SiteId AS SiteURL,
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
            col.ColorId,
            cp.Color,
            CASE cp.SellerType
                WHEN N'Частное' THEN 1
                WHEN N'Автохаус' THEN 1
                WHEN N'Дилер' THEN 1
                ELSE 0
            END AS SellerType,
            cp.IsSwap,
            cp.Description,
            cp.SiteUrl AS OriginalURL
    INTO    #CarParsing
    FROM    dbo.CarParsing cp
    LEFT JOIN dbo.CarBrand cb ON cb.Name = cp.CarBrand
    LEFT JOIN dbo.CarModel cm ON cm.Name = cp.Model AND cm.CarBrandId = cb.CarBrandId
    LEFT JOIN dbo.[Site] s ON s.SiteUrl = cp.SiteId
    LEFT JOIN dbo.Color AS col ON col.Name = cp.Color
    ;
    BEGIN TRY
        BEGIN TRANSACTION
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
        EXEC dbo.CarParsingClean
        ;
        COMMIT TRANSACTION
    END TRY        
    BEGIN CATCH
        EXECUTE dbo.ErrorInfoGet;
        -- If we have an open transaction and this sproc opened it then rollback to the save point, unless the
        -- transaction is doomed. If it is doomed then rollback all transactions if there are no previous transactions.
        IF (XACT_STATE() = 1) AND (@@TRANCOUNT > 0) ROLLBACK TRANSACTION;
        ELSE IF (XACT_STATE() = -1) AND (@@TRANCOUNT = 0) ROLLBACK TRANSACTION;
    END CATCH
    
    -- show wrong data
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
    ;
    IF OBJECT_ID('tempdb..#CarParsing') IS NOT NULL DROP TABLE #CarParsing
    ;
    
END
