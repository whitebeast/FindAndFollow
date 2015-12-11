ALTER TABLE dbo.Car
ADD CONSTRAINT ckCar_BodyType CHECK (BodyType >= 0 AND BodyType <= 12);
GO

ALTER TABLE dbo.Car
ADD CONSTRAINT ckCar_EngineType CHECK (EngineType >= 0 AND EngineType <= 6);
GO

ALTER TABLE dbo.Car
ADD CONSTRAINT ckCar_TransmissionType CHECK (TransmissionType >= 0 AND TransmissionType <= 2);
GO

ALTER TABLE dbo.Car
ADD CONSTRAINT ckCar_DriveType CHECK (DriveType >= 0 AND DriveType <= 3);
GO

ALTER TABLE dbo.Car
ADD CONSTRAINT ckCar_Condition CHECK (Condition >= 0 AND Condition <= 3);
GO

ALTER TABLE dbo.Car
ADD CONSTRAINT ckCar_SellerType CHECK (SellerType >= 0 AND SellerType <= 3);
GO
