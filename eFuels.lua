Fuels = {}

function Fuels:spawn()	
	function doFuels()

		local function spawn(params)
			local fuel = display.newImage(params.image)
			setPos(fuel, W + math.random(50, 75), math.random(20, H - fuel.height - 10))
			setScale(fuel, .9)
			fuel.objTable = params.objTable
			fuel.index = #fuel.objTable + 1
			
			fuel.myName = "fuel : " .. fuel.index

			if params.hasBody then
				fuel.density = params.density or 0
				fuel.friction = params.friction or 0
				fuel.bounce = params.bounce or 0
				fuel.isSensor = params.isSensor or false
				fuel.bodyType = params.bodyType or "dynamic"
				
				physics.addBody(fuel, fuel.bodyType, {density = fuel.density, friction = fuel.friction, bounce = fuel.bounce, isSensor = fuel.isSensor})
			end
			
			fuel.group = params.group or nil
			
			fuel.group:insert(fuel)

			fuel.objTable[fuel.index] = fuel

			function onFuelCollision(e)

				if e.phase == "began" then
					if e.other.myName == 'player' then
						fuel:removeSelf()
						fuel = nil
						addFuel()		
					elseif e.other.myName == "stageEnd" then
						fuel:removeSelf()
						fuel = nil
					end
				end
			end
			fuel.objTable[fuel.index]:addEventListener("collision", onFuelCollision)

			return fuel
		end

		local localGroup = display.newGroup()

		spawnTableF = {}

		function spawnFuel()
			if isDead == false and paused == false then
				local spawns = spawn(
					{
						image = "src/fuel.png",
						objTable = spawnTableF,
						hasBody = true,
						group = localGroup,
					}
				)
			end
		end

		function addFuel()
			addFuelMain()
		end

		fuelTimer = timer.performWithDelay(10000, spawnFuel, 0)

	end
	doFuels()
end

return Fuels