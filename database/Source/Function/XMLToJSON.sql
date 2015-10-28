CREATE FUNCTION [dbo].[XMLToJSON]
(
    @pXML XML
)
RETURNS VARCHAR(MAX)
AS
BEGIN
    RETURN 
        '[' + CHAR(10) +
        REVERSE(STUFF(REVERSE( 
                (SELECT STUFF(  
                  (SELECT * FROM  
                    (SELECT '    {'+  
                      STUFF((SELECT ',"'+COALESCE(b.c.value('local-name(.)', 'NVARCHAR(MAX)'),'')+'":"'+
                                    b.c.value('text()[1]','NVARCHAR(MAX)') +'"'
                             FROM x.a.nodes('*') b(c)  
                             FOR XML PATH(''),TYPE).value('(./text())[1]','NVARCHAR(MAX)')
                        ,1,1,'')+'},' + CHAR(10)
                   FROM @pXML.nodes('/root/*') x(a)  
                   ) JSON(theLine)  
                  FOR XML PATH(''),TYPE).value('.','NVARCHAR(MAX)' )
                ,2,0,''))
            ),2,1,'')) 
        + ']'
END
