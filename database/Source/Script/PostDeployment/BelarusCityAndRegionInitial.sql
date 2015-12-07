SET NOCOUNT ON;
PRINT 'Populate Belarus Country, Region, City and Place tables...'
DECLARE @tCityRegion TABLE (City NVARCHAR(100), Region NVARCHAR(100))
INSERT INTO @tCityRegion
(
    City,
    Region
)
SELECT N'Береза',N'Брестская область' UNION ALL
SELECT N'Ганцевичи',N'Брестская область' UNION ALL
SELECT N'Дрогичин',N'Брестская область' UNION ALL
SELECT N'Жабинка',N'Брестская область' UNION ALL
SELECT N'Иваново',N'Брестская область' UNION ALL
SELECT N'Ивацевичи',N'Брестская область' UNION ALL
SELECT N'Каменец',N'Брестская область' UNION ALL
SELECT N'Кобрин',N'Брестская область' UNION ALL
SELECT N'Лунинец',N'Брестская область' UNION ALL
SELECT N'Ляховичи',N'Брестская область' UNION ALL
SELECT N'Малорита',N'Брестская область' UNION ALL
SELECT N'Пружаны',N'Брестская область' UNION ALL
SELECT N'Ружаны',N'Брестская область' UNION ALL
SELECT N'Столин',N'Брестская область' UNION ALL
SELECT N'Брест',N'Брестская область' UNION ALL
SELECT N'Барановичи',N'Брестская область' UNION ALL
SELECT N'Пинск',N'Брестская область' UNION ALL
SELECT N'Бешенковичи',N'Витебская область' UNION ALL
SELECT N'Браслав',N'Витебская область' UNION ALL
SELECT N'Верхнедвинск',N'Витебская область' UNION ALL
SELECT N'Глубокое',N'Витебская область' UNION ALL
SELECT N'Городок',N'Витебская область' UNION ALL
SELECT N'Докшицы',N'Витебская область' UNION ALL
SELECT N'Дубровно',N'Витебская область' UNION ALL
SELECT N'Лепель',N'Витебская область' UNION ALL
SELECT N'Лиозно',N'Витебская область' UNION ALL
SELECT N'Миоры',N'Витебская область' UNION ALL
SELECT N'Поставы',N'Витебская область' UNION ALL
SELECT N'Россоны',N'Витебская область' UNION ALL
SELECT N'Сенно',N'Витебская область' UNION ALL
SELECT N'Толочин',N'Витебская область' UNION ALL
SELECT N'Ушачи',N'Витебская область' UNION ALL
SELECT N'Чашники',N'Витебская область' UNION ALL
SELECT N'Шарковщина',N'Витебская область' UNION ALL
SELECT N'Шумилино',N'Витебская область' UNION ALL
SELECT N'Витебск',N'Витебская область' UNION ALL
SELECT N'Новополоцк',N'Витебская область' UNION ALL
SELECT N'Орша',N'Витебская область' UNION ALL
SELECT N'Полоцк',N'Витебская область' UNION ALL
SELECT N'Брагин',N'Гомельская область' UNION ALL
SELECT N'Буда-Кошелево',N'Гомельская область' UNION ALL
SELECT N'Ветка',N'Гомельская область' UNION ALL
SELECT N'Добруш',N'Гомельская область' UNION ALL
SELECT N'Ельск',N'Гомельская область' UNION ALL
SELECT N'Житковичи',N'Гомельская область' UNION ALL
SELECT N'Жлобин',N'Гомельская область' UNION ALL
SELECT N'Калинковичи',N'Гомельская область' UNION ALL
SELECT N'Корма',N'Гомельская область' UNION ALL
SELECT N'Лельчицы',N'Гомельская область' UNION ALL
SELECT N'Лоев',N'Гомельская область' UNION ALL
SELECT N'Мозырь',N'Гомельская область' UNION ALL
SELECT N'Наровля',N'Гомельская область' UNION ALL
SELECT N'Октябрьский',N'Гомельская область' UNION ALL
SELECT N'Петриков',N'Гомельская область' UNION ALL
SELECT N'Речица',N'Гомельская область' UNION ALL
SELECT N'Рогачев',N'Гомельская область' UNION ALL
SELECT N'Светлогорск',N'Гомельская область' UNION ALL
SELECT N'Хойники',N'Гомельская область' UNION ALL
SELECT N'Чечерск',N'Гомельская область' UNION ALL
SELECT N'Гомель',N'Гомельская область' UNION ALL
SELECT N'Большая Берестовица',N'Гродненская область' UNION ALL
SELECT N'Волковыск',N'Гродненская область' UNION ALL
SELECT N'Вороново',N'Гродненская область' UNION ALL
SELECT N'Дятлово',N'Гродненская область' UNION ALL
SELECT N'Зельва',N'Гродненская область' UNION ALL
SELECT N'Ивье',N'Гродненская область' UNION ALL
SELECT N'Кореличи',N'Гродненская область' UNION ALL
SELECT N'Лида',N'Гродненская область' UNION ALL
SELECT N'Мосты',N'Гродненская область' UNION ALL
SELECT N'Новогрудок',N'Гродненская область' UNION ALL
SELECT N'Островец',N'Гродненская область' UNION ALL
SELECT N'Ошмяны',N'Гродненская область' UNION ALL
SELECT N'Свислочь',N'Гродненская область' UNION ALL
SELECT N'Слоним',N'Гродненская область' UNION ALL
SELECT N'Сморгонь',N'Гродненская область' UNION ALL
SELECT N'Щучин',N'Гродненская область' UNION ALL
SELECT N'Гродно',N'Гродненская область' UNION ALL
SELECT N'Минск',N'Минская область' UNION ALL
SELECT N'Березино',N'Минская область' UNION ALL
SELECT N'Борисов',N'Минская область' UNION ALL
SELECT N'Вилейка',N'Минская область' UNION ALL
SELECT N'Воложин',N'Минская область' UNION ALL
SELECT N'Дзержинск',N'Минская область' UNION ALL
SELECT N'Клецк',N'Минская область' UNION ALL
SELECT N'Копыль',N'Минская область' UNION ALL
SELECT N'Крупки',N'Минская область' UNION ALL
SELECT N'Логойск',N'Минская область' UNION ALL
SELECT N'Любань',N'Минская область' UNION ALL
SELECT N'Молодечно',N'Минская область' UNION ALL
SELECT N'Мядель',N'Минская область' UNION ALL
SELECT N'Несвиж',N'Минская область' UNION ALL
SELECT N'Марьина Горка',N'Минская область' UNION ALL
SELECT N'Слуцк',N'Минская область' UNION ALL
SELECT N'Смолевичи',N'Минская область' UNION ALL
SELECT N'Солигорск',N'Минская область' UNION ALL
SELECT N'Старые Дороги',N'Минская область' UNION ALL
SELECT N'Столбцы',N'Минская область' UNION ALL
SELECT N'Узда',N'Минская область' UNION ALL
SELECT N'Червень',N'Минская область' UNION ALL
SELECT N'Жодино',N'Минская область' UNION ALL
SELECT N'Заславль',N'Минская область' UNION ALL
SELECT N'Белыничи',N'Могилевская область' UNION ALL
SELECT N'Быхов',N'Могилевская область' UNION ALL
SELECT N'Глуск',N'Могилевская область' UNION ALL
SELECT N'Горки',N'Могилевская область' UNION ALL
SELECT N'Дрибин',N'Могилевская область' UNION ALL
SELECT N'Кировск',N'Могилевская область' UNION ALL
SELECT N'Климовичи',N'Могилевская область' UNION ALL
SELECT N'Кличев',N'Могилевская область' UNION ALL
SELECT N'Костюковичи',N'Могилевская область' UNION ALL
SELECT N'Краснополье',N'Могилевская область' UNION ALL
SELECT N'Кричев',N'Могилевская область' UNION ALL
SELECT N'Круглое',N'Могилевская область' UNION ALL
SELECT N'Мстиславль',N'Могилевская область' UNION ALL
SELECT N'Осиповичи',N'Могилевская область' UNION ALL
SELECT N'Славгород',N'Могилевская область' UNION ALL
SELECT N'Хотимск',N'Могилевская область' UNION ALL
SELECT N'Чаусы',N'Могилевская область' UNION ALL
SELECT N'Чериков',N'Могилевская область' UNION ALL
SELECT N'Шклов',N'Могилевская область' UNION ALL
SELECT N'Могилев',N'Могилевская область' UNION ALL
SELECT N'Бобруйск',N'Могилевская область'

