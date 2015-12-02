ALTER TABLE dbo.CarBrandMapping
    ADD CONSTRAINT fkCarBrandMapping_CarBrand 
    FOREIGN KEY (CarBrandId) 
    REFERENCES dbo.CarBrand (CarBrandId) 
GO
