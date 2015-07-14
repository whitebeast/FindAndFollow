ALTER TABLE dbo.SearchCar 
ADD CONSTRAINT fkSearchCar_Search 
FOREIGN KEY (SearchId) 
REFERENCES dbo.[Search] (SearchId) 
GO

ALTER TABLE dbo.SearchCar 
ADD CONSTRAINT fkSearchCar_Car 
FOREIGN KEY (CarId) 
REFERENCES dbo.[Car] (CarId) 
GO