IF NOT EXISTS (SELECT 1 FROM dbo.Country AS c WHERE NAME = N'Беларусь')
INSERT INTO Country (NAME)
VALUES(N'Беларусь')

INSERT INTO dbo.Region (NAME)
SELECT DISTINCT tcr.Region 
FROM @tCityRegion AS tcr
LEFT JOIN dbo.Region AS r ON r.Name = tcr.Region
WHERE r.Name IS NULL

INSERT INTO dbo.City (NAME)
SELECT tcr.City
FROM @tCityRegion AS tcr
LEFT JOIN dbo.City AS c ON c.Name = tcr.City
WHERE c.Name IS NULL

DECLARE @CountryId INT
SELECT @CountryId = CountryId FROM dbo.Country AS c WHERE NAME = N'Беларусь'

INSERT INTO dbo.Place 
    (
        CountryId,
        RegionId,
        CityId
    )
SELECT  @CountryId,
        r.RegionId,
        c.CityId
FROM    @tCityRegion AS t
JOIN    dbo.City AS c ON c.Name = t.City
JOIN    dbo.Region AS r ON r.Name = t.Region
LEFT JOIN dbo.Place p ON p.CountryId = @CountryId AND p.RegionId = r.RegionId AND p.CityId = c.CityId
WHERE p.PlaceId IS NULL
    
    