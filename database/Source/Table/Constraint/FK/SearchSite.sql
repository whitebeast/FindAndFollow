ALTER TABLE dbo.SearchSite 
ADD CONSTRAINT fkSearchSite_Search 
FOREIGN KEY (SearchId) 
REFERENCES dbo.[Search] (SearchId) 
GO

ALTER TABLE dbo.SearchSite 
ADD CONSTRAINT fkSearchSite_Site 
FOREIGN KEY (SiteId) 
REFERENCES dbo.[Site] (SiteId) 
GO