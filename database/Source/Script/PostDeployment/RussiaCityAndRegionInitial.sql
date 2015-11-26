SET NOCOUNT ON;
PRINT 'Populate Russian Country, Region, City and Place tables...'
DECLARE @tCityRegion TABLE (City NVARCHAR(100), Region NVARCHAR(100))
INSERT INTO @tCityRegion
(
    City,
    Region
)
SELECT N'Москва',N'Московская область' UNION ALL
SELECT N'Санкт-Петербург',N'Ленинградская область' UNION ALL
SELECT N'Смоленск',N'Смоленская область' UNION ALL
SELECT N'Брянск',N'Брянская область'

IF NOT EXISTS (SELECT 1 FROM dbo.Country AS c WHERE NAME = N'Российская Федерация')
INSERT INTO Country (NAME)
VALUES(N'Российская Федерация')

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
SELECT @CountryId = CountryId FROM dbo.Country AS c WHERE NAME = N'Российская Федерация'

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
    
    