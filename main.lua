--- 		Spacerun			---
--- 		by Vince Games 		---

require "api"
require "beebegames"

Version = "1.0b"
Build = loadValue("build.data")
Build = (Build + 1)*0
saveValue("build.data", tostring(Build))

print("\nSpacerun")
print("Version: " .. getVesion(), "\n")

function HUD()
	require "sStartScreen"
	require "sDifficultyScreen"
	require "sStoreScreen"
	require "sFuelScreen"
	require "sMenuScreen"

	display.setStatusBar = (display.HiddenStatusBar)
	UIStatusBarHidden = true
	
	startScreen = StartScreen:new()
	storeScreen = StoreScreen:new()
	difficultyScreen = DifficultyScreen:new()
	fuelScreen = FuelScreen:new()
end

function init()
	require "eEnemies"
	require "eCoins"
	require "ePlayer"
	require "eHearts"
	require "eFuels"

	--backgroundMusic = audio.loadStream("src/backgroundMusic.mp3")
	sfxExplosion = audio.loadSound("sfx/explosion.mp3")
	audio.setMaxVolume(.8)

	local physics = require "physics"
	physics.start()
	gravitySpeed = 4
	physics.setGravity(-gravitySpeed, 0)
	--system.activate("multitouch")

	local btnPause
	maxFuel = 28
	fuelToAdd = 5
	firstPlay = true
	canPlay = true
	canStore = true
end

function loadHighScore()
    local loadedHighScore = loadValue("highScore.data")
    if loadedHighScore == nil then
    	loadedHighScore = 0
    end  
    highScore = tonumber(loadedHighScore)

    highScoreText = display.newText("Your Highscore: " .. highScore, 0, 0, native.systemFont, 16)
	highScoreText.anchorX = 0.5
	highScoreText.anchorY = 0.5

	setPos(highScoreText, centerX, centerY + 90)
end

function loadCredits()
    versionText = display.newText("Version " .. getVesion(), 0, 0, native.systemFont, 11)
    creditsText = display.newText("Vince Games", 0, 0, native.systemFont, 11)

	creditsText.anchorX = .5
	creditsText.anchorY = .5

	creditsText.anchorX = .5
	creditsText.anchorY = .5

	setPos(creditsText, 0 + creditsText.width/5, H - creditsText.height)
	setPos(versionText, W - versionText.width/5, H - versionText.height)
end

function startScreenHandler()
	startScreen:toFront()
	startScreen:show()
	loadHighScore()
	loadCredits()

	Runtime:addEventListener("playBtnTouched", function(e)
		if canPlay then
			display.remove(versionText)
			versionText = nil
			display.remove(creditsText)
    		creditsText = nil
			startScreen:hide()
			if highScoreText ~= nil then
				display.remove(highScoreText)
				highScoreText = nil
			end
			
			displayDifficulty()
			Runtime:removeEventListener("palyBtnTouched")
			Runtime:removeEventListener("backBtnITouched")
			Runtime:removeEventListener("storeBtnTouched")
			Runtime:removeEventListener("backBtnSTouched")
		end
	end)		
	Runtime:addEventListener("storeBtnTouched", function(e)
		if canStore then
			canStore = false
			canPlay = false
			storeScreen:show()
			storeScreen:toFront()
		end
		Runtime:addEventListener("backBtnSTouched", function(e)
			storeScreen:hide()
			canStore = true
			canPlay = true
		end)
	end)
end

function displayDifficulty()
	difficultyScreen:toFront()
	difficultyScreen:show()
	Runtime:addEventListener("difficultyBackBtnTouched", function(e)
		difficultyScreen:hide()
		startScreenHandler()
	end)

	Runtime:addEventListener("normalBtnTouched", function(e)
		difficultyScreen:hide()
		maxLife = 5
		gravitySpeed = 3
		spawnRateH_MIN = 20000
		spawnRateH_MAX = 40000
		main()
	end)

	Runtime:addEventListener("hardBtnTouched", function(e)
		difficultyScreen:hide()
		maxLife = 3
		gravitySpeed = 4
		spawnRateH_MIN = 50000
		spawnRateH_MAX = 100000
		main()
	end)

	Runtime:addEventListener("hardcoreBtnTouched", function(e)
		difficultyScreen:hide()
		maxLife = 1
		gravitySpeed = 5
		canSpawnH = false
		main()
	end)
end

function main()
	if firstPlay then
		displayBackground()
	end
	gameStart()
	displayMenu()
	pauseToggle()

	if firstPlay then
		musicSwitch()
		gameOver()
	end
end

function gameStart()
	score = 0							-- Resets Variables
	playerLife = maxLife 				
	playerFuel = maxFuel
	spawnT = 2000
	spawnRateH_MIN = 20000
	spawnRateH_MAX = 40000

	isDead = false						-- Player is no longer dead
	paused = false						-- Game is no longer paused
	physics.start()

	physics.setGravity(-gravitySpeed, 0)

	if firstPlay then
		setStageEnd()
		Player:spawn()
		Hearts:spawn()
		Enemies:spawn()
		Coins:spawn()
		Fuels:spawn()
		fuelScreen:consumeFuel()
		firstPlay = false
	end

	Player:movePlayer()
	displayScore()
	displayLife()
	displayFuel()
