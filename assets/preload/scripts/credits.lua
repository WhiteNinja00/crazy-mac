credittext = {'???', '???', '???', '???'} --first is coder, second is artist, third is musician, last is charter
order = {'coders:', 'artists:', 'composers:', 'charters:'}
font = 'uni-sans.heavy-caps.otf'
tweendur = 0.8
bgsize = 0.7
timebeforestart = 0
fontsize = 57
otherfontsize = 35.5
tweentype = 'QuadOut'

function onCreatePost()
    --makeLuaText('what', songName, 1280, 12.5, 0)
    --addLuaText('what')
    --code to check song name (if credits dont work)

    if songName == 'Infiltrate' then
        credittext = {'Maddix', 'Maddix+Mark', 'Maddix', 'Maddix'}
    elseif songName == 'Authentication' then
        credittext = {'Maddix', 'Maddix+Mark', 'HQC+MTS', 'Maddix'}
    elseif songName == 'formidable' then
        credittext = {'Maddix+HQC', 'Maddix+Mark', 'Maddix', 'Bacon'}
    elseif songName == 'head to head' then
        credittext = {'HQC', 'Maddix', 'Maddix', 'HQC'}
    elseif songName == 'interrelation' then
        credittext = {'Maddix+HQC', 'Paul', 'HQC', 'HQC'}
    elseif songName == 'Parsed' then
        credittext = {'White Ninja', 'Maddix', 'MTS', 'Bleg'}
    elseif songName == 'Epik' then
        credittext = {'Maddix', 'Paul+Maddix+Hqc+MTS', 'HQC', 'Maddix'}
        otherfontsize = 23.5
        timebeforestart = 5.2
    elseif songName == 'Jod' then
        credittext = {'Maddix', 'Gorbini', 'Gorbini', 'Maddix'}
    elseif songName == 'Pasta Night' then
        credittext = {'Maddix', 'Wronge+Hoots+Paul', 'TheInnuendo+Punkett+iKenny', 'Gibz679+Niffirg'}
	otherfontsize = 23.5
    elseif songName == 'bore' then
        credittext = {'Maddix', 'Maddix+MTS', 'HQC', 'Bacon'}
    elseif songName == 'Expurgation' then
        credittext = {'Maddix', 'Maddix+Paul', 'Maddix', 'Bleg'}
    elseif songName == 'Miller' then
        credittext = {'White Ninja', 'Maddix+Paul', 'kiwiquest+GalXE+findjuno+Headdzo\n+Polyfield', 'EataLot0Ffood'}
	otherfontsize = 16.5
    end

    makeLuaSprite('bg', 'creditbg', -5 - 400, 170);
    scaleObject('bg', bgsize, bgsize)
    setObjectCamera('bg', 'hud');
    addLuaSprite('bg', true);

    for i = 0, 4 do
        makeLuaText(i, order[i], 1280, 12.5 - 400, 125 + (i * 68))
        setTextAlignment(i, 'left')
        setTextSize(i, fontsize * bgsize)
        setTextFont(i, font)
        addLuaText(i)
        
        makeLuaText(order[i], credittext[i], 1280, 12.5 - 400, 160 + (i * 68))
        setTextAlignment(order[i], 'left')
        setTextSize(order[i], otherfontsize * bgsize)
        setTextFont(order[i], font)
        addLuaText(order[i])
    end
    runTimer('start', timebeforestart, 1)
    runTimer('back', 2.5 + timebeforestart, 1)
end

function onTimerCompleted(tag)
    if tag == 'start' then
        doTweenX('movebg', 'bg', -5, tweendur, tweentype)
        for i = 0, 4 do
            doTweenX('movebig'..i, i, 12.5, tweendur, tweentype)
            doTweenX('movesmall'..i, order[i], 12.5, tweendur, tweentype)
        end
    end
    if tag == 'back' then
        doTweenX('movebg2', 'bg', -5 - 400, tweendur, tweentype)
        for i = 0, 4 do
            doTweenX('movebig2'..i, i, 12.5 - 400, tweendur, tweentype)
            doTweenX('movesmall2'..i, order[i], 12.5 - 400, tweendur, tweentype)
        end
    end
end

function onTweenCompleted(tag)
    if tag == 'movebg2' then
        removeLuaSprite('bg', true)
    end
    for i = 0, 4 do
        if tag == 'movebig2'..i then
            removeLuaSprite(i, true)
        end
        if tag == 'movesmall2'..i then
            removeLuaSprite(order[i], true)
        end
    end
end
