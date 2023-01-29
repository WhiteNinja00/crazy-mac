--credit to anong us
function onEvent(name)
   if name == 'MissingnoNotes' then
     local keepScroll = false
     ---Note X
     local lx = getRandomInt(0, 296.25);
     local dx = getRandomInt(346.25, 592.5);
     local ux = getRandomInt(642.5, 888.75);
     local rx = getRandomInt(938.75, 1185);
     ---Note Y
     local ly = getRandomInt(100, 630);
     ---Note Angle
     local la = getRandomInt(0, 360);
     local da = getRandomInt(0, 360);
     local ua = getRandomInt(0, 360);
     local ra = getRandomInt(0, 360);
     ---Note moving to X
     noteTweenX('NoteMove1', 4, lx, 0.0001, cubeInOut);
     noteTweenX('NoteMove2', 5, dx, 0.0001, cubeInOut);
     noteTweenX('NoteMove3', 6, ux, 0.0001, cubeInOut);
     noteTweenX('NoteMove4', 7, rx, 0.0001, cubeInOut);
     ---Note moving to Y
     noteTweenY('NoteMove5', 4, ly, 0.0001, cubeInOut);
     if ly == 315 then
       local dy = getRandomInt(0, 3);
       local uy = getRandomInt(0, 3);
       local ry = getRandomInt(0, 3);

       noteTweenY('NoteMove6', 5, (getProperty(defaultPlayerStrumY0) - dy), 0.0001, cubeInOut);
       noteTweenY('NoteMove7', 6, (getProperty(defaultPlayerStrumY1) + uy), 0.0001, cubeInOut);
       noteTweenY('NoteMove8', 7, (getProperty(defaultPlayerStrumY2) - ry), 0.0001, cubeInOut);
     elseif ly > 315 then
       local dyr = getRandomInt(316, 630);
       local uyr = getRandomInt(316, 630);
       local ryr = getRandomInt(316, 630);

       noteTweenY('NoteMove9', 5, dyr, 0.0001, cubeInOut);
       noteTweenY('NoteMove10', 6, uyr, 0.0001, cubeInOut);
       noteTweenY('NoteMove11', 7, ryr, 0.0001, cubeInOut);
       for i = 0,7 do
         setPropertyFromGroup('playerStrums', i, 'downScroll', true);
       end
     elseif ly < 315 then
       local dyl = getRandomInt(100, 200);
       local uyl = getRandomInt(100, 200);
       local ryl = getRandomInt(100, 200);

       noteTweenY('NoteMove12', 5, dyl, 0.0001, cubeInOut);
       noteTweenY('NoteMove13', 6, uyl, 0.0001, cubeInOut);
       noteTweenY('NoteMove14', 7, ryl, 0.0001, cubeInOut);
       for i = 0,7 do
         setPropertyFromGroup('playerStrums', i, 'downScroll', false);
       end
     end
   end
end