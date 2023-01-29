number = 0
sinnum = 0
dir = 90
dis = 0.25 --change the distance the note moves from left to right
speed = 1 --change the note moving speed

function onCreate()
	dir = dir - (20 * dis)
end

function onUpdate()
	number = number + (speed * 0.05)
	sinnum = math.sin(number) * dis
	dir = dir + sinnum
	for i = 0,7 do
		setPropertyFromGroup("strumLineNotes", i, "direction", dir)
	end
end