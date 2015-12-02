CREATE TABLE Car
    (
        CarId                 INT IDENTITY(1, 1) NOT NULL,
        CarModelId            INT NOT NULL,
        SiteId                INT NOT NULL,
        PlaceId               INT NOT NULL,
        Price                 MONEY NOT NULL,
        BodyType              TINYINT NOT NULL,
        ModelYear             SMALLINT NOT NULL,
        EngineType            TINYINT NOT NULL,
        EngineSize            SMALLINT NOT NULL,
        TransmissionType      BIT NOT NULL,
        DriveType             TINYINT NOT NULL,
        Condition             TINYINT NOT NULL,
        Mileage               INT NULL,
        ColorId               TINYINT NOT NULL,
        SellerType            TINYINT NOT NULL,
        IsSwap                BIT NOT NULL,
        Description           NVARCHAR(4000) NULL,
        OriginalURL           NVARCHAR(1000),
        PageCreatedOn         DATETIME2 NULL,
        CarImages             NVARCHAR(4000) NULL,
        OptionList            NVARCHAR(4000) NULL,
        OriginalCarModel      NVARCHAR(50) NULL,
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
10 - Pickup
11 - Roadster
12 - Bus
0 - Other

EngineType:
1 - Petrol
2 - Diesel
3 - Gas
4 - Hybrid (petrol)
5 - Hybrid (diesel)
6 - Electric
0 - Other

DriveType:
1 - FWD
2 - RWD
3 - 4x4
0 - Other

Condition:
1 - New
2 - Used
3 - Wreck
0 - Other

SellerType:
1 - Private
2 - Autohaus
3 - Dieler
0 - Other

TransmissionType:
1 - Automatic
2 - Manual
0 - Other
*/