CREATE TABLE [CarModel]
    (
        CarModelId     INT IDENTITY(1, 1) NOT NULL,
        CarBrandId     INT NOT NULL,
        Name           NVARCHAR(50) NOT NULL,
        CreatedOn      DATETIME2 NOT NULL
    )
