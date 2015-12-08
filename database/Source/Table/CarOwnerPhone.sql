CREATE TABLE [dbo].[CarOwnerPhone]
(
    CarOwnerPhoneId     INT IDENTITY(1, 1) NOT NULL,
    CarId               INT NOT NULL,
    Phone               VARCHAR(30) NOT NULL,
    IsActual            BIT NOT NULL,
    CreatedOn           DATETIME2 NOT NULL
)

/*
StatusId:
    1 - new row / actual phone, by default
    0 - log phone

*/