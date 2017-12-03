# Linear Least Squares Regression

## Index

-   [Use](#use)
-   [Methods](#methods)
-   [Example](#example)

---

## Use

```lua
local lsr = require(lsr)
local lsrModel = lsr.new() --optionally pass training data params to skip using lsrModel:train()
```
---

## Methods

### trainLSR(x,y)

```lua
lsrModel:train(X,Y)
```

-   X is an array of input data
-   Y is an array of matching output data
-   Returns m, b, mErr, bErr if needed

---

### predict(y)

```lua
local predictY = lsrModel:predictLSR(X)
```

-   X is a single numerical input
-   Returns prediction of Y

---

### computeAvgError(x,y)

```lua
local avgError = lsrModel:computeAvgError(x,y)
```
-   X and Y are the arrays used to train the model
-   Returns a normalized error average of calculated coefficents m and b.
-   The lower the average of error is; the better linear correlation between input X and output Y

---

## Properties

-   lsrModel.m - Slope
-   lsrModel.b - Y-intercept
-   lsrModel.mErr - Slope Error Coefficent
-   lsrModel.bErr - Y-intercept Error Coefficent


---


## Example

Using the lsr object is easy. First we will call it's object constructor, train it, and finally get a prediction from it.
Our sample data looks like:

|Input X |Output Y|
|--------|--------|
|2       |0       | 
|2       |1       |
|6       |2       |
|8       |3       |
|10      |3       |

```lua
local lsr = require(game.ServerScriptService.lsr)
local lsrModel = lsr.new()

local xInput = {2, 2, 6, 8, 10}
local yOutput = {0, 1, 2, 3, 3}

lsrModel:train(xInput, yOutput)

print('Our mErr ' .. lsrModel.mErr) --> 'Our mErr 0.069877124296868'
print('Our bErr ' .. lsrModel.bErr) --> 'Our bErr 0.4506909433'
print('Average err ' .. lsrModel:computeError(lsrModel.m, lsrModel.b, xInput, yOutput))  --> 'Average err 0.15'
print(lsrModel:predict(14)) --> 4.6875
```
