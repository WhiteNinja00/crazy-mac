function onCreate()
	-- background shit

     makeLuaSprite('DarkVoid','DarkVoid',-600,-800);
     addLuaSprite('DarkVoid',false);

	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end