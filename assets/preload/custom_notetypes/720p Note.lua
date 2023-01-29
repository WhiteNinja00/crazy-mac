function onCreate()
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == '720p Note' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'quality_notes');
			setPropertyFromGroup('unspawnNotes', i, 'hitHealth', '0');
			setPropertyFromGroup('unspawnNotes', i, 'missHealth', '0');
			setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', false);

			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true);
			end
		end
	end

	addCharacterToList('CrazyMacPlayableHighCamera', 'boyfriend')
	addCharacterToList('OutOfHisMind Mac', 'boyfriend')
	addCharacterToList('sillymac', 'boyfriend')
	--debugPrint('Script started!')
end

-- Function called when you hit a note (after note hit calculations)
-- id: The note member id, you can get whatever variable you want from this note, example: "getPropertyFromGroup('notes', id, 'strumTime')"
-- noteData: 0 = Left, 1 = Down, 2 = Up, 3 = Right
-- noteType: The note type string/tag
-- isSustainNote: If it's a hold note, can be either true or false
function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == '720p Note' then
		if getProperty('boyfriend.curCharacter') == 'OutOfHisMind Mac' or 'sillymac' then
		    triggerEvent('Change Character', 'BF', 'CrazyMacPlayableHighCamera')
			characterPlayAnim('boyfriend', 'powerup', true)
		elseif getProperty('boyfriend.curCharacter') == 'CrazyMacPlayableHighCamera' then
			addScore(100)
		end
        playSound('mushroom', 0)
	end
end

-- Called after the note miss calculations
-- Player missed a note by letting it go offscreen
function noteMiss(id, noteData, noteType, isSustainNote)
	if noteType == '720p Note' then
		-- put something here if you want
	end
end