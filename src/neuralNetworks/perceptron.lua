local perceptron = {}

perceptron.__index = perceptron

--constructor
--will generate random weights
function perceptron.new(inputNum, learningRate)  
	local newPercpt = {}
	setmetatable(newPercpt,perceptron)
	if learningRate then --learningRate is optional
		newPercpt.lr = learningRate
	else --(0.1 is default, setting the learningRate too fast will cause overreaching
		newPercpt.lr = 0.1
	end
	--generate our first random weights
	newPercpt.weights = newPercpt:_randomweights(inputNum)
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
	return tempTable
end

--given inputArray of same length weights array
--modify weights based on error
function perceptron:train(inputArray, output)
	local curChoice = self:sumCalc(inputArray) --make choice based on current weights
	local err = output - curChoice
	
	--adjust weights according to float input and real err
	for i = 1, #self.weights do
		self.weights[i] = (err * inputArray[i]) * self.lr
	end
end

--guess the output based on current weights
function perceptron:sumCalc(inputArray)
	local sum = 0
	for i = 1, #self.weights do
		sum = sum + (inputArray[i] * self.weights[i])
	end
	return self:activation(sum)
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

