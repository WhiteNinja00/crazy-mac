function onCreatePost() 
    makeLuaText("message", "Notes are randomized!!!", 500, 10, 30)
    setTextAlignment("message", "left")
    addLuaText("message")

    makeLuaText("poop", 500, 30, 30)
    setTextAlignment("engineText", "left")
    addLuaText("engineText")

    if getPropertyFromClass('ClientPrefs', 'downScroll') == false then
        setProperty('message.y', 680)
        setProperty('engineText.y', 660)
    end
end