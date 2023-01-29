local defaultNotePos = {};
local window_default = {}
function boundTo(value, min, max) return math.max(min, math.min(max, value)) end
function math.lerp(from,to,i)return from+(to-from)*i end
function onCreate()
    setPropertyFromClass("openfl.Lib", "application.window.borderless",true)
    setPropertyFromClass("openfl.Lib", "application.window.maximized",false)
end
function onCreatePost()
    window_default[1] = getPropertyFromClass("openfl.Lib", "application.window.x")
	window_default[2] = getPropertyFromClass("openfl.Lib", "application.window.y")
if downscroll then
    setProperty('healthTS.y',80)
end
setObjectCamera('healthTS','camHUD')
setProperty('healthBarBG.visible',true)
setObjectOrder('healthTS',getObjectOrder('healthBar')+1)
    setPropertyFromClass("openfl.Lib", "application.window.y",-800)
setProperty('camGame.visible',true)

local windowmove2 = false
local movehud = false
local hudx = -4
local bruhy = 0
local multival = 0
local multix = 0
local multiy = 0
local windowcamera = false
local bfturn = false
local startedmove = false
local thv = 1.2
function onMoveCamera(focus)
	if focus == 'boyfriend' then
	bfturn = true
	elseif focus == 'dad' then
	bfturn = false
	end
end
function onCountdownTick(counter)
  if counter == 4 then
    cameraFlash('other', 'FFFFFF', 0.7, true)
    setPropertyFromClass("openfl.Lib", "application.window.borderless",true)
    setPropertyFromClass("openfl.Lib", "application.window.x",window_default[1])
    setPropertyFromClass("openfl.Lib", "application.window.y",window_default[2])
    setPropertyFromClass("openfl.Lib", "application.window.maximized",false)
    startedmove = true
end
end

function onUpdate(elapsed)
    song_position = -(getPropertyFromClass("Conductor", "songPosition") / 1000) / 0.5
if startedmove then
    setPropertyFromClass("openfl.Lib", "application.window.y", math.lerp(getPropertyFromClass("openfl.Lib", "application.window.y"), window_default[2], boundTo(elapsed * 10, 0, 1)))
end

function onUpdate(elapsed)
    song_position = -(getPropertyFromClass("Conductor", "songPosition") / 1000) / 0.5
if startedmove then
    setPropertyFromClass("openfl.Lib", "application.window.y", math.lerp(getPropertyFromClass("openfl.Lib", "application.window.y"), window_default[2], boundTo(elapsed * 10, 0, 1)))
end

if curStep == 320 then
    windowmove2 = true
    setProperty('camGame.visible',true)
    cameraFlash('other', 'FFFFFF', 0.3, false)
end

if curStep == 1856 then
    windowmove2 = true
    setProperty('camGame.visible',true)
    cameraFlash('other', 'FFFFFF', 0.3, false)
end

if curStep == 896 then
    windowmove = true
    setProperty('camGame.visible',true)
    cameraFlash('other', 'FFFFFF', 0.3, false)
end

if windowmove then
    setPropertyFromClass("openfl.Lib", "application.window.x",window_default[1] + 85  * math.cos((song_position) * (math.pi / 3 + multival)))
    setPropertyFromClass("openfl.Lib", "application.window.y",window_default[2] + 35 * math.sin((song_position) * (math.pi / 3)))
     setProperty("camHUD.angle", -2 * math.sin((song_position) * (math.pi / 3 + multival)))
     setProperty("camGame.angle", -2 * math.sin((song_position) * (math.pi / 3 + multival)))
end
if windowmove2 then
    setPropertyFromClass("openfl.Lib", "application.window.x",window_default[1] + 85  * math.cos((song_position) * (math.pi / 3)))
    setPropertyFromClass("openfl.Lib", "application.window.y",window_default[2] + 35 * math.sin((song_position) * (math.pi / 3)))
     setProperty("camHUD.angle", -2 * math.sin((song_position) * (math.pi / 3)))
     setProperty("camGame.angle", -2 * math.sin((song_position) * (math.pi / 3)))
 end

 if curStep == 576 then
    windowmove2 = false
    cameraFlash('other', 'FFFFFF', 0.3, false)
    setPropertyFromClass("openfl.Lib", "application.window.borderless",true)
    setPropertyFromClass("openfl.Lib", "application.window.x",window_default[1])
    setPropertyFromClass("openfl.Lib", "application.window.y",window_default[2])
    setPropertyFromClass("openfl.Lib", "application.window.maximized",false)
      setProperty('camHUD.angle',0)
     setProperty('camGame.angle',0) 
    end
 if curStep == 1984 then
    windowmove2 = false
    cameraFlash('other', 'FFFFFF', 0.3, false)
    setPropertyFromClass("openfl.Lib", "application.window.borderless",true)
    setPropertyFromClass("openfl.Lib", "application.window.x",window_default[1])
    setPropertyFromClass("openfl.Lib", "application.window.y",window_default[2])
    setPropertyFromClass("openfl.Lib", "application.window.maximized",false)
      setProperty('camHUD.angle',0)
     setProperty('camGame.angle',0) 
    end
 if curStep == 1152 then
    windowmove = false
    cameraFlash('other', 'FFFFFF', 0.3, false)
    setPropertyFromClass("openfl.Lib", "application.window.borderless",true)
    setPropertyFromClass("openfl.Lib", "application.window.x",window_default[1])
    setPropertyFromClass("openfl.Lib", "application.window.y",window_default[2])
    setPropertyFromClass("openfl.Lib", "application.window.maximized",false)
      setProperty('camHUD.angle',0)
     setProperty('camGame.angle',0) 
    end
  end
end
end
function onDestroy()
setPropertyFromClass("openfl.Lib", "application.window.borderless",false)
setPropertyFromClass("openfl.Lib", "application.window.x",window_default[1])
setPropertyFromClass("openfl.Lib", "application.window.y",window_default[2])
setPropertyFromClass("openfl.Lib", "application.window.maximized",false)
end