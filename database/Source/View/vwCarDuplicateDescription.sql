CREATE VIEW [dbo].[vwCarDuplicateDescription]
AS
SELECT  LEFT(Description,100) AS Description, 
        Phone1 AS Phone, 
        COUNT(*) AS CarCount
FROM    dbo.vwCar
WHERE   ISNULL(LEFT(Description,100),'') <> '' 
GROUP BY LEFT(Description,100),Phone1
HAVING  COUNT(*) > 1