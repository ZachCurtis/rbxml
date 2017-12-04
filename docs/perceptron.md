# Binary Perceptron

## Index

-   [Use](#use)
-   [Methods](#methods)
-   [Example](#example)

---

## Use

```lua
local perceptron = require(perceptron)
local brain = perceptron.new(inputNumber, learningRate) --learningRate is optional
--if no learning rate is provided, defaults to 0.01
--learning rate should never exceed .1 to prevent overreaching
```
---

## Methods

### feedForward(inputArray)

```lua
local boolResult = brain:feedForward({x, y, 1})
```

-   inputArray is an array of inputs and a single constant bias
-   Returns result of internal activation method (-1 for false, 1 for true)

---

### train(inputArray, singleOutput)

```lua
brain:train({x, y, 1}, -1)
```

-   inputArray is an array of inputs and a single constant bias
-   Output is the solution (-1, 1) of inputs

---

### weighSlope(xMax, toDeg)

```lua
local rotation = brain:weighSlope(250, true)
```
-   Returns predicted line of best fit slope calculated with current weight values
-   Passing optional second parameter of 'true' converts return slope to degrees
-   This usually doesn't work, not sure why

---

## Properties

-   brain.weights - array of weights, length determined on input number passed to constructor
-   brain.lr - learning rate, see; [Use](#use)

---


## Example

First we call it's object constructor, train it, and then we can use it to accurately predict binary outcomes.

```lua
local perceptron = require(script.perceptor)
local brain = perceptron.new(3) --two inputs; x and y, as well as a constant bias
local v2obj = require(script.vector2obj) --vector2obj's source is in master\lib

local exampleData = {}

--create 350 vector2obj's for use with perceptron
for i = 1, 350 do
  local dataPoint = v2obj.new(maxXValue, maxYValue) --values randomly assigned in constructor
  table.insert(exampleData, dataPoint)
end

for i = 1, #exampleData do
  local guess = brain:feedForward(exampleData[i]:getDataForPerceptron()) 
  --[[
  convert's vector2's values from data scale to floating point numbers
  between -1, and 1 for use with perceptron. Returns -1, 1
  ]]-- 
end
```

At this point, guess returns a value that's usually incorrect.
To get accurate predictions from our perceptron, we need to train it.
Training our perceptron consists of running the same known output dataset through it
in an iteritve manner. Training should be stopped when the perceptron makes a pass through the dataset
without a single error in it's predictions.

Any training iterations that do not produce an incorrect prediction do not effect the weights at all, and are thus useless.

```lua
local genTarg = 100 --break loop if haven't correctly adjusted weights by now
local gen = 1 --for tracking current generation
local totalErrors = 0

for i = 1, genTarg do

  --first we train our perceptron
	for i = 1, #exampleData do
		percpt:train(exampleData[i]:getDataForPerceptron(),exampleData[i].answer)
	end
	
  --now we get predictions to see how well it's adjusted its weights the previous generation
	for i = 1, #exampleData do
		local guess = percpt:feedForward(exampleData[i]:getDataForPerceptron())
    
		if guess ~= exampleData[i].answer then --if it was incorrect, add to our error count.
			totalErrors = totalErrors + 1
		end
		wait()
	end
	print('total error count this generation ' .. totalErrors)
	if totalErrors == 0 then --passes without errors are useless for training, so break the loop.
		break
	end
	gen = gen + 1
	totalErrors = 0
end
```

An example of this module solving a binary classification can be found in [this repo](../../examples/guiPerceptron.lua)
and tested [ingame here](https://www.roblox.com/games/1213473389/Simple-Neural-Network-Demo)
