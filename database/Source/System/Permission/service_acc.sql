CREATE LOGIN service_acc 
WITH PASSWORD = 'service_acc';
GO

ALTER LOGIN service_acc WITH DEFAULT_DATABASE = FindAndFollow
GO

USE FindAndFollow
CREATE USER service_acc FOR LOGIN service_acc
WITH DEFAULT_SCHEMA = dbo;
GO

GRANT CONNECT TO service_acc
GO

GRANT EXECUTE TO service_acc
GO

GRANT SELECT ON dbo.DecodeCyrillicJSON TO service_acc 
GO

GRANT SELECT ON dbo.ParseJSON TO service_acc
GO

/*
USE FindAndFollow
DROP USER service_acc
GO

DROP LOGIN service_acc
GO 

 */