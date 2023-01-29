function onStepHit()
	if curBeat > 320 then
		if curStep % 4 == 0 then
			doTweenY('rrr', 'camHUD', -22, stepCrochet*0.002, 'circOut')
			doTweenY('rtr', 'camGame.scroll', 12, stepCrochet*0.002, 'sineIn')
		end
		if curStep % 4 == 2 then
			doTweenY('rir', 'camHUD', 0, stepCrochet*0.002, 'sineIn')
			doTweenY('ryr', 'camGame.scroll', 0, stepCrochet*0.002, 'sineIn')
		end
	end
	if curBeat > 448 then
		if curStep % 4 == 0 then
				doTweenY('rrr', 'camHUD', 0, stepCrochet*0, 'circOut')
				doTweenY('rtr', 'camGame.scroll', 0, stepCrochet*0, 'sineIn')
		end
		if curStep % 4 == 2 then
				doTweenY('rir', 'camHUD', 0, stepCrochet*0, 'sineIn')
				doTweenY('ryr', 'camGame.scroll', 0, stepCrochet*0, 'sineIn')
		end
	end
end