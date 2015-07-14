ALTER TABLE dbo.Place 
ADD CONSTRAINT fkPlace_Country 
FOREIGN KEY (CountryId) 
REFERENCES dbo.[Country] (CountryId) 
GO
  
ALTER TABLE dbo.Place 
ADD CONSTRAINT fkPlace_Region 
FOREIGN KEY (RegionId) 
REFERENCES dbo.[Region] (RegionId) 
GO

ALTER TABLE dbo.Place 
ADD CONSTRAINT fkPlace_City 
FOREIGN KEY (CityId) 
REFERENCES dbo.[City] (CityId) 
GO