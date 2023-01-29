function onStepHit()
	if curBeat > 318 then
		noteTweenX("NoteMove1", 0, -1000, 0.2, cubeInOut)
		noteTweenX("NoteMove2", 1, -1000, 0.3, cubeInOut)
		noteTweenX("NoteMove3", 2, -1000, 0.4, cubeInOut)
		noteTweenX("NoteMove4", 3, -1000, 0.5, cubeInOut)
	end	
end