ALTER TABLE dbo.CarModel
ADD CONSTRAINT fkCarModel_CarBrand
FOREIGN KEY (CarBrandId) 
REFERENCES dbo.[CarBrand] (CarBrandId) 
