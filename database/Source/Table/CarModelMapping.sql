CREATE TABLE dbo.CarModelMapping
    (
        CarModelMappingId   INT NOT NULL IDENTITY(1,1),
        ModelMask           NVARCHAR(100) NOT NULL,
        ModelNotMask        NVARCHAR(100) NOT NULL,
        CarBrandId          INT NOT NULL,
        CarModelId          INT NOT NULL
    )