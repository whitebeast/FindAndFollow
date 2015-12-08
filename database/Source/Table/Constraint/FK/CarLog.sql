ALTER TABLE dbo.CarLog
    ADD CONSTRAINT fkCarLog_Car
    FOREIGN KEY (CarId) 
    REFERENCES dbo.Car (CarId) 
GO
