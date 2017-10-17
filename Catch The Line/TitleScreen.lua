

function newTitleScreen()
	local self = display.newGroup()
	self.x = 320
	self.y = -320
	self.image = display.newImage("gameOver.png")
	self:insert(self.image)


	function self:addUI()
		self.restart = widget.newButton{
		x = 0,
		y = 80,
		height = 60,	
	 	id = "restart",
	    label = "Restart",
	    onRelease = restartButtonPress}	

	    self:insert(self.restart)

	    self.highScoreLabel = display.newText("High Score",0,-30,native.systemFontBold,24)
	    self:insert(self.highScoreLabel)

	    self.highScore = display.newText(round(highScore,0),0,0,native.systemFontBold,24)
	    self:insert(self.highScore)
	end

	function self:removeScreen()
		for n=self.numChildren,1,-1 do 
			self[n]:removeSelf()
		end
	end

	transition.to(self,{y = 420, time = 1500, transition=easing.outBounce, onComplete = self.addUI})

	return self
end

function restartButtonPress(event)
	titleScreen:removeScreen()
	newGame()
end