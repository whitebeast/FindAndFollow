ALTER TABLE dbo.Search 
ADD CONSTRAINT fkSearch_User 
FOREIGN KEY (UserId) 
REFERENCES dbo.[User] (UserId) 
