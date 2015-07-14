ALTER TABLE dbo.OptionSet 
ADD CONSTRAINT fkOptionSet_Option
FOREIGN KEY (OptionId) 
REFERENCES dbo.[Option] (OptionId) 
