function onCreate()
	-- background shit

     makeLuaSprite('mts vid','mts vid',0,0)
     addLuaSprite('mts vid',true)

     makeLuaSprite('mts yt','mts yt',0,0)
     addLuaSprite('mts yt',false)

	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end