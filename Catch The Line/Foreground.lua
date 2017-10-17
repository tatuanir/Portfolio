

function newForeground()
	local self = display.newGroup()
	self.y = 800
	self.image = display.newImage("foreground.png",320,90)
	self:insert(self.image)

	local scoreTextParams = 
	{
	    text = "",
	    x = 320,
	    y = 50,
	    font = native.systemFontBold,
	    fontSize = 24
	}

	self.scoreText = display.newText(scoreTextParams)
	self:insert(self.scoreText)
	function self:updateUI()
		self.scoreText.text = round(score,0)
	end



	return self
end