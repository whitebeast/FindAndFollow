ALTER TABLE dbo.Subscription
ADD CONSTRAINT ckSubscription_Type CHECK (Type >= 1 AND Type <= 2);
GO

