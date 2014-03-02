DifficultyScreen = {}

function DifficultyScreen:new()
	
	local dscreen = display.newGroup()

	function dscreen:init()
		local bg = self:getBtn("src/bgMenu.png")
		bg.isVisible = false
		self.bg = bg

		local backBtn = self:getBtn("src/btnBackLeft.png")
		backBtn.isVisible = false
		self.backBtn = backBtn

		local normal = self:getBtn("src/normalBtn.png")
		self.normal = normal

		local hard = self:getBtn("src/hardBtn.png")
		self.hard  = hard

		local hardcore = self:getBtn("src/hardcoreBtn.png")
		self.hardcore  = hardcore

		local normalDex = display.newText("Normal difficulty for unexperienced players", 0, 0, normal.width, 100, native.systemFont, 14)
		self.normalDex = normalDex

		local hardDex = display.newText("Hard difficulty for experienced players", 0, 0, hard.width, 100, native.systemFont, 14)
		self.hardDex = hardDex

		local hardcoreDex = display.newText("HARDCORE difficulty for an EXTREME GAMEPLAY", 0, 0, normal.width, 100, native.systemFont, 14)
		self.hardcoreDex = hardcoreDex

		normalDex.anchorX = 0.5
		normalDex.anchorY = 0.5

		hardDex.anchorX = 0.5
		hardDex.anchorY = 0.5
		
		hardcoreDex.anchorX = 0.5
		hardcoreDex.anchorY = 0.5
	end

	function dscreen:getBtn(image)
		local img = display.newImage(image)
		img.anchorX = 0.5
		img.anchorY = 0.5
		self:insert(img)

		function img:touch(event)
			dscreen:onBtnTouch(event)
		end

		img:addEventListener("touch", img)
		return img
	end

	function dscreen:onBtnTouch(event)
		local p = event.phase
		local tgt = event.target

		if p == "ended" then
			if tgt == self.normal then
				Runtime:dispatchEvent({name = "normalBtnTouched", target = dscreen})

			elseif tgt == self.hard then
				Runtime:dispatchEvent({name = "hardBtnTouched", target = dscreen})

			elseif tgt == self.hardcore then
				Runtime:dispatchEvent({name = "hardcoreBtnTouched", target = dscreen})

			elseif tgt == self.backBtn then
				Runtime:dispatchEvent({name = "difficultyBackBtnTouched", target = dscreen})
			end

			return true
		end
	end

	function dscreen:show()
		local bg 			= self.bg
		local backBtn 		= self.backBtn
		local normal 		= self.normal
		local hard 			= self.hard
		local hardcore 		= self.hardcore

		local normalDex 	= self.normalDex
		local hardDex 		= self.hardDex
		local hardcoreDex 	= self.hardcoreDex

		local inTime 		= 700

		setPos(bg, centerX, centerY)
		bg.isVisible = true

		setPos(backBtn, backBtn.width, backBtn.height)
		backBtn.isVisible = true

		setPos(normal, centerX - normal.width - 15, -centerY)
		normal.isVisible = true

		setPos(hard, centerX, -centerY)
		hard.isVisible = true

		setPos(hardcore, centerX + hardcore.width + 15, -centerY)
		hardcore.isVisible = true
		-------
		setPos(normalDex, centerX - normalDex.width - 15, -centerY)
		normalDex.isVisible = true

		setPos(hardDex, centerX, -centerY)
		hardDex.isVisible = true

		setPos(hardcoreDex, centerX + hardcoreDex.width + 15, -centerY)
		hardcoreDex.isVisible = true

		normalDex:toFront()
		hardDex:toFront()
		hardcoreDex:toFront()

		self:cancelTween(backBtn)
		self:cancelTween(normal)
		self:cancelTween(hard)
		self:cancelTween(hardcore)

		self:cancelTween(normalDex)
		self:cancelTween(hardDex)
		self:cancelTween(hardcoreDex)

		backBtn.tween = transition.to(backBtn, {time = inTime, transition = easing.outExpo, y = backBtn.height,
			onComplete = function()
			dscreen:cancelTween(backBtn)
		end
		})
		normal.tween = transition.to(normal, {time = inTime, transition = easing.outExpo, y = centerY - 35,
			onComplete = function()
			dscreen:cancelTween(normal)
		end
		})
		hard.tween = transition.to(hard, {time = inTime, transition = easing.outExpo, y = centerY - 35,
			onComplete = function()
			dscreen:cancelTween(hard)
		end
		})
		hardcore.tween = transition.to(hardcore, {time = inTime, transition = easing.outExpo, y = centerY - 35,
			onComplete = function()
			dscreen:cancelTween(hardcore)
		end
		})
		-------
		normalDex.tween = transition.to(normalDex, {time = inTime, transition = easing.outExpo, y = centerY + 75,
			onComplete = function()
			dscreen:cancelTween(normalDex)
		end
		})
		hardDex.tween = transition.to(hardDex, {time = inTime, transition = easing.outExpo, y = centerY + 75,
			onComplete = function()
			dscreen:cancelTween(hardDex)
		end
		})
		hardcoreDex.tween = transition.to(hardcoreDex, {time = inTime, transition = easing.outExpo, y = centerY + 75,
			onComplete = function()
			dscreen:cancelTween(hardcoreDex)
			hardcoreDex.isVisible = true
		end
		})
	end

	function dscreen:hide()
		local bg			= self.bg
		local backBtn 		= self.backBtn
		local normal 		= self.normal
		local hard 			= self.hard
		local hardcore 		= self.hardcore

		local normalDex 	= self.normalDex
		local hardDex 		= self.hardDex
		local hardcoreDex 	= self.hardcoreDex

		local outTime 		= 2000

		self:cancelTween(backBtn)

		self:cancelTween(normal)
		self:cancelTween(hard)
		self:cancelTween(hardcore)

		self:cancelTween(normalDex)
		self:cancelTween(hardDex)
		self:cancelTween(hardDex)
		
		bg.isVisible = false

		backBtn.tween = transition.to(backBtn, {transition = easing.outExpo, y = -backBtn.height, time = outTime,
			onComplete = function()
			dscreen:cancelTween(backBtn)
			backBtn.isVisible = false
		end
		})

		normal.tween = transition.to(normal, {transition = easing.outExpo, x = -normal.width, time = outTime,
			onComplete = function()
			dscreen:cancelTween(normal)
			normal.isVisible = false

		end
		})

		hard.tween = transition.to(hard, {transition = easing.outExpo, x = -hard.width, time = outTime,
			onComplete = function()
			dscreen:cancelTween(hard)
			hard.isVisible = false

		end
		})

		hardcore.tween = transition.to(hardcore, {transition = easing.outExpo, x = -hardcore.width, time = outTime,
			onComplete = function()
			dscreen:cancelTween(hardcore)
			hardcore.isVisible = false

		end
		})

		normalDex.tween = transition.to(normalDex, {transition = easing.outExpo, y = H + 100, time = outTime,
			onComplete = function()
			dscreen:cancelTween(normalDex)
			normalDex.isVisible = false

		end
		})

		hardDex.tween = transition.to(hardDex, {transition = easing.outExpo, y = H + 100, time = outTime,
			onComplete = function()
			dscreen:cancelTween(hardDex)
			hardDex.isVisible = false

		end
		})

		hardcoreDex.tween = transition.to(hardcoreDex, {transition = easing.outExpo, y = H + 100, time = outTime,
			onComplete = function()
			dscreen:cancelTween(hardcoreDex)
			hardcoreDex.isVisible = false
			
		end
		})

	end

	function dscreen:cancelTween(obj)
		if obj.tween ~= nil then
			transition.cancel(obj.tween)
			obj.tween = nil
		end
	end

	function dscreen:destroy()
		dscreen = nil
	end

	dscreen:init()

	return dscreen
end

return DifficultyScreen