local lsr = {}

lsr.__index = lsr

function lsr.new(x,y)
	local newlsr = {}
	setmetatable(newlsr, lsr)
	if x then
		newlsr.m, newlsr.b, newlsr.mErr, newlsr.bErr = lsr:train(x,y)
	end
	return newlsr
end

function lsr:train(x,y)
	print('called')
--computes y = mx + b given array X and array Y of equal lengths and returns tupel m, b, mError, bError

--thanks to https://github.com/jprichardson/least-squares/blob/master/lib/least-squares.js	
	local check = assert(#x == #y, 'Your array paramters must be of equal length')
	if check then
		local n = #x
		local sumx, sumy, sumx2, sumxy, st, sr = 0,0,0,0,0,0 --predeclare to ensure scope
		for i = 1, n do
			print('first ieteration at index ' .. i) 
			sumx = sumx + x[i] --total sum of all indexes in x array
			sumy = sumy + y[i] --total sum of all indexes in y array
			sumxy = sumxy + x[i] * y[i] --sum of both arrays
			sumx2 = sumx2 + x[i] * x[i] --sum of array x squared
			
			if n > 50 then wait() end --yeild for other threads if indexes exceed 50
		end
		
		
		--compute our m and b values
		local m = ((sumxy - sumx * sumy / n)) / (sumx2 - sumx * sumx / n)
		local b = sumy / n - m * sumx / n
		
		
		local varSum = 0
		for i = 1, n do --iterate the arrays to populate varSum
			print('second ieteration at index ' .. i) 
			varSum = varSum + (y[i] - b - m * x[i]) * (y[i] - b - m * x[i])
			
			if n > 50 then wait() end
		end
			
		local delta = n * sumx2 - sumx * sumx
		local variant = 1 / (n - 2) * varSum
			
		local mErr = math.sqrt(n / delta * variant)
		local bErr = math.sqrt(variant / delta * sumx2)
		
		print('done')
		self.m, self.b, self.mErr, self.bErr = m, b, mErr, bErr
		return m, b, mErr, bErr
	end
end

function lsr:predict(x)
	local check = assert(self.m, 'You first must train the model using lsr:trainLSR(x,y)')
	if check then
		return self.m * x + self.b
	end
end


return lsr
