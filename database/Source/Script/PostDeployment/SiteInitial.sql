PRINT 'Populating Site table...'
;
IF NOT EXISTS(SELECT 1 FROM dbo.[Site])
    INSERT INTO [dbo].[Site]
               ([SiteUrl]
               ,[ShortDescription]
               ,[FullDescription]
               ,[CountryId])
    SELECT  'abw.by',
            N'АвтоБизнес Weekly',
            N' ',
            1
    UNION ALL
    SELECT 'ab.onliner.by',
            N'Барахолка Онлайнера',
            N' ',
            1
    UNION ALL
    SELECT 'av.by',
            N'Автомалиновка',
            N' ',
            1
