InfoScreen = {}

function InfoScreen:new()
	
	local screen = display.newGroup()

	function screen:init()
		local background = self:getBtn("src/bgMenu.png")
		background.isVisible = false

		local backBtn = self:getBtn("src/btnBackLeft.png")

		local creditsText = [[SPACERUN 
			Created by Vince Games 
			Version ]] .. getVesion()

		local creditsOptions = {
			text = creditsText,
			x = centerX,
			y = centerY,
			width = 500,
			height = 500,
			fontSize = 18,
			align = "center"
		}
		local credits = display.newText(creditsOptions)
		credits:setFillColor(white)

		background.anchorX = 0.5
		background.anchorY = 0.5

		backBtn.anchorX = 0.5
		backBtn.anchorY = 0.5

		credits.anchorX = 0.5
		credits.anchorY = 0.5

		setPos(background, -centerX, centerY)
		setPos(backBtn, -backBtn.width * 2, backBtn.height * 2)
		setPos(credits, -centerX, centerY)

		self.background = background
		self.credits = credits
		self.backBtn = backBtn
	end

	function screen:getBtn(image)
		local img = display.newImage(image)
		img.anchorX = 0.5
		img.anchorY = 0.5
		self:insert(img)

		function img:touch(event)
			screen:onBtnTouch(event)
		end

		img:addEventListener("touch", img)
		return img
	end

	function screen:onBtnTouch(event)
		local p = event.phase
		local tgt = event.target

		if p == "ended" then
			if tgt == self.backBtn then
				Runtime:dispatchEvent({name = "backBtnITouched", target = screen})
				return true
			end
		end
	end

	function screen:show()
		local background	= self.background
		local credits 		= self.credits
		local backBtn 		= self.backBtn

		local backgroundIn	= centerX
		local creditsIn		= centerX
		local backBtnIn		= W - backBtn.width

		local inTime 		= 1200

		setPos(background, -centerX, centerY)
		setPos(backBtn, -backBtn.width * 2, backBtn.height * 2)
		setPos(credits, -centerX, centerY)

		background.isVisible = true
		credits.isVisible = true
		backBtn.isVisible = true

		self:cancelTween(background)
		self:cancelTween(credits)
		self:cancelTween(backBtn)

		background.tween = transition.to(background, {time = inTime, transition = easing.outExpo, x = backgroundIn,
			onComplete = function()
			screen:cancelTween(background)
		end
		})
		credits.tween = transition.to(credits, {time = inTime, transition = easing.outExpo, x = creditsIn,
			onComplete = function()
			screen:cancelTween(credits)
		end
		})	
		backBtn.tween = transition.to(backBtn, {time = inTime, transition = easing.outExpo, x = backBtnIn,
			onComplete = function()
			screen:cancelTween(backBtn)
		end
		})	
		credits:toFront()	
	end

	function screen:hide()
		local background 	= self.background
		local credits 		= self.credits
		local backBtn  		= self.backBtn

		local backgroundOut = -W - centerX
		local creditsOut	= -centerX
		local backBtnOut	= -backBtn.width * 3

		local outTime		= 900

		self:cancelTween(background)
		self:cancelTween(credits)
		self:cancelTween(backBtn)

		background.tween = transition.to(background, {transition = easing.outExpo, x = backgroundOut, time = outTime,
			onComplete = function()
			screen:cancelTween(background)
			background.isVisible = false
		end
		})
		credits.tween = transition.to(credits, {transition = easing.outExpo, x = creditsOut, time = outTime,
			onComplete = function()
			screen:cancelTween(credits)
			credits.isVisible = false
		end
		})
		backBtn.tween = transition.to(backBtn, {transition = easing.outExpo, x = backBtnOut, time = outTime,
			onComplete = function()
			screen:cancelTween(backBtn)
			backBtn.isVisible = false
		end
		})
	end

	function screen:cancelTween(obj)
		if obj.tween ~= nil then
			transition.cancel(obj.tween)
			obj.tween = nil
		end
	end

	screen:init()

	return screen
end

return InfoScreen