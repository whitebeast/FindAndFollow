﻿ALTER TABLE dbo.Car ADD CONSTRAINT dfCar_CreatedOn DEFAULT GETUTCDATE() FOR CreatedOn;
GO
ALTER TABLE dbo.Car ADD CONSTRAINT dfCar_IsActive DEFAULT 1 FOR IsActive;
GO
