Coins = {}

function Coins:spawn()	
	function doCoins()
		local function spawn(params)
			local coin = display.newImage(params.image)
			setPos(coin, W + math.random(50, 75), math.random(20, H - coin.height - 10))
			setScale(coin, .9)
			coin.objTable = params.objTable
			coin.index = #coin.objTable + 1
			
			coin.myName = "coin : " .. coin.index

			if params.hasBody then
				coin.density = params.density or 0
				coin.friction = params.friction or 0
				coin.bounce = params.bounce or 0
				coin.isSensor = params.isSensor or false
				coin.bodyType = params.bodyType or "dynamic"
				
				physics.addBody(coin, coin.bodyType, {density = coin.density, friction = coin.friction, bounce = coin.bounce, isSensor = coin.isSensor})
			end
			
			coin.group = params.group or nil
			
			coin.group:insert(coin)

			coin.objTable[coin.index] = coin

			function onCoinCollision(e)

				local function addScore()
					score = score + 1
					textScore.text = "Score: " .. score
				end

				if e.phase == "began" then
					if e.other.myName == 'player' then
						coin:removeSelf()
						coin = nil
						addScore()
					elseif e.other.myName == "stageEnd" then
						coin:removeSelf()
						coin = nil
					end
				end
			end
			coin.objTable[coin.index]:addEventListener("collision", onCoinCollision)

			return coin
		end

		local localGroup = display.newGroup()

		spawnTableC = {}

		function spawnCoin()
			if isDead == false and paused == false then
				local spawns = spawn(
					{
						image = "src/coin.png",
						objTable = spawnTableC,
						hasBody = true,
						group = localGroup,
					}
				)
			end
		end

		coinTimer = timer.performWithDelay(2500, spawnCoin, 0)
	end
	doCoins()
end

return Coins