CREATE VIEW [dbo].[vwCarDuplicatePhone]
AS 
SELECT  Phone1 AS Phone, 
        COUNT(*) AS CarCount
FROM    dbo.vwCar
WHERE   Phone1 IS NOT NULL
    AND SellerType <> 'Autohaus' 
GROUP BY Phone1 
HAVING  COUNT(*) > 1
