-- Event notes hooks
function onEvent(name, value1, value2)
    local var string = (value1)
    local var length = tonumber(0 + value2)
    if name == "crazymac talking" then

        makeLuaText('yappin', 'Text goes here', 300, 500, 400)
        setTextString('yappin',  '' .. string)
        setTextFont('yappin', 'vcr.ttf')
        setTextColor('yappin', '0xccccc')
        setTextSize('yappin', 30);
        addLuaText('yappin')
        setTextAlignment('yappin', 'center')
        setObjectCamera("yappin", 'hud');
        runTimer('lyricalTho', length, 1)
        --removeLuaText('yappin', true)
        
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'lyricalTho' then
        removeLuaText('yappin', true)
    end
end