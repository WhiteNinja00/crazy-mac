package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.util.FlxCollision;
import flixel.addons.ui.FlxUIInputText;

using StringTools;

class DiscordJoin extends MusicBeatSubstate {
    var mouseobject:FlxSprite;
    var joinbutton:FlxSprite;
    var codething:FlxUIInputText;
    var playing = false;

    public function new() {
        super();

		mouseobject = new FlxSprite(0, 0).makeGraphic(1, 1, 0x11000000);
		add(mouseobject);

        var back:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0x88000000);
        back.scrollFactor.set();
        add(back);

        var join:FlxSprite = new FlxSprite().loadGraphic(Paths.image('discord/join/joinback'));
		join.scrollFactor.set();
        join.screenCenter();
		add(join);

        joinbutton = new FlxSprite(join.x + 286, join.y + 261).loadGraphic(Paths.image('discord/join/joinn'));
		joinbutton.scrollFactor.set();
		add(joinbutton);

        var backgroundcolla = 0xFFE3E5E8;
		codething = new FlxUIInputText(join.x + 17, join.y + 121, 357, '', 19, 0xFF6D7276, backgroundcolla);
        codething.fieldBorderColor = backgroundcolla;
        codething.font = Paths.font("uni-sans.heavy-caps.otf");
        codething.maxLength = 29;
        add(codething);
	}

    override function update(elapsed:Float) {
        if(!playing) {
            mouseobject.x = FlxG.mouse.x;
            mouseobject.y = FlxG.mouse.y;
            
            var addstuff = 'n';
            if(FlxCollision.pixelPerfectCheck(mouseobject, joinbutton, 1) || controls.ACCEPT) {
                addstuff = 's';
                if (FlxG.mouse.justPressed) {
                    inputcheck();
                }
            }
            if(controls.ACCEPT) {
                inputcheck();
            }
            joinbutton.loadGraphic(Paths.image('discord/join/join' + addstuff));

            if(FlxG.keys.justPressed.ESCAPE) {
                close();
            }
        }

        super.update(elapsed);
    }

    function inputcheck() {
        switch(codething.text.toLowerCase().replace(' ', '')) {
            case 'osoing':
                startsong(['interrelation']);
            case 'epiktoad':
                startsong(['epik']);
            case 'generic':
                startsong(['jod']);
            case 'auspany':
                startsong(['expurgation']);
            case '8111':
                startsong(['bore']);
            case 'ourple':
                startsong(['miller']);
            case 'session':
                startsong(['pasta night']);
        }
    }

	function startsong(songname:Array<String>, storymode:Bool = false, week:Int = 1) {
		if(storymode) {
			PlayState.storyPlaylist = songname;
		}
		PlayState.storyWeek = week;
		PlayState.storyDifficulty = 1;
		PlayState.SONG = Song.loadFromJson(songname[0], songname[0]);
		PlayState.isStoryMode = storymode;
		CoolUtil.difficulties = CoolUtil.defaultDifficulties.copy();
		LoadingState.loadAndSwitchState(new PlayState());
		playing = true;
		FlxG.mouse.visible = false;
	}
}