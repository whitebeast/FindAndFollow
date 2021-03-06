﻿CREATE UNIQUE NONCLUSTERED INDEX [ixPlace_CityId_CountryId_RegionId] ON [dbo].[Place]
(
    [CityId] ASC,
    [CountryId] ASC,
    [RegionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
