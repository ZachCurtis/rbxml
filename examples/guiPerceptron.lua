--[[
Dec 2017
Zach Curtis AKA InfinityDesign

visulization of perceptron
check it out ingame here:
https://www.roblox.com/games/1213473389/

requires /src/nerualNetworks/perceptron.lua and /lib/vector2obj.lua as children module scripts
--]]

_G.slope = 1
_G.yInter = 0

math.randomseed(tick())
wait(3) --let game load
local player = game:GetService('Players').LocalPlayer
local v2obj = require(script.vector2obj)
local perceptron = require(script.perceptron)
local percpt = perceptron.new(3)

local gui = Instance.new('ScreenGui', player.PlayerGui)
local frame = Instance.new('Frame', gui)
wait()
local xLine = Instance.new('Frame', frame)
local yLine = Instance.new('Frame', frame)
local msg = Instance.new('TextLabel', frame)

frame.Size = UDim2.new(0,400,0,400)
frame.AnchorPoint = Vector2.new(.5,.5)
frame.Position = UDim2.new(.5,0,.5,0)
frame.BorderSizePixel = 0
frame.BackgroundTransparency = .6

local frameCopy = frame:Clone()
frameCopy:ClearAllChildren()
frameCopy.Parent = gui
frameCopy.BackgroundTransparency = 1
frameCopy.ClipsDescendants = true

local meanLine = Instance.new('Frame', frameCopy)
local fitLine = Instance.new('Frame', frameCopy)

xLine.Size = UDim2.new(0,400,0,2)
xLine.AnchorPoint = Vector2.new(.5,.5)
xLine.Position = UDim2.new(.5,0,.5,0)
xLine.BorderSizePixel = 0
xLine.BackgroundColor3 = Color3.fromRGB(20,20,20)

yLine.Size = UDim2.new(0,2,0,400)
yLine.AnchorPoint = Vector2.new(.5,.5)
yLine.Position = UDim2.new(.5,0,.5,0)
yLine.BorderSizePixel = 0
yLine.BackgroundColor3 = Color3.fromRGB(20,20,20)

msg.Size = UDim2.new(0,400,0,35)
msg.Position = UDim2.new(0,0,0,-10)
msg.AnchorPoint = Vector2.new(0,1)
msg.BorderSizePixel = 0
msg.BackgroundTransparency = .6
msg.Text = "Finished building graph"
msg.TextScaled = true

meanLine.Size = UDim2.new(0,2,0,400 * math.sqrt(2))
meanLine.AnchorPoint = Vector2.new(.5,.5)
meanLine.Position = UDim2.new(.5,0,.5,-_G.yInter)
meanLine.BorderSizePixel = 0
meanLine.BackgroundColor3 = Color3.fromRGB(25,25,25)
meanLine.Rotation = 45

fitLine.Visible = false
fitLine.BackgroundColor3 = Color3.fromRGB(0,0,0)
fitLine.AnchorPoint = Vector2.new(.5,.5)
fitLine.Position = UDim2.new(.5,0,.5,0)
fitLine.BorderSizePixel = 0
fitLine.BackgroundColor3 = Color3.fromRGB(20,57,20)
fitLine.Rotation = 45

--function dump

--build data arrays
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

--plot individual points
function plotPoint(obj)
	local point = Instance.new("Frame",frame)
	point.Size = UDim2.new(0,5,0,5)
	point.BorderSizePixel = 0
	point.AnchorPoint = Vector2.new(.5,.5)
	point.Position = UDim2.new(0.5,obj.data[1],0.5,-obj.data[2]) --inverse of Y to play nicely with graph
	return point
end

--color function
function colorPoint(ref,guess)
	if guess == 1 then
		ref.BackgroundColor3 = Color3.fromRGB(25, 255, 25)
	else
		ref.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	end
end

wait(2)

msg.Text = "Generating datasets"
--generate data with 200,200 because intersect of xLine, yLine is origin
local controlData = generateTestData(2,50,{200,200})
--local testData = generateTestData(2,75,{200,200})


msg.Text = "Plotting our control data"
local controlRef = {}

for i = 1, #controlData do
	table.insert(controlRef, plotPoint(controlData[i]))
	colorPoint(controlRef[i],controlData[i].answer)
end

msg.Text = 'This is the correct classification of the control data'

wait(4)

msg.Text = 'This is what the perceptron thinks the classification is'

for i = 1, #controlData do
	local guess = percpt:feedForward(controlData[i]:getDataForPerceptron())
	colorPoint(controlRef[i], guess)
end

local rot = percpt:weighSlope(200, true)
print(rot .. ' is our new lines rotation')
fitLine.Visible = true
fitLine.Rotation = percpt:weighSlope(1, true)

wait(3)

msg.Text = 'As you can see, its not very accurate'

wait(3)

msg.Text = 'We will iterate between generations of training'

wait(3)


for i = 1, #controlRef do
	controlRef[i].Visible = true
end


local genTarg = 100
local gen = 1
local totalErrors = 0
for i = 1, genTarg do
	
	msg.Text = 'Training generation ' .. gen .. ' with ' .. #controlData .. " unique points"

	--train perceptron
	for i = 1, #controlData do
		percpt:train(controlData[i]:getDataForPerceptron(),controlData[i].answer)
	end
	
	for i = 1, #controlData do
		local guess = percpt:feedForward(controlData[i]:getDataForPerceptron())
		colorPoint(controlRef[i],guess)
		if guess ~= controlData[i].answer then
			totalErrors = totalErrors + 1
		end
		wait()
	end
	print('total error count this generation ' .. totalErrors)
	if totalErrors == 0 then
		break
	end
	gen = gen + 1
	totalErrors = 0
end

msg.Text = 'Perceptron has sucessfully learned to catagorize our data in ' .. gen .. ' generations'
