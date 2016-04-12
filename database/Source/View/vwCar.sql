CREATE VIEW [dbo].[vwCar]
ALTER VIEW [dbo].[vwCar]
    AS 
    SELECT 
	       c.CarId
          ,cb.Name AS CarBrand
          ,c.OriginalCarBrand
          ,cm.Name AS CarModel
          ,c.OriginalCarModel
          ,s.SiteUrl
          ,c2.Name AS Country
          ,r.Name AS Region
          ,c3.Name AS City
          ,c.Price
          ,c.Price / cr.Rate AS USDPrice
          ,CASE c.BodyType 
            WHEN 1 THEN 'Sedan'
            WHEN 2 THEN 'Wagon'
            WHEN 3 THEN 'Hatchback'
            WHEN 4 THEN 'Minivan'
            WHEN 5 THEN 'SUV'
            WHEN 6 THEN 'Coupe'
            WHEN 7 THEN 'Cabriolet'
            WHEN 8 THEN 'Minibus'
            WHEN 9 THEN 'Van'
            WHEN 10 THEN 'Pickup'
            WHEN 11 THEN 'Roadster'
            WHEN 12 THEN 'Bus'
            WHEN 0 THEN 'Other'
            ELSE NULL
           END AS BodyType
          ,c.ModelYear
          ,CASE c.EngineType
            WHEN 1 THEN 'Petrol'
            WHEN 2 THEN 'Diesel'
            WHEN 3 THEN 'Gas'
            WHEN 4 THEN 'Hybrid (petrol)'
            WHEN 5 THEN 'Hybrid (diesel)'
            WHEN 6 THEN 'Electric'
            WHEN 0 THEN 'Other'
            ELSE NULL
           END AS EngineType
          ,c.EngineSize
          ,CASE c.TransmissionType
            WHEN 1 THEN 'Automatic'
            WHEN 2 THEN 'Manual'
            WHEN 0 THEN 'Other'
            ELSE NULL
           END AS TransmissionType
          ,CASE c.DriveType
            WHEN 1 THEN 'FWD'
            WHEN 2 THEN 'RWD'
            WHEN 3 THEN '4x4'
            WHEN 0 THEN 'Other'
            ELSE NULL
           END AS DriveType
          ,CASE c.Condition
            WHEN 1 THEN 'New'
            WHEN 2 THEN 'Used'
            WHEN 3 THEN 'Wreck'
            WHEN 0 THEN 'Other'
            ELSE NULL
           END AS Condition
          ,c.Mileage
          ,c4.Name AS Color
          ,CASE c.SellerType
            WHEN 1 THEN 'Private'
            WHEN 2 THEN 'Autohaus'
            WHEN 3 THEN 'Dieler'
            WHEN 0 THEN 'Other'
            ELSE NULL
           END AS SellerType
          ,cop.Phone1
          ,cop.Phone2
          ,cop.Phone3
          ,c.IsSwap
          ,c.Description
          ,c.OriginalURL
          ,c.PageCreatedOn
          ,f.StringValue AS CarImages
          ,c.OptionList
          ,c.CreatedOn
      FROM dbo.Car c
      JOIN dbo.CarModel AS cm ON cm.CarModelId = c.CarModelId
      JOIN dbo.CarBrand AS cb ON cb.CarBrandId = cm.CarBrandId
      JOIN dbo.[Site] AS s ON s.SiteId = c.SiteId
      JOIN dbo.Place AS p ON p.PlaceId = c.PlaceId
      JOIN dbo.Country AS c2 ON c2.CountryId = p.CountryId
      JOIN dbo.Region AS r ON r.RegionId = p.RegionId
      JOIN dbo.City AS c3 ON c3.CityId = p.CityId
      JOIN dbo.Color AS c4 ON c4.ColorId = c.ColorId
      LEFT JOIN   
          (   SELECT CarId, Phone1, Phone2, Phone3
              FROM (SELECT CarId, 'Phone'+CAST(ROW_NUMBER() OVER (PARTITION BY CarId ORDER BY CarId DESC) AS VARCHAR) AS PhoneId, Phone FROM dbo.CarOwnerPhone) x
              PIVOT (MAX(Phone) FOR PhoneId IN ([Phone1], [Phone2], [Phone3]) ) pvt
          ) AS cop ON cop.CarId = c.CarId
      LEFT JOIN dbo.CurrencyRate AS cr ON cr.CurrencyId = 145 AND cr.RateDate = CAST(GETDATE() AS DATE)
      CROSS APPLY dbo.ParseJSON(c.CarImages) f
      WHERE c.IsActive = 1
        AND f.NAME = 'ImageURL'
        AND f.Element_ID = 1