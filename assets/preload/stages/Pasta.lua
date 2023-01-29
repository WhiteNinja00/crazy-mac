function onCreate()
	-- background shit

     makeLuaSprite('pastanight bg','pastanight bg',0,0)
     addLuaSprite('pastanight bg',false)

	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end