function onCreate()
	-- background shit

     makeLuaSprite('wall','wall',-600,-800)
     addLuaSprite('wall',false)
     setLuaSpriteScrollFactor('wall', 1.1,1.1)

     makeLuaSprite('floor','floor',-260,500)
     addLuaSprite('floor',false)

	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end