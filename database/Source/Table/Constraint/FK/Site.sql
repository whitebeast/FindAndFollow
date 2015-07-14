ALTER TABLE dbo.Site 
ADD CONSTRAINT fkSite_Country 
FOREIGN KEY (CountryId) 
REFERENCES dbo.[Country] (CountryId) 