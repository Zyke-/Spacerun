InfoScreen = {}

function InfoScreen:new()
	
	local screen = display.newGroup()

	function screen:init()
		local slide = display.newGroup()

		local background = display.newRect(0, 0, W, H)
		background:setFillColor(255, 255, 255)
		local backBtn = self:getBtn("src/btnBackLeft.png")
		local creditsText = [[SPACERUN 
			Created by Vince Games 
			Version ]] .. getVesion()

		local creditsOptions = {
			text = creditsText,
			width = 240,
			height = 160,
			anchorX = 0.5,
			anchorY = 0.5,
			x = centerX,
			y = centerY,
			fontSize = 14,
			font = native.systemFont,
			align = "center"
		}
		local credits = display.newText(creditsOptions)
		credits:setFillColor(255, 255, 255)

		backBtn.anchorX = 0.5
		backBtn.anchorY = 0.5

		setPos(background, 0, 0)
		setPos(backBtn, W - backBtn.width * 2, backBtn.height * 2)
		setPos(credits, centerX, centerY)

		slide:insert(1, background, true)
		slide:insert(2, backBtn, true)
		slide:insert(3, credits, true)

		slide.isVisible = true

		self.slide = slide
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
		local slide 		= self.slide
		local slideIn 		= 0
		local inTime 		= 1200

		setPos(slide, 0, 0)

		slide.isVisible = true

		self:cancelTween(slide)

		slide = transition.to(slide, {time = inTime, transition = easing.outExpo, x = slideIN,
			onComplete = function()
			screen:cancelTween(slide)
		end
		})	
	end

	function screen:hide()
		local slide 		= self.slide
		local slideOut		= -W
		local outTime		= 900

		self:cancelTween(slide)

		slide.tween = transition.to(slide, {time = outTime, transition = easing.outExpo, x = slideOut, 
			onComplete = function()
			screen:cancelTween(slide)
			slide.isVisible = false
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