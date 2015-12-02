PRINT 'Populate CarBrandMapping table...'
DECLARE @tCarBrandMapping TABLE (BrandMask VARCHAR(100), CarBrandId INT)
;
INSERT INTO @tCarBrandMapping
    (
	    BrandMask,
        CarBrandId
    )
SELECT  N'Lada', 
        CarBrandId 
FROM    dbo.CarBrand 
WHERE   NAME = N'ВАЗ'
;
INSERT INTO dbo.CarBrandMapping
    (
	    BrandMask,
        CarBrandId
    )
SELECT  t.BrandMask,
        t.CarBrandId
FROM @tCarBrandMapping t
LEFT JOIN dbo.CarBrandMapping AS cmm 
    ON  cmm.BrandMask = t.BrandMask
    AND cmm.CarBrandId = t.CarBrandId
WHERE cmm.CarBrandMappingId IS NULL
;    
	       