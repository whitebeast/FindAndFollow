CREATE VIEW [dbo].[vwCarActive]
    AS 
    SELECT  CarId, 
            OriginalURL 
    FROM    dbo.Car 
    WHERE   IsActive = 1
