
function round(num, places) -- rounds number
	local mult = 10^(places)
	return math.floor(num * mult +.5) / mult
end

function distanceFrom(x1,y1,x2,y2) -- distance formula
   return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2)
end

function clamp( num, low, high ) -- clamps num between low and high
	if (num < low ) then return low end
	if (num > high ) then return high end
	return num
end

function printTable(tbl,name)
	if name then
		print(name .. " PRINT:")
	end
	for key,value in pairs(tbl) do 
		print("",key,value)
		if type(value) == "table" then
			for internalKey,internalTable in pairs(value) do 
				print("","",internalKey,internalTable)
			end
		end
	end
end

function swap(a,b)
	local temp = b
	b = a
	a = temp
	return a, b
end

-- Bresenham's line algorithm
function lineData(x0, y0, x1, y1)
	local lineArray = {}
	local steep = false
	if math.abs(y1 - y0) > math.abs(x1 - x0) then steep = true end
	if steep then
	        x0, y0 = swap(x0, y0)
	        x1, y1 = swap(x1, y1)
	end            
	 
	if x0 > x1 then
	        x0, x1 = swap(x0, x1)
	        y0, y1 = swap(y0, y1)
	end
	local deltax = x1 - x0
	local deltay = math.abs(y1 - y0)
	local err = deltax / 2
	local ystep = 0
	local y = y0
	if y0 < y1 then ystep = 1 else ystep = -1 end
	for x=x0,x1 do
	        lineArray[#lineArray+1] = {}
	if steep then
	        lineArray[#lineArray].y = x
	        lineArray[#lineArray].x = y
	 else
	        lineArray[#lineArray].x = x  
	        lineArray[#lineArray].y = y          
	 end            
	 err = err - deltay
	         if err < 0 then
	                 y = y + ystep
	                 err = err + deltax
	        end
	end
	return lineArray
end
