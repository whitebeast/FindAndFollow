CREATE TABLE Place
    (
        PlaceId       INT IDENTITY(1, 1) NOT NULL,
        CountryId     INT NOT NULL,
        RegionId      INT NOT NULL,
        CityId        INT NOT NULL,
        CreatedOn     DATETIME2 NOT NULL
    )
    ;
