﻿ALTER TABLE dbo.SearchSite
ADD CONSTRAINT pkSearchSite PRIMARY KEY CLUSTERED   
(
    SearchSiteId  ASC
) WITH (ONLINE = ON, 
    PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, 
    ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
