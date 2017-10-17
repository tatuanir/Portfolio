-- Code file for the player

function newPlayer()
	local self = display.newImage("player.png",320,794)
	self.velocity = 0

	function self:updateLocation()
		self.x = self.x + self.velocity
		if self.x > screenWidth then
			self.x = 0
		elseif self.x < 0 then
			self.x = screenWidth
		end
	end
	function self:scoreDifference(xScore)
		if xScore then
			self.xDiff = math.abs(self.x-xScore)
		end
	end
	function self:changeVelocity(speedChange)
		self.velocity = clamp(self.velocity + speedChange,-25,25)
	end
	function self:reset()
		self.x = 320
		self.velocity = 0
	end
	return self
end
