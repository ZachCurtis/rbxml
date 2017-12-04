--[[
Dec 2017
Zach Curtis AKA InfinityDesign
Simple Vector2obj with metadata for use in linear regression
vector2obj.data, vector2obj.answer, vector2obj.bias
]]--

local vector2obj = {}

vector2obj.__index = vector2obj

function vector2obj.new(maxX,maxY)
	local v2new = {}
	setmetatable(v2new, vector2obj)
	v2new.m = _G.slope
	v2new.b = _G.yInter
	v2new.data = {math.random() * math.random(-maxX, maxX),math.random() * math.random(-maxY, maxY), 1} --index 3 is a bias towards constant 1 or true using step method
	wait()	
	v2new:calculateAnswer(v2new.data[1])
	
	return v2new
end

function vector2obj:getDataForPerceptron()
	local range = (200 - -200)
	local newRange = 2
	local x1 = (((self.data[1] - -200) * 2) / range) +-1
	local y1 = (((self.data[2] - -200) * 2) / range) +-1
	return {x1, y1, 1}
end

function vector2obj:calculateAnswer(x)
	local yLine = self.m * x + self.b
	if self.data[2] > yLine then
		self.answer = 1
	else
		self.answer = -1
	end
end

return vector2obj
