CREATE TABLE CarImage
    (
        CarImageId     INT IDENTITY(1, 1) NOT NULL,
        CarId          INT NOT NULL,
        ImageUrl       VARCHAR(1000) NOT NULL,
        CreatedOn      DATETIME2 NOT NULL
    )
