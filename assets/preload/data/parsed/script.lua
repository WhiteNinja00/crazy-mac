local elapsedtime = 0
local shaderName = 'vcrshader'

function onSongStart()
	noteTweenX("NoteMove1", 0, -1000, 0.5, cubeInOut)
	noteTweenX("NoteMove2", 1, -1000, 0.5, cubeInOut)
	noteTweenX("NoteMove3", 2, -1000, 0.5, cubeInOut)
	noteTweenX("NoteMove4", 3, -1000, 0.5, cubeInOut)
end

function onCreate()
	setProperty('gf.visible', false)
end	

function onCreatePost()
    initLuaShader(shaderName)

    makeLuaSprite("shaderImage")
    makeGraphic("shaderImage", screenWidth, screenHeight)

    setSpriteShader("shaderImage", shaderName)

    addHaxeLibrary("ShaderFilter", "openfl.filters")
    runHaxeCode([[
        trace(ShaderFilter);
        game.camGame.setFilters([new ShaderFilter(game.getLuaObject("shaderImage").shader)]);
        game.camHUD.setFilters([new ShaderFilter(game.getLuaObject("shaderImage").shader)]);
    ]])
end

function onUpdatePost(elapsed)
     elapsedtime = elapsedtime + elapsed
     setShaderFloat("shaderImage", 'iTime', elapsedtime)
end
