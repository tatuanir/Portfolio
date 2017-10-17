-- Code file for the game's level

function newGameTrack(length)
	local self = display.newGroup()

	self.totalObjects = length
	self.object = {}
	self.lineData = {}

	function self:addData(x1,y1,x2,y2)
		local newLineData = lineData(x1,y1,x2,y2)
		for n=1,#newLineData do 
			local yArray = newLineData[n].y
			self.lineData[yArray] = newLineData[n].x
		end
	end

	function self:addLines()
		self.object[1] = display.newCircle( 320, 400, 12 )
		self:insert(self.object[1])	

		for n=2,self.totalObjects do 

			local xLocation = math.random(40,600)
			local yLocation = n*400

			self.object[n] = display.newCircle(xLocation,yLocation,8)
			self:insert(self.object[n])

			local lastX = self.object[n-1].x
			local lastY = self.object[n-1].y		

			local newLine = display.newLine(lastX,lastY,xLocation,yLocation)
			newLine.strokeWidth = 4
			self:insert(newLine)

			self:addData(xLocation,yLocation,lastX,lastY)
		end
	end



	function self:updateLocation()
		self.currentCircle = -math.floor(self.y/400)+1
		
		if -self.y > -400 and -self.y < self.levelLength - 1600 then
			isActive = true
			local yLocation = round(-(self.y),0)+800
			if self.lineData[yLocation] then
				-- debugObject.x = self.lineData[yLocation]
				self.xScore = self.lineData[yLocation]

				-- levelDebugText.text = round(self.y,2) .. ", " .. yLocation .. ", " .. self.lineData[yLocation]

			end
		else
			isActive = false
		end
	end

	function self:start()
		self.levelLength = 400 * self.totalObjects + 800
		self.y = - self.levelLength + 800
		
		self.levelTime = 2000+(self.totalObjects*1000)
		print(self.levelLength,self.levelTime)
		transition.to(self,{y = self.levelLength, delta = true,time = self.levelTime})
		levelDebugText = display.newText("",200,64)
	end

	function self:circleChange()

		print("Circle" .. currentCircle)
		self.object[self.totalObjects-currentCircle]:setFillColor(1,0,0)
		currentCircle = currentCircle + 1		
	end

	function self:reset()


		self.lineData = {}
		for n=self.numChildren,1,-1 do 
			self[n]:removeSelf()
		end
	end

	-- debugObject = display.newCircle(0,800,12)
	-- debugObject:setFillColor( 1,0,0 )


	return self
end
