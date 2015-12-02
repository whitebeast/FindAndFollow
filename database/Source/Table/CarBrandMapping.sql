CREATE TABLE dbo.CarBrandMapping
    (
        CarBrandMappingId   INT NOT NULL IDENTITY(1,1),
        BrandMask           NVARCHAR(100) NOT NULL,
        CarBrandId          INT NOT NULL
    )