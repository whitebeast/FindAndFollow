﻿ALTER TABLE dbo.Region
ADD CONSTRAINT pkRegion PRIMARY KEY CLUSTERED   
(
    RegionId  ASC
) WITH (ONLINE = ON, 
    PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, 
    ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
