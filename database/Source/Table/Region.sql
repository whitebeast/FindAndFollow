CREATE TABLE [dbo].[Region]
    (
        [RegionId]      INT IDENTITY(1, 1) NOT NULL,
        [Name]          NVARCHAR(100) NOT NULL,
        [CreatedOn]     DATETIME2 NOT NULL
    )
    ;
