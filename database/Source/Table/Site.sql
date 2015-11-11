CREATE TABLE [Site]
    (
        SiteId               INT IDENTITY(1, 1) NOT NULL,
        SiteUrl              NVARCHAR(100) NOT NULL,
        ShortDescription     NVARCHAR(100) NOT NULL,
        FullDescription      NVARCHAR(500) NOT NULL,
        CountryId            INT NOT NULL,
        CreatedOn            DATETIME2 NOT NULL
    )
    ;