end

function displayLife()
	if life ~= nil then
		for i = 0, #life do
			display.remove(life[i])
			life[i] = nil
		end
	end

	life = {}
	local i
	for i = 1, maxLife do
		life[i] = display.newImage("src/heart.png")
		setScale(life[i], .9)
		life[i].x = 125 + (life[i].width * (i - 1))
		life[i].y = 30
		life[i].alpha = .9
	end
end

function displayFuel()
	fuelScreen:toFront()
	fuelScreen:show()
	fuelScreen:resetFuel()
end

function displayScore()
	if textScore then
		display.remove(textScore)
		textScore = nil
	end
	textScore = display.newText("Score: ", 0, 0, native.systemFont, 18)
	setPos(textScore, 10, 30)
	textScore:setFillColor(1, 1, 1)
	updateScore()
end

function updateScore()
	if score == nil then
		score = 0
	end
	textScore.text = "Score: " .. score
end

function displayBackground()
	backGround = display.newImage("src/bg.png")
	backGround2 = display.newImage("src/bg.png")

	setScale(backGround, .5)
	setScale(backGround2, .5)

	setPos(backGround, centerX, centerY)
	backGround2.y = centerY 

	backGround.alpha = .3
	backGround2.alpha = .3

	backGround.anchorX = 0
	backGround.anchorY = 0.5

	backGround2.anchorX = 0
	backGround2.anchorY = 0.5
	 
	local tPrevious = system.getTimer()
	local function moveBackground(event)

		local tDelta = event.time - tPrevious
		tPrevious = event.time

		if isDead == false and paused == false then	
			local xOffset = ( 0.15 * tDelta )
		 
			backGround.x = backGround.x - xOffset
			backGround2.x = backGround2.x - xOffset
			if (backGround.x + backGround.contentWidth) < 0 then
				backGround:translate( 1900 * 2, 0)
			end
			if (backGround2.x + backGround2.contentWidth) < 0  then
				backGround2:translate( 1900 * 2, 0)
			end
		end
	end
	Runtime:addEventListener("enterFrame", moveBackground) 
end

function setStageEnd()
	stageEnd = display.newRect(-100, 0, 1, H)
	stageEnd.alpha = 0
	stageEnd.myName = "stageEnd"
	physics.addBody(stageEnd, "static")
end

function displayMenu()
	menuScreen = MenuScreen:new()
	menuScreen.isVisible = false

	Runtime:addEventListener("continueBtnTouched", function(e) resumeGame() end)
	Runtime:addEventListener("musicBtnTouched", function(e) musicSwitch() end)
end

function gameOver(death)
	isDead = death
	if isDead == true then 
		physics.pause()
		paused = true

		-- Cancel, nil out, and canceAllTimers()	TODO

		if score > highScore then
     		highScore = score
     		saveValue("highScore.data", tostring(highScore))
    	end

		function gameOverSelect(event)
			if "clicked" == event.action then
				local i = event.index
				local replay = 1
				local menu = 2
				cleanStage()
				audio.stop()
				Player:stopPlayer()
				isMusicPlaying = false

				if i == replay then
					gameStart()
				elseif i == menu then
					startScreenHandler()
				end
			end
   		end

   		local alertBox = native.showAlert( "Game Over",
				"Coins collected: " .. score .. "   Highscore: " .. tostring(highScore),
				{"Replay", "Menu"}, gameOverSelect)
	end
end

function musicSwitch()
--[[load()
	local m = gameData.musicOn
	save()

	if m == true then
		audio.stop()
		m = false
	elseif m == false then
		backgroundMusicChannel = audio.play(backgroundMusic, {channel = 1, loops =  -1, fadein = 1000})
		m = true
	end

	load()
	gameData.musicOn = m
	save()
	]]
end

function pauseToggle()
	function pauseGame()
		Player:stopPlayer()
		physics.pause()
		btnPause.alpha = .1
		pauseAllTimers()
		menuScreen:show()
		
		audio.setVolume(.2)

		paused = true
	end

	function resumeGame()
		physics.start()
		btnPause.alpha = 1
		resumeAllTimers()
		menuScreen:hide()
		Player:movePlayer()

		audio.setVolume(.9)

		paused = false
	end

	local function pause()
		menuScreen.isVisible = true
		if paused == false and isDead == false then
			pauseGame()
		end
	end

	btnPause = display.newImage("src/pauseButton.png")
	setPos(btnPause, (W - 35), 35)
	setScale(btnPause, .2)

	btnPause:addEventListener("tap", pause)
end

function cleanStage()
	local i
	if spawnTableE ~= nil then
	for i = 0, #spawnTableE do
		display.remove(spawnTableE[i])
		spawnTableE[i] = nil
	end
	end
	if spawnTableC ~= nil then
	for i = 0, #spawnTableC do
		display.remove(spawnTableC[i])
		spawnTableC[i] = nil
	end
	end
	if spawnTableH ~= nil then
	for i = 0, #spawnTableH do
		display.remove(spawnTableH[i])
		spawnTableH[i] = nil
	end
	end
end

----------------------------------		Other connectivity functions

function addFuelMain()
	fuelScreen:addFuel()
end



----------------------------------
init()
HUD()
startScreenHandler()