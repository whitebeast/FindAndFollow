DECLARE @xml XML 
SET @xml = '
<Search>
    <ModelBrand>
        <ModelBrandId BrandId ="1" ModelId = "2"> </ModelBrandId>
        <ModelBrandId BrandId ="1" ModelId = "3"> </ModelBrandId>
        <ModelBrandId BrandId ="3" ModelId = "5"> </ModelBrandId>
    </ModelBrand>
    <PlaceId>1</PlaceId>
    <PriceMin>1000</PriceMin>
    <PriceMax>2000</PriceMax>
    <BodyType>
        <BodyTypeId>1</BodyTypeId>
        <BodyTypeId>9</BodyTypeId>
    </BodyType>
    <EngineType>
        <EngineTypeId>3</EngineTypeId>
        <EngineTypeId>4</EngineTypeId>
        <EngineTypeId>1</EngineTypeId>
    </EngineType>
    <YearMin>1998</YearMin>
    <YearMax>2010</YearMax>
    <EngineSizeMin>1600</EngineSizeMin>
    <EngineSizeMax>1800</EngineSizeMax>
    <TransmissionType>
        <TransmissionTypeId>1</TransmissionTypeId>
    </TransmissionType>
    <DriveType>
        <DriveTypeId>1</DriveTypeId>
    </DriveType>
    <ConditionType>
        <ConditionTypeId>1</ConditionTypeId>
    </ConditionType>
    <Mileage>100000</Mileage>
    <Color>
        <ColorId>1</ColorId>
        <ColorId>2</ColorId>
        <ColorId>5</ColorId>
        <ColorId>12</ColorId>
    </Color>
    <SellerType>
        <SellerTypeId>1</SellerTypeId>
    </SellerType>
    <IsSwap>False</IsSwap>
    <IsCustomsCleared>True</IsCustomsCleared>
</Search>
' 

SELECT 
   b.value('@BrandId','INT') AS CarModelId,
   b.value('@ModelId','INT') AS CarBrandId,
   a.value('PlaceId[1]','INT') AS PlaceId,
   a.value('PriceMin[1]','INT') AS PriceMin,
   a.value('PriceMax[1]','INT') AS PriceMax,
   c.value('.','INT') AS BodyTypeId,
   d.value('.','INT') AS EngineTypeId,
   a.value('YearMin[1]','INT') AS YearMin,
   a.value('YearMax[1]','INT') AS YearMax,
   a.value('EngineSizeMin[1]','INT') AS EngineSizeMin,
   a.value('EngineSizeMax[1]','INT') AS EngineSizeMax,
   e.value('.','INT') AS TransmissionTypeId,
   f.value('.','INT') AS DriveTypeId,
   g.value('.','INT') AS ConditionTypeId,
   a.value('Mileage[1]','INT') AS Mileage,
   h.value('.','INT') AS ColorId,
   j.value('.','INT') AS SellerTypeId,
   a.value('IsSwap[1]','BIT') AS IsSwap,
   a.value('IsCustomsCleared[1]','BIT') AS IsCustomsCleared
FROM @XML.nodes('/Search') AS Search(a)	
CROSS APPLY @xml.nodes('/Search/ModelBrand/ModelBrandId') CarModel(b)
CROSS APPLY @xml.nodes('/Search/BodyType/*') BodyType(c)
CROSS APPLY @xml.nodes('/Search/EngineType/*') EngineType(d)
CROSS APPLY @xml.nodes('/Search/TransmissionType/*') TransmissionType(e)
CROSS APPLY @xml.nodes('/Search/DriveType/*') DriveType(f)
CROSS APPLY @xml.nodes('/Search/ConditionType/*') ConditionType(g)
CROSS APPLY @xml.nodes('/Search/Color/*') Color(h)
CROSS APPLY @xml.nodes('/Search/SellerType/*') SellerType(j)
