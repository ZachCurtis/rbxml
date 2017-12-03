# Linear Least Squares Regression

## Index

-   Use
-   Methods
-   Example

---

## Use

```lua
local lsr = require(lsr)
local lsrModel = lsr.new() --optionally pass training data params to skip using lsrModel:trainLSR()
```
---

## Methods

### trainLSR()

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

## Properties

-   lsrModel.m - Slope
-   lsrModel.b - Y-intercept
-   lsrModel.mErr - Slope Error Coefficent
-   lsrModel.bErr - Y-intercept Error Coefficent


---


## Example

```lua
local lsr = require(game.ServerScriptService.lsr)
local lsrModel = lsr.new()

local xInput = {2, 2, 6, 8, 10}
local yOutput = {0, 1, 2, 3, 3}

lsrModel:train(xInput, yOutput)

print('Our mErr ' .. lsrModel.mErr) --> 'our mErr 0.069877124296868'
print('Our bErr ' .. lsrModel.bErr) --> 'our bErr 0.4506909433'

print(lsrModel:predict(14) --> 4.6875
```
