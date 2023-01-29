function onCreate()
	-- background shit

     makeLuaSprite('discord','Discord',0,0)
     addLuaSprite('discord',false)

	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end