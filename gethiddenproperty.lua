gethiddenproperty = function(object: Instance, property: string): (any, boolean)
	local Success1, Check1 = pcall(function()
		return object[property]
	end)
	
	if Success1 then
		return Check1, false -- property is not hidden
	else
		local Success2, Check2 = pcall(function()
			return game:GetService("UGCValidationService"):GetPropertyValue(object, property)
		end)
		
		if Success2 then
			return Check2, true -- property is hidden
		else
			error("Property " .. property .. " does not exist in instance " .. tostring(object) .. ".") -- property does not exist
		end
	end
end
