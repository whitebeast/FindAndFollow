PRINT 'Populate CarBrandException table...'
DECLARE @tCarBrandException TABLE (ExceptionMask NVARCHAR(100))
;
--Ваз
INSERT INTO @tCarBrandException (ExceptionMask)
SELECT  N'%прицеп%' UNION ALL
SELECT  N'%техника%' UNION ALL
SELECT  N'%трансп%' 
;
INSERT INTO dbo.CarBrandException
    (
	    ExceptionMask
    )
SELECT  t.ExceptionMask
FROM @tCarBrandException t
LEFT JOIN dbo.CarBrandException AS cmm 
    ON  cmm.ExceptionMask = t.ExceptionMask
WHERE cmm.ExceptionMask IS NULL
;    
	       