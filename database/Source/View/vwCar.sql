CREATE VIEW [dbo].[vwCar]
	AS 
	SELECT 
			CarId             
			CarBrandId,        
			Model,             
			Price,             
			BodyType,          
			ModelYear,         
			EngineType,        
			EngineSize,        
			TransmissionType,  
			DriveType,         
			Condition,         
			Mileage,           
			ColorId,           
			SellerType,        
			IsCustomsCleared,  
			IsSwap,            
			Description,       
			OptionSetId       
	FROM Car
