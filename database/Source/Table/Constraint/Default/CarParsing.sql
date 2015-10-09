ALTER TABLE dbo.CarParsing ADD CONSTRAINT dfCarParsing_UploadDate DEFAULT GETUTCDATE() FOR UploadDate
