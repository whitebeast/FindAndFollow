ALTER TABLE dbo.Car
ADD CONSTRAINT ckCar_BodyType CHECK (BodyType >= 1 AND BodyType <= 9);
GO

ALTER TABLE dbo.Car
ADD CONSTRAINT ckCar_EngineType CHECK (EngineType >= 1 AND EngineType <= 6);
GO

ALTER TABLE dbo.Car
ADD CONSTRAINT ckCar_DriveType CHECK (DriveType >= 1 AND DriveType <= 3);
GO

ALTER TABLE dbo.Car
ADD CONSTRAINT ckCar_Condition CHECK (Condition >= 1 AND Condition <= 3);
GO

ALTER TABLE dbo.Car
ADD CONSTRAINT ckCar_SellerType CHECK (SellerType >= 1 AND SellerType <= 3);
GO
