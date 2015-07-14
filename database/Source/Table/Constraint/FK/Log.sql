ALTER TABLE dbo.[Log] 
ADD CONSTRAINT fkLog_User 
FOREIGN KEY (UserId) 
REFERENCES dbo.[User] (UserId) 
