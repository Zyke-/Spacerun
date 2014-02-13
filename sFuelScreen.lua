FuelScreen = {}

function FuelScreen:new()
	
	local screen = display.newGroup()

	function screen:init()
		fuelGroup = display.newGroup()

		bar = display.newImage("src/barFuel.png")
		bar.isVisible = true
		setScale(bar, W/800)
		bar.anchorX = 0.5
		bar.anchorY = 0.5
		bar.x = centerX - 5
		bar.y = 0
		fuelGroup:insert(bar)

		if playerFuel ~= nil then
			for i = 0, #playerFuel do
				display.remove(playerFuel[i])
				playerFuel[i] = nil
			end
		end
		
		local i
		playerFuel = {}	
		for i = 0, maxFuel do
			playerFuel[i] = display.newImage("src/lvlFuel.png")
			setScale(playerFuel[i], W/800)
			if i == 0 then
				playerFuel[i].x = playerFuel[i].width * 2 - 5
			else
				playerFuel[i].x = playerFuel[i - 1].x + playerFuel[i].width - 8
			end
			playerFuel[i].y = 0
			playerFuel[i].isVisible = true

			fuelGroup:insert(playerFuel[i])
		end
		fuelGroup.anchorX = 0.5
		fuelGroup.anchorY = 0.5
		setPos(fuelGroup, 0, centerY)
		self.fuel = fuelGroup
	end

	function screen:show()
		local fuelGroup = self.fuel
		local inTime 	= 1000

		setPos(fuelGroup, centerX, H + fuelGroup.height)
		fuelGroup.isVisible = true
		fuelGroup:toFront()

		self:cancelTween(fuelGroup)

		fuelGroup.tween = transition.to(fuelGroup, {time = inTime, transition = easing.linear, y = H - fuelGroup.height/2, x = 0,
			onComplete = function()
			screen:cancelTween(fuelGroup)
		end
		})
	end

	function screen:hide()
		local fuelGroup = self.fuel
		local outTime 	= 1000

		self:cancelTween(fuelGroup)

		fuelGroup.tween = transition.to(fuelGroup, {time = outTime, transition = easing.linear, y = H + fuelGroup.height, x = 0,
			onComplete = function()
			screen:cancelTween(fuelGroup)
		end
		})
	end

	function screen:cancelTween(obj)
		if obj.tween ~= nil then
			transition.cancel(obj.tween)
			obj.tween = nil
		end
	end

	function screen:addFuel()
		local fuel = self.fuel
		local memento = playerFuel

		if playerFuel < maxFuel then
			playerFuel = playerFuel + fuelToAdd

			if playerFuel > maxFuel then
				playerFuel = maxFuel
			end

			for i = 0, fuelToAdd do
				if memento + i < maxFuel or memento + i == maxFuel then
					fuelGroup[memento + 1 + i].isVisible = true 
				end
			end
		end
		self.fuel = fuel
	end

	function screen:removeFuel()
		local fuelGroup = self.fuel
		local fuelT = self.fuelT
		if paused == false then
			if playerFuel < maxFuel + 1 then
			playerFuel = playerFuel - 1
			fuelGroup[playerFuel + 3].isVisible = false 
			end
			if playerFuel == -1 then
				playerFuel = 0

				timer.cancel(fuelT)
				fuelT = nil
				
				gameOver(true)
			end
		end
		self.fuelT = fuelT
		self.fuel = fuelGroup
	end

	function screen:resetFuel()
		local fuelGroup = self.fuel
		local fuelT = self.fuelT
		local i
		if fuelT ~= nil then
			timer.cancel(fuelT)
		end
		
		playerFuel = maxFuel
		for i = 1, fuelGroup.numChildren do
			fuelGroup[i].isVisible = true
		end
		self.fuelT = fuelT
		fuelGroup = self.fuel
		screen:consumeFuel()
	end

	function screen:consumeFuel()
		fuelT = timer.performWithDelay(2000, function() screen:removeFuel() end, 0)
		self.fuelT = fuelT
	end

	function screen:stopConsumeFuel()
		local fuelT = self.fuelT
		timer.cancel(fuelT)
		self.fuelT = fuelT
	end

	function screen:getFuel()
		return playerFuel
	end

	screen:init()

	return screen
end

return FuelScreen