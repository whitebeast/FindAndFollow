CREATE PROCEDURE dbo.CarParsingInsert
    (
        @pCarBrand          NVARCHAR(1000),
	    @pModel             NVARCHAR(1000),
	    @pSiteUrl           NVARCHAR(2000),
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
	    @pIsCustomsCleared  NVARCHAR(100),
	    @pIsSwap            NVARCHAR(100),
	    @pDescription       NVARCHAR(2000),
	    @pCreatedOn         NVARCHAR(100),
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
                    IsCustomsCleared,
                    IsSwap,
                    [Description],
                    CreatedOn,
                    IsPageExist
                )
            SELECT
                    @pCarBrand,
                    @pModel,
                    @pSiteUrl,
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
                    @pIsCustomsCleared,
                    @pIsSwap,
                    @pDescription,
                    @pCreatedOn,
                    @pIsPageExist
            ;
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        EXECUTE dbo.ErrorInfoGet;
        -- If we have an open transaction and this sproc opened it then rollback to the save point, unless the
        -- transaction is doomed. If it is doomed then rollback all transactions if there are no previous transactions.
        IF (XACT_STATE() = 1) AND (@@TRANCOUNT > 0) ROLLBACK TRANSACTION;
        ELSE IF (XACT_STATE() = -1) AND (@@TRANCOUNT = 0) ROLLBACK TRANSACTION;
    END CATCH
END
