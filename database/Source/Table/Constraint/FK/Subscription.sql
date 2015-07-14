ALTER TABLE dbo.Subscription 
ADD CONSTRAINT fkSubscription_User 
FOREIGN KEY (UserId) 
REFERENCES dbo.[User] (UserId) 
