StartScreen = {}

function StartScreen:new()
	
	local sscreen = display.newGroup()

	function sscreen:init()

		local ssBackground = self:getImg("src/bg.png")
		self.ssBackground = ssBackground

		local ssTitle = self:getImg("src/title.png")
		self.ssTitle = ssTitle

		local playBtn = self:getBtn("src/btnPlay.png")
		self.playBtn = playBtn

		local infoBtn = self:getBtn("src/btnInfo.png")
		self.infoBtn = infoBtn

		local storeBtn = self:getBtn("src/btnInfo.png")
		self.storeBtn = storeBtn
	end

	function sscreen:getImg(image)
		local img = display.newImage(image)
		img.anchorX = 0.5
		img.anchorY = 0.5
		self:insert(img)

		return img
	end

	function sscreen:getBtn(image)
		local img = display.newImage(image)
		img.anchorX = 0.5
		img.anchorY = 0.5
		self:insert(img)

		function img:touch(event)
			sscreen:onBtnTouch(event)
		end

		img:addEventListener("touch", img)
		return img
	end

	function sscreen:onBtnTouch(event)
		local p = event.phase
		local tgt = event.target

		if p == "ended" then
			if tgt == self.playBtn then
				Runtime:dispatchEvent({name = "playBtnTouched", target = sscreen})
			elseif tgt == self.infoBtn then
				Runtime:dispatchEvent({name = "infoBtnTouched", target = sscreen})
			elseif tgt == self.storeBtn then
				Runtime:dispatchEvent({name = "storeBtnTouched", target = sscreen})
			end

			return true
		end
	end

	function sscreen:show()
		local ssBackground = self.ssBackground
		local ssTitle = self.ssTitle
		local playBtn = self.playBtn
		local infoBtn = self.infoBtn
		local storeBtn = self.storeBtn

		local inTime 		= 1250
		
		setPos(ssBackground, centerX, centerY)
		setPos(ssTitle, centerX, -centerY)
		setPos(playBtn, centerX, -centerY)
		setPos(infoBtn, centerX - infoBtn.width, H + centerY)
		setPos(storeBtn, centerX + storeBtn.width, H + centerY)

		ssBackground.isVisible = true
		infoBtn.isVisible = true
		storeBtn.isVisible = true
		ssTitle.isVisible = true
		playBtn.isVisible = true

		self:cancelTween(ssTitle)
		self:cancelTween(playBtn)
		self:cancelTween(infoBtn)
		self:cancelTween(storeBtn)

		ssTitle.tween = transition.to(ssTitle, {
				transition = easing.outExpo,
				y = centerY - 75,
				time = inTime, 
			
			onComplete = function()
			sscreen:cancelTween(ssTitle)
			end
		})
		playBtn.tween = transition.to(playBtn, {
				transition = easing.outExpo, 
				y = centerY + 30, 
				time = inTime, 

			onComplete = function()
			sscreen:cancelTween(playBtn)
			end
		})
		infoBtn.tween = transition.to(infoBtn, {
				transition = easing.outExpo, 
				y = centerY + 130,
				time = inTime,

			onComplete = function()
			sscreen:cancelTween(infoBtn)
			end
		})
		storeBtn.tween = transition.to(storeBtn, {
				transition = easing.outExpo, 
				y = centerY + 130,
				time = inTime,

			onComplete = function()
			sscreen:cancelTween(storeBtn)
			end
		})
	end

	function sscreen:hide()
		local ssBackground = self.ssBackground
		local ssTitle = self.ssTitle
		local playBtn = self.playBtn
		local infoBtn = self.infoBtn
		local storeBtn = self.storeBtn

		local outTime 		= 1000

		self:cancelTween(ssTitle)
		self:cancelTween(playBtn)
		self:cancelTween(infoBtn)
		self:cancelTween(storeBtn)
	
		playBtn.tween = transition.to(playBtn, {
				transition = easing.expo, 
				y = -centerY, 
				time = outTime,

			onComplete = function()
			sscreen:cancelTween(playBtn)
			playBtn.isVisible = false
			end
		})
		ssTitle.tween = transition.to(ssTitle, {
				transition = easing.expo,
				y = -centerY,
				time = outTime,

			onComplete = function()
			sscreen:cancelTween(ssTitle)
			ssTitle.isVisible = false
			end
		})

		infoBtn.tween = transition.to(infoBtn, {
				transition = easing.outExpo,
				y = H + centerY,
				time = outTime,

			onComplete = function()
			sscreen:cancelTween(infoBtn)
			infoBtn.isVisible = false
			end
		})
		storeBtn.tween = transition.to(storeBtn, {
				transition = easing.outExpo,
				y = H + centerY,
				time = outTime,

			onComplete = function()
			sscreen:cancelTween(storeBtn)
			storeBtn.isVisible = false
			end
		})

		ssBackground.isVisible = false
	end

	function sscreen:credits()
		local ssBackground = self.ssBackground
		local ssTitle = self.ssTitle
		local playBtn = self.playBtn
		local infoBtn = self.infoBtn
		local storeBtn = self.storeBtn

		local inTime 		= 1250
		
		setPos(ssBackground, centerX, centerY)
		setPos(ssTitle, centerX, -centerY)
		setPos(playBtn, centerX, -centerY)
		setPos(infoBtn, centerX - infoBtn.width, H + centerY)
		setPos(storeBtn, centerX + storeBtn.width, H + centerY)

		ssBackground.isVisible = true
		infoBtn.isVisible = true
		storeBtn.isVisible = true
		ssTitle.isVisible = true
		playBtn.isVisible = true

		self:cancelTween(ssTitle)
		self:cancelTween(playBtn)
		self:cancelTween(infoBtn)
		self:cancelTween(storeBtn)

		ssTitle.tween = transition.to(ssTitle, {
				transition = easing.outExpo,
				y = centerY - 75,
				time = inTime, 
			
			onComplete = function()
			sscreen:cancelTween(ssTitle)
			end
		})
		playBtn.tween = transition.to(playBtn, {
				transition = easing.outExpo, 
				y = centerY + 30, 
				time = inTime, 

			onComplete = function()
			sscreen:cancelTween(playBtn)
			end
		})
		infoBtn.tween = transition.to(infoBtn, {
				transition = easing.outExpo, 
				y = centerY + 130,
				time = inTime,

			onComplete = function()
			sscreen:cancelTween(infoBtn)
			end
		})
		storeBtn.tween = transition.to(storeBtn, {
				transition = easing.outExpo, 
				y = centerY + 130,
				time = inTime,

			onComplete = function()
			sscreen:cancelTween(storeBtn)
			end
		})
	end

	function sscreen:store()
		local ssBackground = self.ssBackground
		local ssTitle = self.ssTitle
		local playBtn = self.playBtn
		local infoBtn = self.infoBtn
		local storeBtn = self.storeBtn

		local inTime 		= 1250
		
		setPos(ssBackground, centerX, centerY)
		setPos(ssTitle, centerX, -centerY)
		setPos(playBtn, centerX, -centerY)
		setPos(infoBtn, centerX - infoBtn.width, H + centerY)
		setPos(storeBtn, centerX + storeBtn.width, H + centerY)

		ssBackground.isVisible = true
		infoBtn.isVisible = true
		storeBtn.isVisible = true
		ssTitle.isVisible = true
		playBtn.isVisible = true

		self:cancelTween(ssTitle)
		self:cancelTween(playBtn)
		self:cancelTween(infoBtn)
		self:cancelTween(storeBtn)

		ssTitle.tween = transition.to(ssTitle, {
				transition = easing.outExpo,
				y = centerY - 75,
				time = inTime, 
			
			onComplete = function()
			sscreen:cancelTween(ssTitle)
			end
		})
		playBtn.tween = transition.to(playBtn, {
				transition = easing.outExpo, 
				y = centerY + 30, 
				time = inTime, 

			onComplete = function()
			sscreen:cancelTween(playBtn)
			end
		})
		infoBtn.tween = transition.to(infoBtn, {
				transition = easing.outExpo, 
				y = centerY + 130,
				time = inTime,

			onComplete = function()
			sscreen:cancelTween(infoBtn)
			end
		})
		storeBtn.tween = transition.to(storeBtn, {
				transition = easing.outExpo, 
				y = centerY + 130,
				time = inTime,

			onComplete = function()
			sscreen:cancelTween(storeBtn)
			end
		})
	end

	function sscreen:moveDefault()
		local ssBackground = self.ssBackground
		local ssTitle = self.ssTitle
		local playBtn = self.playBtn
		local infoBtn = self.infoBtn
		local storeBtn = self.storeBtn

		local outTime 		= 1000

		self:cancelTween(ssTitle)
		self:cancelTween(playBtn)
		self:cancelTween(infoBtn)
		self:cancelTween(storeBtn)
	
		playBtn.tween = transition.to(playBtn, {
				transition = easing.expo, 
				y = -centerY, 
				time = outTime,

			onComplete = function()
			sscreen:cancelTween(playBtn)
			playBtn.isVisible = false
			end
		})
		ssTitle.tween = transition.to(ssTitle, {
				transition = easing.expo,
				y = -centerY,
				time = outTime,

			onComplete = function()
			sscreen:cancelTween(ssTitle)
			ssTitle.isVisible = false
			end
		})

		infoBtn.tween = transition.to(infoBtn, {
				transition = easing.outExpo,
				y = H + centerY,
				time = outTime,

			onComplete = function()
			sscreen:cancelTween(infoBtn)
			infoBtn.isVisible = false
			end
		})
		storeBtn.tween = transition.to(storeBtn, {
				transition = easing.outExpo,
				y = H + centerY,
				time = outTime,

			onComplete = function()
			sscreen:cancelTween(storeBtn)
			storeBtn.isVisible = false
			end
		})

		ssBackground.isVisible = false
	end

	function sscreen:cancelTween(obj)
		if obj.tween ~= nil then
			transition.cancel(obj.tween)
			obj.tween = nil
		end
	end

	sscreen:init()

	return sscreen
end

return StartScreen