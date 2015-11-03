ALTER TABLE dbo.Car 
    ADD CONSTRAINT fkCar_CarModel 
    FOREIGN KEY (CarModelId) 
    REFERENCES dbo.CarModel (CarModelId) 
GO

ALTER TABLE dbo.Car 
    ADD CONSTRAINT fkCar_Site 
    FOREIGN KEY (SiteId) 
    REFERENCES dbo.Site (SiteId) 
GO

ALTER TABLE dbo.Car 
    ADD CONSTRAINT fkCar_Color 
    FOREIGN KEY (ColorId) 
    REFERENCES dbo.Color (ColorId) 
GO

ALTER TABLE dbo.Car 
    ADD CONSTRAINT fkCar_Place 
    FOREIGN KEY (PlaceId) 
    REFERENCES dbo.Place (PlaceId) 
GO