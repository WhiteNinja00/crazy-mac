function onUpdate()
	if dadName == 'CrazyMac3' then --replace the name for your character name
	  if curStep >= 0 then
  
		songPos = getSongPosition()
  
		local currentBeat = (songPos/1800)*(bpm/80)
  
		doTweenY(dadTweenY, 'dad', -200+50*math.sin((currentBeat*0.40)*math.pi),0.001)
  
	  end
	end
end