CREATE TABLE [Search]
    (
        SearchId          INT IDENTITY(1, 1) NOT NULL,
        UserId            INT NOT NULL,
        SearchXML         XML NOT NULL,
        IsActive          BIT NOT NULL,
        CreatedOn         DATETIME2 NOT NULL,
        ModifiedOn        DATETIME2 NULL
    )
    ;
