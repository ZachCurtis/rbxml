--[[
Dec 2017
Zach Curtis AKA InfinityDesign

very basic linear regression implementation
using least squares output = constant slope * input + regression coefficient 
(y = b0x + b1/y = mx + b)

]]--

local perceptron = {}

perceptron.__index = perceptron

--constructor
--will generate random weights
function perceptron.new(inputNum, learningRate)
	local newPercpt = {}
	setmetatable(newPercpt,perceptron)
	if learningRate then --learningRate is optional
		newPercpt.lr = learningRate
	else --(0.01 is default, setting the learningRate too fast will cause overreaching
		newPercpt.lr = 0.01
	end
	--generate our first random weights
	newPercpt:_randomweights(inputNum)
	
	return newPercpt
end

--generate random weights for our untrained/unlearned perceptron
function perceptron:_randomweights(num)
	math.randomseed(tick()) --classic random number problem. randomseeding tick works in our case because we only randomize weights once.
	local tempTable = {}
	for i = 1, num do
		local ranWeight = math.random()
		local negDetermine = math.random()
		if negDetermine < 0.5 then
			ranWeight = ranWeight * -1
			table.insert(tempTable, ranWeight)
		else
			table.insert(tempTable, ranWeight)
		end
	end
	--set weights
	self.weights = tempTable
end

--given inputArray of same length weights array
--modify weights based on error
function perceptron:train(inputArray, output)
	local guess = self:feedForward(inputArray) --make choice based on current weights
	local err = output - guess
	--adjust weights according to float input and real err
	for i = 1, #self.weights do
		self.weights[i] = self.weights[i] + ((self.lr * err * inputArray[i]))
	end
end

--guess the output based on current weights
function perceptron:feedForward(inputArray)
	local sum = 0
	for i = 1, #self.weights do
		local scaled = inputArray[i] * self.weights[i]
		sum = sum + scaled
	end
	return self:activation(sum)
end

function perceptron:weighSlope(xMax, toDeg)
	local x1 = -xMax
	local y1 = (-self.weights[3] - self.weights[1] * x1)/self.weights[2]
	local x2 = xMax
	local y2 = (-self.weights[3] - self.weights[1] * x1)/self.weights[2]
	if toDeg then
		return math.tan((y2-y1)/(x2-x1))
	else
		return (y2-y1)/(x2-x1)
	end
end

--activation function
--currently a binary output 
function perceptron:activation(n)
	if n >= 0 then
		return 1
	else
		return -1
	end
end

return perceptron
