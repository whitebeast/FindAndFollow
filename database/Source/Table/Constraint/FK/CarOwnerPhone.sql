ALTER TABLE dbo.CarOwnerPhone 
    ADD CONSTRAINT fkCarOwnerPhone_Car
    FOREIGN KEY (CarId) 
    REFERENCES dbo.Car (CarId) 
GO