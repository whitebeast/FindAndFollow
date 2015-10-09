﻿CREATE TABLE [dbo].[CarParsingSettings]
(
    CarParsingSettingsId    INT NOT NULL IDENTITY(1,1),
    CurrentId               INT NOT NULL,
    CarBrandXPath           NVARCHAR(1000) NULL,
    ModelXPath              NVARCHAR(1000) NULL,
    SiteUrlXPath            NVARCHAR(1000) NULL,
    PriceXPath              NVARCHAR(1000) NULL,
    BodyTypeXPath           NVARCHAR(1000) NULL,
    ModelYearXPath          NVARCHAR(1000) NULL,
    EngineTypeXPath         NVARCHAR(1000) NULL,
    EngineSizeXPath         NVARCHAR(1000) NULL,
    TransmissionTypeXPath   NVARCHAR(1000) NULL,
    DriveTypeXPath          NVARCHAR(1000) NULL,
    ConditionXPath          NVARCHAR(1000) NULL,
    MileageXPath            NVARCHAR(1000) NULL,
    ColorXPath              NVARCHAR(1000) NULL,
    SellerTypeXPath         NVARCHAR(1000) NULL,
    IsCustomsClearedXPath   NVARCHAR(1000) NULL,
    IsSwapXPath             NVARCHAR(1000) NULL,
    DescriptionXPath        NVARCHAR(1000) NULL,
    PageCreatedOnXPath      NVARCHAR(1000) NULL,
)