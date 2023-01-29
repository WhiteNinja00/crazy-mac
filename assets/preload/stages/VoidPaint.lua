function onCreate()
	-- background shit

     makeLuaSprite('walPaint','walPaint',-600,-800)
     addLuaSprite('walPaint',false)
     setLuaSpriteScrollFactor('walPaint', 1.1,1.1)

     makeLuaSprite('floorPaint','floorPaint',-260,500)
     addLuaSprite('floorPaint',false)

	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end