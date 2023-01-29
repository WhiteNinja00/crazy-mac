size = 0.8
thing = 0
what = 0
imagenumber = 5

local a = onBeatHit
function onBeatHit()
  if curBeat > 27 and curBeat < 106 then
    for i = 0,imagenumber do
      if curBeat == math.ceil((77 / (imagenumber + 1)) * i) + 28 then
        doTweenAlpha('image'..i..'tween2', 'image'..i, 1, 0.0001, 'linear')
        doTweenAlpha('image'..i..'tween3', 'image'..i, 0, (77 / (imagenumber + 1)) / 3, 'linear')
      end
    end
  elseif curBeat == 117 then
    doTweenAlpha('blacktween', 'black', 0, 1, 'linear')
  elseif curBeat == 444 then
    setProperty('mts.alpha', 0)
    setProperty('tod.alpha', 0)
  elseif curBeat == 616 then
    setProperty('hqc.alpha', 0)
  elseif curBeat == 944 then
    setProperty('boyfriend.visible', false);
  elseif curBeat == 1008 then
    setProperty('mts.alpha', 1)
    setProperty('tod.alpha', 1)
    setProperty('hqc.alpha', 1)
    setProperty('boyfriend.visible', true);
  elseif curBeat == 1088 then
    doTweenAlpha('blacktween2', 'black', 1, 0.5, 'linear')
    doTweenAlpha('image6tween', 'image6', 1, 0.5, 'linear')
  end
  if a then
    a()
  end
  forEachChar(function(char)
    if curBeat % getProperty(char.tag..'.danceEveryNumBeats') == 0 and not stringStartsWith(getProperty(char.tag..'.animation.curAnim.name'), 'sing') and not getProperty(char.tag..'.stunned') then
      local formattedTag = '"'..char.tag:gsub('"', '\\"')..'"'
      runHaxeCode([[
        getVar(]]..formattedTag..[[).dance();
      ]])
    end
  end)
end
local a = onCountdownTick
local loopsLeft = 4
function onCountdownTick(tick)
  if a then
    a(tick)
  end
  forEachChar(function(char)
    if loopsLeft % getProperty(char.tag..'.danceEveryNumBeats') == 0 and not stringStartsWith(getProperty(char.tag..'.animation.curAnim.name'), 'sing') and not getProperty(char.tag..'.stunned') then
      local formattedTag = '"'..char.tag:gsub('"', '\\"')..'"'
      runHaxeCode([[
        getVar(]]..formattedTag..[[).dance();
      ]])
    end
  end)
  loopsLeft = loopsLeft - 1
end
local a = opponentNoteHit
function opponentNoteHit(id, data, type, sus)
   health = getProperty('health')
   if getProperty('health') > 0.1 then
      setProperty('health', health- 0.02);
  end
  if a then
    a()
  end
  local noteProp = function(what)
    return getPropertyFromGroup('notes', id, what)
  end
  forEachChar(function(char)
    if char.noteType and not char.isPlayer and type == char.noteType and not gfSection then
      
      local altSuffix = noteProp 'animSuffix'
      if altAnim and not gfSection then
        altSuffix = '-alt'
      end
      playAnim(char.tag, singAnimations[data+1] .. altSuffix, true)
      setProperty(char.tag..'.holdTimer', 0)
    end
  end)
end
local a = goodNoteHit
function goodNoteHit(id, data, type, sus)
  if a then
    a()
  end
  local noteProp = function(what)
    return getPropertyFromGroup('notes', id, what)
  end
  forEachChar(function(char)
    if char.noteType and char.isPlayer and type == char.noteType and not gfSection then
      playAnim(char.tag, singAnimations[data+1] .. noteProp 'animSuffix', true)
      setProperty(char.tag..'.holdTimer', 0)
    end
  end)
end
local a = noteMiss
function noteMiss(id, data, type, sus)
  if a then
    a()
  end
  local noteProp = function(what)
    return getPropertyFromGroup('notes', id, what)
  end
  forEachChar(function(char)
    if char.noteType and char.isPlayer and type == char.noteType and not gfSection and getProperty(char.tag..'.hasMissAnimations') then
      playAnim(char.tag, singAnimations[data+1] .. 'miss' .. noteProp 'animSuffix', true)
    end
  end)
