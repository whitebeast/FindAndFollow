CREATE TABLE Car
    (
        CarId                 INT IDENTITY(1, 1) NOT NULL,
        CarModelId            INT NOT NULL,
        SiteId                INT NOT NULL,
        Price                 MONEY NOT NULL,
        BodyType              TINYINT NOT NULL,
        ModelYear             SMALLINT NOT NULL,
        EngineType            TINYINT NOT NULL,
        EngineSize            SMALLINT NOT NULL,
        TransmissionType      BIT NOT NULL,
        DriveType             TINYINT NOT NULL,
        Condition             TINYINT NOT NULL,
        Mileage               SMALLINT NOT NULL,
        ColorId               TINYINT NOT NULL,
        SellerType            TINYINT NOT NULL,
        IsSwap                BIT NOT NULL,
        Description           NVARCHAR(1000) NULL,
        OriginalURL           VARCHAR(1000),
        CreatedOn             DATETIME2 NOT NULL
    )
    ;

/*
BodyType:
1 - Sedan
2 - Wagon
3 - Hatchback
4 - Minivan
5 - SUV
6 - Coupe
7 - Cabriolet
8 - Minibus
9 - Van 

EngineType:
1 - Petrol
2 - Diesel
3 - Gas
4 - Hybrid (petrol)
5 - Hybrid (diesel)
6 - Electric

DriveType:
1 - FWD
2 - RWD
3 - 4x4

Condition:
1 - Used
2 - New
3 - Wreck

SellerType:
1 - Private
2 - Autohaus
3 - Dieler

TransmissionType:
1 - Automatic
2 - Manual
*/