Enemies = {}

function Enemies:spawn()
	function doEnemies()
		if isDead == false then
			local function spawnE(params)
				local enemy = display.newImage(params.image)
				setPos(enemy, W + math.random(75, 150), math.random(20, H - enemy.height - 10))
				enemy.objTable = params.objTable
				enemy.index = #enemy.objTable + 1
				enemy.myName = "enemy" .. enemy.index

				if params.hasBody then
					enemy.density = params.density or 0
					enemy.friction = params.friction or 0
					enemy.rotation = params.rotation or 0
					enemy.bounce = params.bounce or 0
					enemy.isSensor = params.isSensor or false
					enemy.bodyType = params.bodyType or "dynamic"

					physics.addBody(enemy, enemy.bodyType, {density = enemy.density, friction = enemy.friction, bounce = enemy.bounce, isSensor = enemy.isSensor})
				end
				
				enemy.group = params.group or nil
				
				enemy.group:insert(enemy)
				
				enemy.objTable[enemy.index] = enemy

				function onEnemyCollision(e)
					function playerHit()
						if playerLife > 0 then
							life[playerLife].isVisible = false
							playerLife = playerLife - 1
						end
						if playerLife == 0 then
							audio.play(sfxExplosion)
							isDead = true
							gameOver(isDead)
						end
					end

					function animationExplosion()
						
						-- To Do
					end

					if e.phase == "began" then
						if e.other.myName == "player" then
							playerHit()
							animationExplosion()
							display.remove(enemy)
							enemy = nil
						elseif e.other.myName == "stageEnd" then
							if enemy ~= nil then
								display.remove(enemy)
								enemy = nil
							end
						end
					end
				end

				enemy.objTable[enemy.index]:addEventListener("collision", onEnemyCollision)

				return enemy
			end

			local localGroup = display.newGroup()

			spawnTableE = {}

			function spawnEnemy()
				if isDead == false and paused == false then			
					local spawns = spawnE(
						{
							image = randomImage(),
							objTable = spawnTableE,
							rotation = 1,
							hasBody = true,
							group = localGroup,
						}
					)

					timer.cancel(spawnEnemyT)
					doEnemyT()
				end
			end

			--- Spawning Timing
			function doEnemyT()
				if spawnT > 500 then
					spawnT = spawnT - math.random(50, 75)
				end
				spawnEnemyT = timer.performWithDelay(spawnT, spawnEnemy, 0)
				
			end
			---

			--- Special Spawning Timing
			function doEnemyTSpecial()
				if isDead == false and paused == false then
					print("Incoming!")
					for st = 0, 5 do
						spawnEnemy()
					end
					spawnHT = timer.performWithDelay(2000, spawnHeart(), 1)
				end
			end
			spawnEnemyTSpecial = timer.performWithDelay(25000, doEnemyTSpecial, 0)
			---

			doEnemyT()
			spawnEnemy()
		end
	end
	doEnemies()
end

return Enemies