﻿ALTER TABLE dbo.CarParsing ADD CONSTRAINT dfCarParsing_CreatedOn DEFAULT GETUTCDATE() FOR CreatedOn
ALTER TABLE dbo.CarParsing ADD CONSTRAINT dfCarParsing_PageStatusId DEFAULT 1 FOR PageStatusId
