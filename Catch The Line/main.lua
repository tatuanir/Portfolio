
widget = require("widget")
widget.setTheme( "widget_theme_ios" )

require("Player")
require("GameTrack")
require("Background")
require("Foreground")
require("TitleScreen")
require("Utilities")

screenWidth = display.contentWidth

gameLength = 20 -- seconds
score = 0
highScore = 0
isActive = false

function leftButtonPressed(event)
	-- print("Left button is " .. event.phase)
	if event.phase == "began" then
		display.getCurrentStage():setFocus( event.target )
		leftIsHeld = true
	elseif event.phase == "ended" or event.phase == "cancelled" then
		leftIsHeld = false
		display.getCurrentStage():setFocus( nil )
	end	
end

function rightButtonPressed(event)
	-- print("Right button is " .. event.phase)
	if event.phase == "began" then
		display.getCurrentStage():setFocus( event.target )
		rightIsHeld = true
	elseif event.phase == "ended" or event.phase == "cancelled" then
		rightIsHeld = false
		display.getCurrentStage():setFocus( nil )
	end
end

function load()

	background = newBackground()

	level = newGameTrack(gameLength)

	player = newPlayer()

	foreground = newForeground()

	leftButton = widget.newButton{
		left = 0,
		top = 815,
		height = 140,	
	 	id = "left",
	    label = "Left",
	    onEvent = leftButtonPressed
	}

	rightButton = widget.newButton{
		left = 460,
		top = 815,
		height = 140,
	 	id = "right",
	    label = "Right",
	    onEvent = rightButtonPressed	
	}

	levelDebugText = display.newText("",200,64)


	newGame()
end

function update(e)
	if leftIsHeld then
		player:changeVelocity(-1)
	end
	if rightIsHeld then
		player:changeVelocity(1)
	end
	level:updateLocation()
	player:updateLocation()	
	if isActive then
		player:scoreDifference(level.xScore)
		if player.xDiff < 100 then 
			local newPoints = ((100-player.xDiff)*(100-player.xDiff))/10
			-- levelDebugText.text = newPoints ..  ", " .. player.xDiff
			score = score + newPoints
		end
		foreground:updateUI()
	end
end

function newGame()
	gameLength = 20 -- seconds
	score = 0
	isActive = false
	player:reset()
	level:addLines()
	level:start()
	foreground:updateUI()
	timer.performWithDelay( 3000+gameLength*1000, endLevel )
	Runtime:addEventListener( "enterFrame", update )
end

function endLevel()
	if score > highScore then
		highScore = score
	end
	Runtime:removeEventListener( "enterFrame", update )
	player:reset()
	level:reset()
	foreground:updateUI()
	titleScreen = newTitleScreen()

end



load()