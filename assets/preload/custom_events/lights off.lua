function onEvent(name, value1, value2)
	if name == 'lights off' and value1 == 'a' then
		makeLuaSprite('whitebg', '000000', -500, -30)
		makeGraphic('whitebg',5000,5000,'000000')
		addLuaSprite('whitebg', true)
		setProperty('boyfriend.color', '000000')
		setProperty('dad.color', '000000')
		setProperty('gf.color', '000000')
	end
	if name == 'lights off' and value1 == 'b' then
		removeLuaSprite('whitebg')
		setProperty('boyfriend.color', getColorFromHex('FFFFFF'))
		setProperty('dad.color', getColorFromHex('FFFFFF'))
		setProperty('gf.color', getColorFromHex('FFFFFF'))
	end
end