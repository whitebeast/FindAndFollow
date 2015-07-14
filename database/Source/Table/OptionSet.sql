CREATE TABLE OptionSet
    (
        OptionSetId     INT IDENTITY(1, 1) NOT NULL,
        OptionId        INT NOT NULL,
        SetId           INT NOT NULL,
        CreatedOn       DATETIME2 NOT NULL
    )
    ;
