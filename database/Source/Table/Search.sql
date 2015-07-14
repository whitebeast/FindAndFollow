CREATE TABLE [Search]
    (
        SearchId          INT IDENTITY(1, 1) NOT NULL,
        UserId            INT NOT NULL,
        PriceMin          MONEY NOT NULL,
        PriceMax          MONEY NOT NULL,
        YearMin           SMALLINT NOT NULL,
        YearMax           SMALLINT NOT NULL,
        EngineSizeMin     SMALLINT NOT NULL,
        EngineSizeMax     SMALLINT NOT NULL,
        IsActive          BIT NOT NULL,
        CreatedOn         DATETIME2 NOT NULL,
        ModifiedOn        DATETIME2 NULL
    )
    ;
