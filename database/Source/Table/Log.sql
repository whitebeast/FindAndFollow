CREATE TABLE [Log]
    (
        LogId         INT IDENTITY(1, 1) NOT NULL,
        UserId        INT NOT NULL,
        LogMessage    NVARCHAR(4000) NOT NULL,
        CreatedOn     DATETIME2 NOT NULL
    )
    ;
