CREATE TABLE [SearchCar]
    (
        SearchCarId     INT IDENTITY(1, 1) NOT NULL,
        SearchId        INT NOT NULL,
        CarId           INT NOT NULL,
        CreatedOn       DATETIME2 NOT NULL
    )
    ;