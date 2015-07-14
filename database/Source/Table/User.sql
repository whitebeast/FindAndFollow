CREATE TABLE [User]
    (
        UserId         INT IDENTITY(1, 1) NOT NULL,
        [Login]        VARCHAR(30) NOT NULL,
        [Password]     VARCHAR(10) NOT NULL,
        Email          VARCHAR(30) NOT NULL,
        IsActive       BIT NOT NULL,
        CreatedOn      DATETIME2 NOT NULL,
        ModifiedOn     DATETIME2 NULL
    )
    ;
