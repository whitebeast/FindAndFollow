ALTER TABLE dbo.CarImage 
ADD CONSTRAINT fkCarImage_Car 
FOREIGN KEY (CarId) 
REFERENCES dbo.[Car] (CarId) 
