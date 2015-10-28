CREATE PROCEDURE dbo.CarParsingInsert
    (
        @pCarBrand          NVARCHAR(1000),
	    @pModel             NVARCHAR(1000),
	    @pSiteId            NVARCHAR(50),
        @pSiteURL           NVARCHAR(2000),
	    @pPrice             NVARCHAR(1000),
	    @pBodyType          NVARCHAR(1000),
	    @pModelYear         NVARCHAR(1000),
	    @pEngineType        NVARCHAR(200),
	    @pEngineSize        NVARCHAR(1000),
	    @pTransmissionType  NVARCHAR(1000),
	    @pDriveType         NVARCHAR(1000),
	    @pCondition         NVARCHAR(10),
	    @pMileage           NVARCHAR(1000),
	    @pColor             NVARCHAR(100),
	    @pSellerType        NVARCHAR(100),
	    @pIsSwap            NVARCHAR(100),
	    @pDescription       NVARCHAR(2000),
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
                    PageCreatedOn,
                    IsPageExist
                )
            SELECT
                    @pCarBrand,
                    @pModel,
                    @pSiteId,
                    @pSiteURL,
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
