Player = {}

function Player:spawn()
	player = display.newImage("src/player.png")
	player.myName = "player"
	setScale(player, .9)
	player.alpha = 1
	setPos(player, centerX / 6, centerY)
	physics.addBody(player, "static")

	function movePlayerToPos(eventP)
		if isDead == false then
			player.tween = transition.to(player, {
				time = 900, y = eventP.y, transition = easing.outQuad, onComplete = function()
					if player.tween ~= nil then
						transition.cancel(player.tween)
						player.tween = nil
					end
				end
			})	
		end
	end

	function Player:stopPlayer()
		setPos(player, player.x, player.y)
		if player.tween ~= nil then
			transition.cancel(player.tween)
			player.tween = nil
		end		
		Runtime:removeEventListener("touch", movePlayerToPos)
	end

	function Player:movePlayer()
		Runtime:addEventListener("touch", movePlayerToPos)
	end
end

return Player