﻿CREATE UNIQUE NONCLUSTERED INDEX [ixCarOwnerPhone_CarId_Phone] ON [dbo].[CarOwnerPhone]
(
    [CarId] ASC,
    [Phone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)