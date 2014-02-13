InfoScreen = {}

function InfoScreen:new()
	
	local screen = display.newGroup()

	function screen:init()
		infoGroup = display.newGroup()

		local background = display.newImage("src/bgMenu.png")
		local backBtn = self:getBtn("src/btnBack.png")
		local creditsText = [[SPACERUN 
			Created by Vince Games 
			Version ]].. Version .. "." .. Build

		local creditsOptions = {
			text = creditsText,
			x = W,
			y = H,
			width = 400,
			height = 300,
			fontSize = 18,
			align = "center"
		}
		local credits = display.newText(creditsOptions)

		background.anchorX = 0.5
		background.anchorY = 0.5

		backBtn.anchorX = 0.5
		backBtn.anchorY = 0.5

		credits.anchorX = 0.5
		credits.anchorY = 0.5
		
		setPos(background, centerX, centerY)
		setPos(backBtn, W - backBtn.width * 2, backBtn.height * 2)
		setPos(credits, centerX, centerY)

		backBtn:toFront()
		infoGroup:insert(background)
		infoGroup:insert(credits)
		infoGroup:insert(backBtn)

		infoGroup.isVisible = false
		infoGroup.anchorX = 0.5
		infoGroup.anchorY = 0.5

		infoGroup:toFront()
		backBtn:toFront()

		self.infoGroup = infoGroup
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
		local infoGroup = self.infoGroup
		local inTime 	= 800

		setPos(infoGroup, -centerX, centerY)
		infoGroup:toFront()
		infoGroup.isVisible = true
		
		self:cancelTween(infoGroup)

		infoGroup.tween = transition.to(infoGroup, {time = inTime, transition = easing.outExpo, x = centerX, y = centerY,
			onComplete = function()
			screen:cancelTween(infoGroup)
		end
		})		
	end

	function screen:hide()
		local infoGroup = self.infoGroup
		local outTime 		= 900

		self:cancelTween(infoGroup)

		infoGroup.tween = transition.to(infoGroup, {time = outTime, transition = easing.outExpo, x = -centerX, y = centerY,
			onComplete = function()
			screen:cancelTween(infoGroup)
			infoGroup.isVisible = false
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