 CREATE TABLE CarParsing(
    CarParsingId        INT NOT NULL IDENTITY(1,1),
    CarBrand            NVARCHAR(50) NULL,
    Model               NVARCHAR(50) NULL,
    SiteId              NVARCHAR(50) NULL,
    SiteUrl             NVARCHAR(2000) NULL,
    City                NVARCHAR(200) NULL,
    Price               NVARCHAR(100) NULL,
    BodyType            NVARCHAR(100) NULL,
    ModelYear           NVARCHAR(4) NULL,
    EngineType          NVARCHAR(100) NULL,
    EngineSize          NVARCHAR(5) NULL,
    TransmissionType    NVARCHAR(100) NULL,
    DriveType           NVARCHAR(100) NULL,
    Condition           NVARCHAR(100) NULL,
    Mileage             NVARCHAR(100) NULL,
    Color               NVARCHAR(100) NULL,
    SellerType          NVARCHAR(100) NULL,
    IsSwap              CHAR(1) NULL,
    [Description]       NVARCHAR(1000) NULL,
    PageCreatedOn       NVARCHAR(100) NULL,
    CreatedOn           DATETIME NOT NULL,
    IsPageExist         BIT NOT NULL,
	PageStatusId		TINYINT NOT NULL
    )

	/*
	PageStatusId:
	0 - Error merge with Car table 
	1 - Downloaded page (default)
	2 - Successfull merge with Car table

	*/