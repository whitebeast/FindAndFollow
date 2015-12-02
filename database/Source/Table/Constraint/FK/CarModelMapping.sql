ALTER TABLE dbo.CarModelMapping
    ADD CONSTRAINT fkCarModelMapping_CarModel 
    FOREIGN KEY (CarModelId) 
    REFERENCES dbo.CarModel (CarModelId) 
GO

ALTER TABLE dbo.CarModelMapping
    ADD CONSTRAINT fkCarModelMapping_CarBrand 
    FOREIGN KEY (CarBrandId) 
    REFERENCES dbo.CarBrand (CarBrandId) 
GO
