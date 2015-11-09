CREATE PROCEDURE dbo.CarParsingInsert
    (
        @pCarBrand          NVARCHAR(50),
        @pModel             NVARCHAR(50),
        @pSiteId            NVARCHAR(50),
        @pSiteURL           NVARCHAR(2000),
        @pCity              NVARCHAR(200),
        @pPrice             NVARCHAR(100),
        @pBodyType          NVARCHAR(100),
        @pModelYear         NVARCHAR(4),
        @pEngineType        NVARCHAR(100),
        @pEngineSize        NVARCHAR(5),
        @pTransmissionType  NVARCHAR(100),
        @pDriveType         NVARCHAR(100),
        @pCondition         NVARCHAR(100),
        @pMileage           NVARCHAR(100),
        @pColor             NVARCHAR(100),
        @pSellerType        NVARCHAR(100),
        @pIsSwap            CHAR(1),
        @pDescription       NVARCHAR(1000),
        @pOwnerPhone        NVARCHAR(100),
        @pPageCreatedOn     NVARCHAR(100),
        @pIsPageExist       BIT = 0
    )
AS
BEGIN    
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION
            INSERT INTO dbo.CarParsing
                (
                    CarBrand,
                    Model,
                    SiteId,
                    SiteUrl,
                    City,
                    Price,
                    BodyType,
                    ModelYear,
                    EngineType,
                    EngineSize,
                    TransmissionType,
                    DriveType,
                    Condition,
                    Mileage,
                    Color,
                    SellerType,
                    IsSwap,
                    [Description],
                    OwnerPhone,
                    PageCreatedOn,
                    IsPageExist
                )
            SELECT
                    @pCarBrand,
                    @pModel,
                    @pSiteId,
                    @pSiteURL,
                    @pCity,
                    @pPrice,
                    @pBodyType,
                    @pModelYear,
                    @pEngineType,
                    @pEngineSize,
                    @pTransmissionType,
                    @pDriveType,
                    @pCondition,
                    @pMileage,
                    @pColor,
                    @pSellerType,
                    @pIsSwap,
                    @pDescription,
                    @pOwnerPhone,
                    @pPageCreatedOn,
                    @pIsPageExist
            ;
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END

        EXECUTE dbo.ErrorLogInsert;
    END CATCH
END
