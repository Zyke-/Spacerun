Hearts = {}

function Hearts:spawn()

	function doHearts()
		local function spawnH(params)
			local heart = display.newImage(params.image)
			setScale(heart, .9)
			setPos(heart, W + math.random(50, 75), math.random(10, H - 10))

			heart.objTable = params.objTable
			heart.index = #heart.objTable + 1
			
			heart.myName = "heart : " .. heart.index

			if params.hasBody then
				heart.density = params.density or 0
				heart.friction = params.friction or 0
				heart.bounce = params.bounce or 0
				heart.isSensor = params.isSensor or false
				heart.bodyType = params.bodyType or "dynamic"

				physics.addBody(heart, heart.bodyType, {density = heart.density, friction = heart.friction, bounce = heart.bounce, isSensor = heart.isSensor})
			end

			heart.group = params.group or nil
			
			heart.group:insert(heart)

			heart.objTable[heart.index] = heart

			function onHeartCollision(e)

				local function addLife()
					if playerLife < maxLife then
    					playerLife = playerLife + 1
    					life[playerLife].isVisible = true
					end
				end

				if e.phase == "began" then
					if e.other.myName == "player" then
						heart:removeSelf()
						heart = nil
						addLife()
					elseif e.other.myName == "stageEnd" then
						heart:removeSelf()
						heart = nil
					end
				end
			end
			heart.objTable[heart.index]:addEventListener("collision", onHeartCollision)

			return heart
		end

		local localGroupH = display.newGroup()

		spawnTableH = {}

		function spawnHeart()
			if isDead == false and paused == false then
				local spawns = spawnH(
					{
						image = "src/heart.png",
						objTable = spawnTableH,
						hasBody = true,
						group = localGroupH,
					}
				)
			end
		end
		if canSpawnH then
			heartTimer = timer.performWithDelay(math.random(spawnRateH_MIN, spawnRateH_MAX), spawnHeart, 0)
		end

	end

	doHearts()
end

return Hearts