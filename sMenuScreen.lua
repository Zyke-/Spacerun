MenuScreen = {}

function MenuScreen:new()
	
	local mscreen = display.newGroup()

	function mscreen:init()
		local menuBackground = self:getBtn("src/bgMenu.png")
		self.menuBackground = menuBackground
		setScale(menuBackground, .4)

		local continueBtn = self:getBtn("src/btnCon.png")
		self.continueBtn  = continueBtn

		local musicBtn = self:getBtn("src/btnMus.png")
		self.musicBtn  = musicBtn
	end

	function mscreen:getBtn(image)
		local img = display.newImage(image)
		img.anchorX = 0.5
		img.anchorY = 0.5
		self:insert(img)

		function img:touch(event)
			mscreen:onBtnTouch(event)
		end

		img:addEventListener("touch", img)
		return img
	end

	function mscreen:onBtnTouch(event)
		local p = event.phase
		local tgt = event.target

		if p == "ended" then
			if tgt == self.continueBtn then
				Runtime:dispatchEvent({name = "continueBtnTouched", target = mscreen})

			elseif tgt == self.musicBtn then
				Runtime:dispatchEvent({name = "musicBtnTouched", target = mscreen})
			end

			return true
		end
	end

	function mscreen:show()
		local menuBackground = self.menuBackground
		local continueBtn 	= self.continueBtn
		local musicBtn 		= self.musicBtn

		local inTime 		= 700

		setPos(menuBackground, centerX, -centerY)
		menuBackground.isVisible = true

		setPos(continueBtn, centerX, -centerY)
		continueBtn.isVisible = true

		setPos(musicBtn, centerX, -centerY)
		musicBtn.isVisible = true

		self:cancelTween(menuBackground)
		self:cancelTween(continueBtn)
		self:cancelTween(musicBtn)

		menuBackground.tween = transition.to(menuBackground, {time = inTime, transition = easing.outExpo, y = centerY,
			onComplete = function()
			mscreen:cancelTween(menuBackground)
		end
		})

		continueBtn.tween = transition.to(continueBtn, {time = inTime, transition = easing.outExpo, y = centerY - 25,
			onComplete = function()
			mscreen:cancelTween(continueBtn)
		end
		})

		musicBtn.tween = transition.to(musicBtn, {time = inTime, transition = easing.outExpo, y = centerY + continueBtn.height,
			onComplete = function()
			mscreen:cancelTween(musicBtn)
		end
		})
	end

	function mscreen:hide()
		local menuBackground = self.menuBackground
		local continueBtn   = self.continueBtn
		local musicBtn 		= self.musicBtn

		local outTime 		= 350

		self:cancelTween(menuBackground)
		self:cancelTween(continueBtn)
		self:cancelTween(musicBtn)

		menuBackground.tween = transition.to(menuBackground, {transition = easing.outExpo, y = H + 150, time = outTime,
			onComplete = function()
			mscreen:cancelTween(menuBackground)
			menuBackground.isVisible = false
		end
		})

		continueBtn.tween = transition.to(continueBtn, {transition = easing.outExpo, y = H + 150, time = outTime,
			onComplete = function()
			mscreen:cancelTween(continueBtn)
			continueBtn.isVisible = false
		end
		})

		musicBtn.tween = transition.to(musicBtn, {transition = easing.outExpo, y = H + 150, time = outTime,
			onComplete = function()
			mscreen:cancelTween(musicBtn)
			musicBtn.isVisible = false
		end
		})
	end

	function mscreen:cancelTween(obj)
		if obj.tween ~= nil then
			transition.cancel(obj.tween)
			obj.tween = nil
		end
	end

	mscreen:init()

	return mscreen
end

return MenuScreen