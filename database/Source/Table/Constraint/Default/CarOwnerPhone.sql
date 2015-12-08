ALTER TABLE dbo.CarOwnerPhone ADD CONSTRAINT dfCarOwnerPhone_CreatedOn DEFAULT GETUTCDATE() FOR CreatedOn
GO
ALTER TABLE dbo.CarOwnerPhone ADD CONSTRAINT dfCarOwnerPhone_IsActual DEFAULT 1 FOR IsActual
GO