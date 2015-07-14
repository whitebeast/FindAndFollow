CREATE TABLE Currency
    (
        CurrencyId      INT IDENTITY(1, 1) NOT NULL,
        CharCode        VARCHAR(3) NOT NULL,
        EnglishName     VARCHAR(255) NOT NULL,
        CreatedOn       DATETIME2 NOT NULL
    )
    ;
