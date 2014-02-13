StoreScreen = {}

function StoreScreen:new()
	
	local tscreen = display.newGroup()

	function tscreen:init()
		local menuBackground = self:getBtn("src/bgMenu.png")
		menuBackground.isVisible = false
		menuBackground.anchorX = 0.5
		menuBackground.anchorY = 0.5
		self.menuBackground = menuBackground

		local backBtn = self:getBtn("src/btnBack.png")
		backBtn.isVisible = false
		self.backBtn  = backBtn
	end

	function tscreen:getBtn(image)
		local img = display.newImage(image)
		img.anchorX = 0.5
		img.anchorY = 0.5
		self:insert(img)

		function img:touch(event)
			tscreen:onBtnTouch(event)
		end

		img:addEventListener("touch", img)
		return img
	end

	function tscreen:onBtnTouch(event)
		local p = event.phase
		local tgt = event.target

		if p == "ended" then
			if tgt == self.backBtn then
				Runtime:dispatchEvent({name = "backBtnSTouched", target = tscreen})
				return true
			end
		end
	end

	function tscreen:show()
		local menuBackground = self.menuBackground
		local backBtn 		 = self.backBtn

		local inTime 		= 1200
		local backBtnOut	= W + 3*backBtn.width

		setPos(menuBackground, 2*W + centerX, centerY)
		menuBackground.isVisible = true

		setPos(backBtn, backBtnOut, backBtn.height + backBtn.height / 2)
		backBtn.isVisible = true

		self:cancelTween(menuBackground)
		self:cancelTween(backBtn)

		menuBackground.tween = transition.to(menuBackground, {time = inTime, transition = easing.outExpo, x = centerX,
			onComplete = function()
			tscreen:cancelTween(menuBackground)
		end
		})

		backBtn.tween = transition.to(backBtn, {time = inTime, transition = easing.outExpo, x = backBtn.width,
			onComplete = function()
			tscreen:cancelTween(backBtn)
		end
		})
	end

	function tscreen:hide()
		local menuBackground = self.menuBackground
		local backBtn  		 = self.backBtn

		local outTime 		= 900
		local backBtnOut	= W + 3*backBtn.width

		self:cancelTween(menuBackground)
		self:cancelTween(backBtn)

		menuBackground.tween = transition.to(menuBackground, {transition = easing.outExpo, x = 2*W + 100 , time = outTime,
			onComplete = function()
			tscreen:cancelTween(menuBackground)
			menuBackground.isVisible = false
		end
		})

		backBtn.tween = transition.to(backBtn, {transition = easing.outExpo, x = backBtnOut, time = outTime,
			onComplete = function()
			tscreen:cancelTween(backBtn)
			backBtn.isVisible = false
		end
		})
	end

	function tscreen:cancelTween(obj)
		if obj.tween ~= nil then
			transition.cancel(obj.tween)
			obj.tween = nil
		end
	end

	tscreen:init()

	return tscreen
end

return StoreScreen