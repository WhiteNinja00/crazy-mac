local turn = 10
local turn2 = 20
local y = 0;
local x = 0;
local canBob = true
local Strums = 'opponentStrums'

function onCreate()
    math.randomseed(os.clock() * 1000);
    makeLuaSprite('bartop','',0,0);
	makeGraphic('bartop',1280,100,'000000');
	addLuaSprite('bartop',false);
	makeLuaSprite('barbot','',0,620);
	makeGraphic('barbot',1280,100,'000000');
	addLuaSprite('barbot',false);
	setScrollFactor('bartop',0,0);
	setScrollFactor('barbot',0,0);
	setObjectCamera('bartop','hud');
	setObjectCamera('barbot','hud');
    setProperty('skipCountdown', true)
end

function onCreatePost()
	setProperty('scoreTxt.y', 12);
	setProperty('timeTxt.visible', false);
	setProperty('timeBar.visible', false);
	setProperty('iconP1.alpha', 0);
	setProperty('iconP2.alpha', 0);
	if getPropertyFromClass('ClientPrefs', 'downScroll') == true then
		setProperty('scoreTxt.y', 32);
		setProperty('healthBar.y', 15);
		else if getPropertyFromClass('ClientPrefs', 'downScroll') == false then
			setProperty('scoreTxt.y', 660);
			setProperty('healthBar.y', 700);
		end
	end
end

function onUpdate(elapsed)
    if mustHitSection == false then
        setProperty('defaultCamZoom',0.9)
    else
       
        setProperty('defaultCamZoom',0.5)
    end
end

function onStepHit()
	if curBeat > 0 then
		noteTweenX("NoteMove1", 0, -1000, 0.2, cubeInOut)
		noteTweenX("NoteMove2", 1, -1000, 0.3, cubeInOut)
		noteTweenX("NoteMove3", 2, -1000, 0.4, cubeInOut)
		noteTweenX("NoteMove4", 3, -1000, 0.5, cubeInOut)
	end	
end