end
local a = onCreate
function onCreate()
  if a then
    a()
  end
  local a = playAnim
  function playAnim(...)
    local stuff = {...}
    local obj = stuff[1]
    if not getCharData(obj) then
      return a(...)
    else
      for i,thing in pairs(stuff) do
        if type(thing) == 'string' then 
          stuff[i] = '"'..thing:gsub('"', '\\"')..'"' 
        else 
          stuff[i] = tostring(thing) 
        end
      end
      table.remove(stuff, 1)
      local theSHIT = table.concat(stuff, ', ')
      runHaxeCode([[
        var char = getVar("]]..obj:gsub('"', '\\"')..[[");
        if(char != null)
          char.playAnim(]]..theSHIT..[[);
      ]])
    end
  end
end
local a = onCreatePost
function onCreatePost()
  if a then
    a()
  end
  debug = true
  makeLuaSprite('hoot', 'circles/hoot', 700, 650)
  scaleObject('hoot', 0.6 * size, 0.6 * size)
  addLuaSprite('hoot', false)
  makeLuaSprite('bleg', 'circles/bleg', 500, 725)
  scaleObject('bleg', 0.8 * size, 0.8 * size)
  addLuaSprite('bleg', false)
  makeLuaSprite('gorbini', 'circles/gorbini', 500, 900)
  scaleObject('gorbini', 0.85 * size, 0.85 * size)
  addLuaSprite('gorbini', true)
  makeLuaSprite('wn', 'circles/whiteninja', 700, 1000)
  scaleObject('wn', 0.6 * size, 0.6 * size)
  addLuaSprite('wn', true)

  makeChar('paul', 'paul-miller', 1850, 600, 'paul', true)
  addChar('paul', true)
  makeChar('mts', 'mts-miller', 1475, 300, 'mts', true)
  addChar('mts', true)
  makeChar('tod', 'tod-miller', 1750, 600, 'tod', true)
  addChar('tod', true)
  makeChar('hqc', 'hqc-miller', 1950, 775, 'hqc', true)
  addChar('hqc', true)
  makeLuaSprite('black', 'miller/black', -200, -200)
  setLuaSpriteScrollFactor('black', 0, 0)
  scaleObject('black', 1.5, 1.5)
  addLuaSprite('black', true)
  cool = imagenumber + 1
  for i = 0,cool do
    makeLuaSprite('image'..i, 'miller/image'..i, -159, -88)
    setLuaSpriteScrollFactor('image'..i, 0, 0)
    addLuaSprite('image'..i, true)
    scaleObject('image'..i, 0.835, 0.835)
    doTweenAlpha('image'..i..'tween', 'image'..i, 0, 0.0001, 'linear')
  end
end
chars = {}
singAnimations = {'singLEFT', 'singDOWN', 'singUP', 'singRIGHT'}

--char: the characters json name
--x: x
--y: y
--noteType: the noteType needed for the character to play an animation
--isPlayer: isPlayer
function makeChar(tag, char, x, y, noteType, isPlayer)
  x,y,isPlayer = x or 0, y or 0, isPlayer == true
  if not madeCharYet then
    madeCharYet = true
    addHaxeLibrary('Character')
    addHaxeLibrary('Boyfriend')
    runHaxeCode([[
      function startsWith(die, ok)
        return game.luaArray[0].call('stringStartsWith', [die, ok]);
      /*function debugPrint(?txt1, ?txt2, ?txt3, ?txt4, ?txt5)
      {
        var cool = [for(thing in [txt1, txt2, txt3, txt4, txt5]) if(thing != null) thing];
        if(cool.length > 0)
          game.addTextToDebug(cool.join(', '), 0xFFFFFFFF);
      }*/
    ]])
  end
  local formattedChar, formattedTag = '"'..char:gsub('"', '\\"')..'"', '"'..tag:gsub('"', '\\"')..'"'
  runHaxeCode([[
    var char = new Character(]]..table.concat({x, y, formattedChar}, ', ')..[[);
    if(]]..tostring(isPlayer == true)..[[)
      char.flipX = !char.flipX;
    setVar(]]..formattedTag..[[, char);
    char.dance();
  ]])
  for i = 0, getProperty 'unspawnNotes.length' -1 do
    if getPropertyFromGroup('unspawnNotes', i, 'noteType') == noteType and getPropertyFromGroup('unspawnNotes', i, 'mustPress') == isPlayer then
      
      setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true)
      setPropertyFromGroup('unspawnNotes', i, 'noMissAnimation', true)
    end
  end
  for i = 0, getProperty 'notes.length' -1 do
    if getPropertyFromGroup('notes', i, 'noteType') == noteType and getPropertyFromGroup('notes', i, 'mustPress') == isPlayer then
      setPropertyFromGroup('notes', i, 'noAnimation', true)
      setPropertyFromGroup('notes', i, 'noMissAnimation', true)
    end
  end
  table.insert(chars, {tag = tag, noteType = noteType, isPlayer = isPlayer or false})
