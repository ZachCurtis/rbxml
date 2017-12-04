[[
roblox script object on server


simple automated example of a single perceptron calculating a binary result using linear regression
first is a simple single control calculation showcasing learning

secondly runs a new perceptron with a larger control set reusing same training data to showcase
the amount of errors before and after training

requires /src/nerualNetworks/perceptron.lua and /lib/vector2obj.lua as children module scripts
]]
local perceptron = require(script.perceptron) --stop calling methods on this
local v2obj = require(script.vector2obj)

function generateTestData(inputNum, amt, point) --point is Vector2 array of max sizes
	if inputNum == 2 then --vector2obj for ease of acess
		local macroData = {}
		for i = 1, amt do
			local dataPoint = v2obj.new(point[1], point[2])
			table.insert(macroData, dataPoint)
		end
		return macroData
	end
end


local inputs = {75,-23} --test inputs
print('single perceptron neural network testing')
print('we are training with 50 vector2 points in range (+/-100, +/-75)')
local testData = generateTestData(2, 50, {100,75})

local tester = perceptron.new(2) --call methods on this constructed object
--inital weights are generated randomly in the constructor

print('the intial choice with our control data, (75,-23), is')
print(tester:sumCalc(inputs))--determines -1 or 1 (true/false) for feed-forward to next layer.
--we're using -1 and 1 for easy later implementation of non binary feed forward.

--lets traing the dataset now and see if inputs change
print('now training the perceptron. this may take a while')
wait(1)

for i = 1, #testData do
	tester:train(testData[i].data, testData[i].answer)
end
print('sucessfully trained. lets compare with control points (75,-23)')
print(tester:sumCalc(inputs))

print('--')print('-')print('--')
print('that went well but lets mesure training a new perceptron with the same training set')
print('but this time we will calculate an error precentange off a large dataset before training')

local newPercept = perceptron.new(2, .1)

local controlData = generateTestData(2,25,{100,75})
local errSum = 0
for i = 1, #controlData do
	local guess = newPercept:sumCalc(controlData[i].data)
	if guess ~= controlData[i].answer then 
		errSum = errSum + 1
	end
end
print(errSum .. ' out of our ' .. #controlData .. 'control points were incorrect')
--print('that gives us an error precentage of ' .. #controlData/errSum)

print('training with original training set')
for i = 1, #controlData do
	newPercept:train(controlData[i].data,controlData[i].answer)
end

print('calculating error again')

local controlData = generateTestData(2,25,{100,75})
local errSum = 0
for i = 1, #controlData do
	local guess = newPercept:sumCalc(controlData[i].data)
	if guess ~= controlData[i].answer then 
		errSum = errSum + 1
	end
end
print(errSum .. ' out of our ' .. #controlData .. ' control points were incorrect')
--print('that gives us an error precentage of ' .. errSum/#controlData)


