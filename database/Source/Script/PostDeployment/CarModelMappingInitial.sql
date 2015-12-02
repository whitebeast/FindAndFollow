PRINT 'Populate CarModelMapping table...'
DECLARE @tMask TABLE (Mask VARCHAR(100), CarBrand NVARCHAR(100), NotMask VARCHAR(100)) 
;
DECLARE @tCarModelMapping TABLE (ModelMask VARCHAR(100), ModelNotMask VARCHAR(100), CarBrandId INT, CarModelId INT)
;
INSERT INTO @tMask
    --Audi
    SELECT N'A4%',N'Audi','' UNION ALL
    SELECT N'A6%',N'Audi','' UNION ALL
    --BMW
    SELECT N'1%',N'BMW','' UNION ALL
    SELECT N'2%',N'BMW','' UNION ALL
    SELECT N'3%',N'BMW','' UNION ALL
    SELECT N'4%',N'BMW','' UNION ALL
    SELECT N'5%',N'BMW','' UNION ALL
    SELECT N'6%',N'BMW','' UNION ALL
    SELECT N'7%',N'BMW','' UNION ALL
    SELECT N'8%',N'BMW','' UNION ALL
    --Citroen
    SELECT N'C5%',N'Citroen','' UNION ALL
    --Opel
    SELECT N'Astra%',N'Opel','' UNION ALL
    --Renault
    SELECT N'Scenic%',N'Renault','' UNION ALL
    SELECT N'Laguna%',N'Renault','' UNION ALL
    --Mercedes
    SELECT N'A%',N'Mercedes','' UNION ALL
    SELECT N'B%',N'Mercedes','' UNION ALL
    SELECT N'C%',N'Mercedes','CL%' UNION ALL
    SELECT N'CL%',N'Mercedes','CL[a-Z]%' UNION ALL
    SELECT N'CLA%',N'Mercedes','' UNION ALL
    SELECT N'CLC%',N'Mercedes','' UNION ALL
    SELECT N'CLK%',N'Mercedes','' UNION ALL
    SELECT N'CLS%',N'Mercedes','' UNION ALL
    SELECT N'E%',N'Mercedes','' UNION ALL
    SELECT N'G%',N'Mercedes','GL%' UNION ALL
    SELECT N'GL%',N'Mercedes','GL[a-Z]%' UNION ALL
    SELECT N'GLA%',N'Mercedes','' UNION ALL
    SELECT N'GLC%',N'Mercedes','' UNION ALL
    SELECT N'GLK%',N'Mercedes','' UNION ALL
    SELECT N'ML%',N'Mercedes','' UNION ALL
    SELECT N'R%',N'Mercedes','' UNION ALL
    SELECT N'S%',N'Mercedes','S[a-Z]%' UNION ALL
    SELECT N'SL%',N'Mercedes','SL[a-Z]%' UNION ALL
    SELECT N'SLR%',N'Mercedes','' UNION ALL
    SELECT N'SLS%',N'Mercedes','' UNION ALL
    SELECT N'SLK%',N'Mercedes','' UNION ALL
    SELECT N'V%',N'Mercedes','V[a-Z]%' UNION ALL
    SELECT N'T1%',N'Mercedes','' UNION ALL
    SELECT N'T2%',N'Mercedes','' UNION ALL
    --Toyota
    SELECT N'Carina%',N'Toyota','' UNION ALL
    --Volkswagen
    SELECT N'Golf%',N'Volkswagen','%Plus%' UNION ALL 
    SELECT N'Passat%',N'Volkswagen','%CC%' UNION ALL
    SELECT N'T1%',N'Volkswagen','' UNION ALL
    SELECT N'T2%',N'Volkswagen','' UNION ALL
    SELECT N'T3%',N'Volkswagen','' UNION ALL
    SELECT N'T4%',N'Volkswagen','' UNION ALL
    SELECT N'T5%',N'Volkswagen','' 
;
INSERT INTO @tCarModelMapping
    (
	    ModelMask,
	    ModelNotMask,
        CarBrandId,
	    CarModelId
    )
SELECT  t.Mask, 
        t.NotMask, 
        cb.CarBrandId,
        cm.CarModelId 
FROM dbo.CarBrand AS cb
JOIN dbo.CarModel AS cm ON cm.CarBrandId = cb.CarBrandId
JOIN @tMask t ON t.CarBrand = cb.Name AND cm.Name LIKE t.Mask AND cm.Name NOT LIKE t.NotMask
;
INSERT INTO dbo.CarModelMapping
    (
	    ModelMask,
	    ModelNotMask,
        CarBrandId,
	    CarModelId
    )
SELECT  t.ModelMask,
	    t.ModelNotMask,
        t.CarBrandId,
	    t.CarModelId
FROM @tCarModelMapping t
LEFT JOIN dbo.CarModelMapping AS cmm 
    ON  cmm.ModelMask = t.ModelMask
    AND cmm.ModelNotMask = t.ModelNotMask
    AND cmm.CarBrandId = t.CarBrandId
    AND cmm.CarModelId = t.CarModelId
WHERE cmm.CarModelMappingId IS NULL
;    
	       