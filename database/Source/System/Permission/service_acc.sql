PRINT 'Create service_acc user and login...'
IF NOT EXISTS 
    (
        SELECT name  
        FROM master.sys.server_principals
        WHERE name = 'service_acc'
    )
BEGIN
    CREATE LOGIN service_acc 
    WITH PASSWORD = 'service_acc',
    CHECK_EXPIRATION=OFF, 
    CHECK_POLICY=OFF 
END
GO

USE [$(FindAndFollow)]
IF NOT EXISTS
    (
        SELECT name
        FROM sys.database_principals
        WHERE name = 'service_acc'
    )
BEGIN
    CREATE USER service_acc FOR LOGIN service_acc
    WITH DEFAULT_SCHEMA = dbo;

    GRANT CONNECT TO service_acc

    GRANT EXECUTE TO service_acc

    GRANT SELECT ON dbo.DecodeCyrillicJSON TO service_acc 

    GRANT SELECT ON dbo.ParseJSON TO service_acc

    GRANT SELECT ON dbo.vwCarActive TO service_acc
END
GO

ALTER LOGIN service_acc WITH DEFAULT_DATABASE = FindAndFollow
GO

/*
USE FindAndFollow
DROP USER service_acc
GO

DROP LOGIN service_acc
GO 

 */