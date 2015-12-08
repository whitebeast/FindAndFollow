CREATE TABLE [dbo].[CarLog]
(
    [CarLogId] INT NOT NULL IDENTITY(1,1),
    [CarId] INT,
    [Price] MONEY, 
    [Mileage] INT, 
    [SellerType] TINYINT, 
    [Description] NVARCHAR(4000), 
    [PageCreatedOn] DATETIME2,
    [CreatedOn] DATETIME2
)