end
function addChar(tag, onTop)
  if getCharData(tag) and not getCharData(tag).wasAdded then
    local formattedTag = '"'..tag:gsub('"', '\\"')..'"'
    runHaxeCode([[
      var tag:String = ]]..formattedTag..[[;
      var onTop:Bool = ]]..tostring(onTop == true)..[[;
      if(getVar(tag) != null)
      {
        if(onTop)
          game.add(getVar(tag));
        else
        {
          var position:Int = game.members.indexOf(game.gfGroup);
    			if(game.members.indexOf(game.boyfriendGroup) < position) {
    				position = game.members.indexOf(game.boyfriendGroup);
    			} else if(game.members.indexOf(game.dadGroup) < position) {
    				position = game.members.indexOf(game.dadGroup);
    			}
    			game.insert(position, getVar(tag));
        }
      }
    ]])
    getCharData(tag).wasAdded = true
  end
end
function removeChar(tag, destroy)
  forEachChar(function(char, i)
    if char.tag == tag then
      if destroy then
        runHaxeCode([[
          var char:Character = getVar("]]..char.tag:gsub('"', '\\"')..[[");
          char.kill();
          char.destroy();
        ]])
        table.remove(chars, i)
      else
        runHaxeCode([[
          var char:Character = getVar("]]..char.tag:gsub('"', '\\"')..[[");
          game.remove(char);
        ]])
        char.wasAdded = false
      end
      for i = 0, getProperty 'unspawnNotes.length' -1 do
        if getPropertyFromGroup('unspawnNotes', i, 'noteType') == char.noteType and getPropertyFromGroup('unspawnNotes', i, 'mustPress') == char.isPlayer then
          setPropertyFromGroup('unspawnNotes', i, 'noAnimation', false)
          setPropertyFromGroup('unspawnNotes', i, 'noMissAnimation', false)
        end
      end
      for i = 0, getProperty 'notes.length' -1 do
        if getPropertyFromGroup('notes', i, 'noteType') == char.noteType and getPropertyFromGroup('notes', i, 'mustPress') == char.isPlayer then
          setPropertyFromGroup('notes', i, 'noAnimation', false)
          setPropertyFromGroup('unspawnNotes', i, 'noMissAnimation', false)
        end
      end
    end
  end)  
end
--repeats a function for each char
function forEachChar(what)
  for k,v in pairs(chars) do
    what(v, k)
  end
end
function getCharData(tag)
  local idiot;
  forEachChar(function(char, id)
    if tag == char.tag then
      idiot = char
    end
  end)
  return idiot
end

function onUpdate()
  thing = thing + 0.05
  doTweenY('wntween', 'wn', 1000+50*math.sin(thing),0.0001)
  what = thing + 0.25
  doTweenY('gorbinitween', 'gorbini', 900+50*math.sin(what),0.0001)
  what = thing + 0.5
  doTweenY('hoottween', 'hoot', 650+50*math.sin(what),0.0001)
  what = thing + 0.75
  doTweenY('blegtween', 'bleg', 725+50*math.sin(what),0.0001)
end
