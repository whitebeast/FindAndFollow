﻿PRINT '---- Start Post-Deployment script----'
GO
SET NOCOUNT ON
GO
USE [$(msdb)]
GO
:r .\System\SQLJob\GetDailyCurrencyRates.sql
GO
:r .\System\Permission\service_acc.sql
GO
USE [$(FindAndFollow)]
GO
:r .\Script\PostDeployment\CurrencyInitial.sql 
GO
:r .\Script\PostDeployment\CarParsingSettingsInitial.sql 
GO
:r .\Script\PostDeployment\ColorInitial.sql 
GO
:r .\Script\PostDeployment\CarBrandModelInitial.sql 
GO
:r .\Script\PostDeployment\CarBrandExceptionInitial.sql 
GO
:r .\Script\PostDeployment\CarBrandMappingInitial.sql 
GO
:r .\Script\PostDeployment\CarModelMappingInitial.sql 
GO
:r .\Script\PostDeployment\BelarusCityAndRegionInitial.sql 
GO
:r .\Script\PostDeployment\RussiaCityAndRegionInitial.sql 
GO
:r .\Script\PostDeployment\SiteInitial.sql 
GO
PRINT '---- End Post-Deployment script----'
GO
