CREATE FUNCTION [dbo].[MappingModel]
(
    @pString NVARCHAR(100)
)
RETURNS NVARCHAR(100)
AS
BEGIN
    RETURN CASE 
               WHEN @pString LIKE N'A4 %' THEN N'A4' 
               ELSE @pString
           END
END
