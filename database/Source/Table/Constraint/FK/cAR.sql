ALTER TABLE dbo.Car 
    ADD CONSTRAINT fkCar_Brand 
    FOREIGN KEY (CarBrandId) 
    REFERENCES dbo.CarBrand (CarBrandId) 
GO

ALTER TABLE dbo.Car 
    ADD CONSTRAINT fkCar_Place 
    FOREIGN KEY (PlaceId) 
    REFERENCES dbo.Place (PlaceId) 
GO

ALTER TABLE dbo.Car 
    ADD CONSTRAINT fkCar_Color 
    FOREIGN KEY (ColorId) 
    REFERENCES dbo.Color (ColorId) 
GO

ALTER TABLE dbo.Car 
    ADD CONSTRAINT fkCar_OptionSet 
    FOREIGN KEY (OptionSetId) 
    REFERENCES dbo.OptionSet (OptionSetId) 
GO