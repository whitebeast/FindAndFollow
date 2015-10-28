CREATE FUNCTION [dbo].[MappingType]
(
    @pType VARCHAR(20),
    @pString NVARCHAR(100)
)
RETURNS INT
AS
BEGIN
    RETURN 
        CASE 
            WHEN @pType = 'BodyType' THEN
                CASE @pString
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
                END
            WHEN @pType = 'EngineType' THEN
                CASE @pString
                    WHEN N'Бензиновый' THEN 1
                    WHEN N'Дизельный' THEN 2
                    WHEN N'Газ' THEN 3
                    WHEN N'Гибридный бензиновый' THEN 4
                    WHEN N'Гибридный дизельный' THEN 5
                    WHEN N'Электрический' THEN 6
                END
            WHEN @pType = 'TransmissionType' THEN
                CASE @pString
                    WHEN N'Автомат' THEN 1
                    WHEN N'Механика' THEN 2
                END
            WHEN @pType = 'DriveType' THEN
                CASE @pString
                    WHEN N'Передний' THEN 1
                    WHEN N'Задний' THEN 2
                    WHEN N'Полный' THEN 3
                END
            WHEN @pType = 'Condition' THEN
                CASE @pString
                    WHEN N'Новый' THEN 1
                    WHEN N'С пробегом' THEN 2
                    WHEN N'Аварийный' THEN 3
                END
            WHEN @pType = 'SellerType' THEN
                CASE @pString
                    WHEN N'Частное' THEN 1
                    WHEN N'Автохаус' THEN 2
                    WHEN N'Дилер' THEN 3
                END
            ELSE 0 
        END 
END
