CREATE VIEW [dbo].[vwCarBrandModel]
    AS 
    SELECT  cb.CarBrandId,
            cb.Name AS CarBrandName,
            cm.CarModelId,
            cm.Name AS CarModelName 
    FROM dbo.[CarBrand] cb
    JOIN dbo.[CarModel] cm ON cm.CarBrandId = cb.CarBrandId

/*
SELECT *
FROM vwCarBrandModel
WHERE CarBrandName = N''
*/