ALTER TABLE dbo.CurrencyRate 
ADD CONSTRAINT fkCurrencyRate_Currency 
FOREIGN KEY (CurrencyId) 
REFERENCES dbo.Currency (CurrencyId) 
