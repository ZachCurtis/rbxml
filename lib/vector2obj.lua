[[
Dec 2017
Zach Curtis AKA InfinityDesign
Simple Vector2obj with metadata for use in linear regression
vector2obj.data, vector2obj.answer, vector2obj.bias
]]

local vector2obj = {}

vector2obj._index = vector2obj

function vector2obj.new(maxX,maxY)
	local v2new = {}
	setmetatable(v2new, vector2obj)
	v2new.bias = 1 --constant bias 
	
	v2new.data = {math.random() * math.random(-maxX, maxX),math.random() * math.random(-maxY, -maxY)}
	if v2new.data[1] > v2new.data[2] then
		v2new.answer = 1
	else
		v2new.answer = -1
	end
	
	return v2new
end

return vector2obj
