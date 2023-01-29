function noteMiss(id, noteData, noteType, isSustainNote)
        if getProperty('boyfriend.curCharacter') == 'CrazyMacPlayableHighCamera' then
            triggerEvent('Change Character', 'BF', 'sillymac')
            playSound('oof', 0)
        elseif getProperty('boyfriend.curCharacter') == 'sillymac' then
            triggerEvent('Change Character', 'BF', 'OutOfHisMind Mac')
            playSound('oof', 0)
        elseif getProperty('boyfriend.curCharacter') == 'OutOfHisMind Mac' then
            setProperty('health', -500)
	end
end