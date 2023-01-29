
local ENABLED = true
local winnin = false
local losin = false
local okin = false
local what = false

function onSongStart()
	noteTweenX("NoteMove1", 0, -1000, 0.5, cubeInOut)
	noteTweenX("NoteMove2", 1, -1000, 0.5, cubeInOut)
	noteTweenX("NoteMove3", 2, -1000, 0.5, cubeInOut)
	noteTweenX("NoteMove4", 3, -1000, 0.5, cubeInOut)
end

function doHealthX(x)
	if what == true then
		doTweenX('shove', 'healthBar', x, 0.5, 'circInOut')
		doTweenX('shrink', 'healthBar.scale', 0.93, 0.5, 'circInOut')
		doTweenX('shrinkBg', 'healthBarBG.scale', 0.93, 0.5, 'circInOut')
		doTweenAngle('rotat', 'healthBar', 90, 1, 'circInOut')
		runTimer('ycheck', 0.5)
	elseif what == false then
		doTweenX('pull', 'healthBar', screenWidth / 3.76, 0.5, 'circInOut')
		doTweenX('grow', 'healthBar.scale', 1, 0.5, 'circInOut')
		doTweenX('groBG', 'healthBarBG.scale', 1, 0.5, 'circInOut')
		doTweenAngle('ion', 'healthBar', 0, 1, 'circInOut')
		runTimer('yundcheck', 0.5)
	end
end

function doHealthY()
	if what == true then
		doTweenY('shoeve', 'healthBar', 360, 0.3, 'circInOut')
		doTweenY('shirnk', 'healthBar.scale', 0.93, 0.5, 'circInOut')
		runTimer('iconHold', 0.7)
		setProperty('iconP2.flipX', true)
		ENABLED = true
	elseif what == false then
		doTweenY('pulleve', 'healthBar', screenHeight * 0.897, 1, 'circInOut')
		doTweenY('groing', 'healthBar.scale', 1, 0.5, 'circInOut')
		runTimer('iconHoldIn', 1.2)
		setProperty('iconP1.flipX', false)
		setProperty('iconP2.flipX', false)
		ENABLED = false
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'ycheck' then
		doHealthY()
	end
	if tag == 'yundcheck' then
		doHealthY()
	end
	if tag == 'iconHold' then
		doTweenAlpha('icon', 'iconP1', 1, 0.5, 'linear')
		doTweenAlpha('icoPU', 'iconP2', 1, 0.5, 'linear')
	end
	if tag == 'iconHoldIn' then
		doTweenAlpha('iconI', 'iconP1', 1, 0.5, 'linear')
		doTweenAlpha('icoPe', 'iconP2', 1, 0.5, 'linear')
	end
end

function onCreatePost()
	if ENABLED == true then
		makeLuaText('arro', ">>", 100, 100, 100)
		setProperty('arro.angle', 90)
    	setObjectCamera("arro", 'other');
    	setTextColor('arro', '0xffffff')
    	setTextSize('arro', 20);
    	addLuaText("arro");
    	setTextFont('arro', "vcr.ttf")
    	setTextAlignment('arro', 'left')
		setProperty('arro.visible', false)
		setProperty('iconP2.flipX', true)
		setProperty('healthBar.angle', 90)
		setProperty('healthBar.x', 925)
		setProperty('healthBar.y', 360)
		setProperty('healthBar.scale.x', 0.93)
		setProperty('healthBar.scale.y', 0.93)
		setProperty('healthBarBG.scale.x', 0.93)
		setProperty('healthBarBG.scale.y', 0.93)
	end
end

function onUpdatePost()
	if ENABLED == true then
		if getProperty('healthBar.percent') >= 95 then
			if winnin == false then
				winnin = true
				doTweenY('win', 'healthBar', 360 + 30, 0.2 + (crochet/5000), 'circOut')
			end
		else
			winnin = false
		end

		if getProperty('healthBar.percent') <= 5 then
			if losin == false then
				losin = true
				doTweenY('oops', 'healthBar', 360 - 30, 0.2 + (crochet/5000), 'circOut')
			end
		else
			losin = false
		end

		if getProperty('healthBar.percent') < 95 and getProperty('healthBar.percent') > 5 then
			if okin == false and getProperty('healthBar.y') ~= 360 then
				okin = true
				doTweenY('reg', 'healthBar', 360, 0.2 + (crochet/5000), 'circOut')
			end
		else
			okin = false
		end

		P1Mult = getProperty('healthBar.y') - ((getProperty('healthBar.width') * getProperty('healthBar.percent') * getProperty('healthBar.scale.y') * 0.01) + (150 * getProperty ('iconP1.scale.x') - 150)) + 270
		P2Mult = getProperty('healthBar.y') - ((getProperty('healthBar.width') * getProperty('healthBar.percent') * getProperty('healthBar.scale.y') * 0.01) - (150 * getProperty ('iconP2.scale.x')))
		setProperty('iconP1.x', getProperty('healthBar.x') + 220)
		setProperty('iconP1.origin.y', -100)
		setProperty('iconP1.y', P1Mult)
		setProperty('iconP2.x', getProperty('healthBar.x') + 220)
		setProperty('iconP2.origin.y', 200)
		setProperty('iconP2.y', P2Mult)
	end
end
