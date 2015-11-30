PRINT 'Populate Color table...'
;
IF NOT EXISTS (SELECT 1 FROM dbo.Color) 
    INSERT INTO [dbo].[Color] ([Name])
    SELECT N'Белый'
    UNION ALL
    SELECT N'Желтый'
    UNION ALL
    SELECT N'Зеленый'
    UNION ALL
    SELECT N'Коричневый'
    UNION ALL
    SELECT N'Красный'
    UNION ALL
    SELECT N'Оранжевый'
    UNION ALL
    SELECT N'Серебристый'
    UNION ALL
    SELECT N'Серый'
    UNION ALL
    SELECT N'Синий'
    UNION ALL
    SELECT N'Фиолетовый'
    UNION ALL
    SELECT N'Черный'
    UNION ALL
    SELECT N'Другой'
;
/*
-- english version
IF NOT EXISTS (SELECT 1 FROM dbo.Color) 
    INSERT INTO [dbo].[Color] ([Name])
    SELECT N'White'
    UNION ALL
    SELECT N'Yellow'
    UNION ALL
    SELECT N'Green'
    UNION ALL
    SELECT N'Brown'
    UNION ALL
    SELECT N'Red'
    UNION ALL
    SELECT N'Orange'
    UNION ALL
    SELECT N'Silver'
    UNION ALL
    SELECT N'Gray'
    UNION ALL
    SELECT N'Blue'
    UNION ALL
    SELECT N'Purple'
    UNION ALL
    SELECT N'Black'
    UNION ALL
    SELECT N'Other'
;
*/