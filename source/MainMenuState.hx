package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.app.Application;
import editors.MasterEditorMenu;
import flixel.input.keyboard.FlxKey;
import flixel.util.FlxSave;
import flixel.util.FlxCollision;
import flixel.util.FlxTimer;

using StringTools;

class MainMenuState extends MusicBeatState {
	public static var psychEngineVersion:String = '0.6.3';
	public static var muteKeys:Array<FlxKey> = [FlxKey.ZERO];
	public static var volumeDownKeys:Array<FlxKey> = [FlxKey.NUMPADMINUS, FlxKey.MINUS];
	public static var volumeUpKeys:Array<FlxKey> = [FlxKey.NUMPADPLUS, FlxKey.PLUS];
	public static var initialized:Bool = false;

	var debugKeys:Array<FlxKey>;

	var servers = ['dm', 'hs', 'join'];
	var online = ['maddix', 'hqc', 'mts', 'whiteninja', 'bubby', 'francis'];
	var offline = ['maddix', 'hqc', 'mts', 'whiteninja', 'bubby', 'francis'];

	var dmlist = ['user'];
	var dmsonglist = ['week1', 'infiltrate', 'authentication', 'formidable', 'head to head'];
	var creditthing = ['maddix', 'bleg', 'buby', 'gorbini', 'hqc', 'mts', 'paul', 'wn', 'wrong', 'bacon', 'francis', 'hoot'];

	public static var curdm = 0;
	public static var curserver = 1;

	var mouseobject:FlxSprite;
	var messback:FlxSprite;
	var chatlog:FlxSprite;
	var disbg:FlxSprite;
	var serverlist:FlxTypedGroup<FlxSprite>;
	var coolsonglist:FlxTypedGroup<FlxSprite>;
	var setting:FlxSprite;
	var creditlist:FlxTypedGroup<FlxSprite>;

	var scrolly = 0.0;

	var playing = false;
	var substatething = false;

	var songthingx = 273;

	var thingidklol = false;

	override function create() {
		Paths.clearStoredMemory();
		Paths.clearUnusedMemory();

		#if LUA_ALLOWED
		Paths.pushGlobalMods();
		#end
		WeekData.loadTheFirstEnabledMod();

		FlxG.game.focusLostFramerate = 60;
		FlxG.sound.muteKeys = muteKeys;
		FlxG.sound.volumeDownKeys = volumeDownKeys;
		FlxG.sound.volumeUpKeys = volumeUpKeys;
		FlxG.keys.preventDefaultKeys = [TAB];

		PlayerSettings.init();

		FlxG.save.bind('funkin', 'ninjamuffin99');

		ClientPrefs.loadPrefs();

		Highscore.load();

		if(!initialized)
		{
			if(FlxG.save.data != null && FlxG.save.data.fullscreen)
			{
				FlxG.fullscreen = FlxG.save.data.fullscreen;
			}
			persistentUpdate = true;
			persistentDraw = true;
		}

		if (FlxG.save.data.weekCompleted != null)
		{
			StoryMenuState.weekCompleted = FlxG.save.data.weekCompleted;
		}

		var crazysave:FlxSave = new FlxSave();
		crazysave.bind('crazy', 'whiteninja');
		if(crazysave.data.week1 == null) {
			crazysave.data.week1 = 0;
		}
		if(crazysave.data.week1 == 0) {
			dmsonglist.remove('infiltrate');
			dmsonglist.remove('authentication');
			dmsonglist.remove('formidable');
			dmsonglist.remove('head to head');
			thingidklol = true;
		}
		if(crazysave.data.flash == null) {
			crazysave.data.flash = false;
		}
		
		#if FREEPLAY
		MusicBeatState.switchState(new FreeplayState());
		#elseif CHARTING
		MusicBeatState.switchState(new ChartingState());
		#else
		if(crazysave.data.flash == null && !FlashingState.leftState) {
			FlxTransitionableState.skipNextTransIn = true;
			FlxTransitionableState.skipNextTransOut = true;
			MusicBeatState.switchState(new FlashingState());
		} else {
			#if desktop
			if (!DiscordClient.isInitialized)
			{
				DiscordClient.initialize();
				Application.current.onExit.add (function (exitCode) {
					DiscordClient.shutdown();
				});
			}
			#end
		}
		#end

		if (!initialized && FlxG.sound.music == null) {
			FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);
		}
	
		Conductor.changeBPM(102);
		persistentUpdate = true;

		FlxG.mouse.visible = true;
		FlxG.mouse.useSystemCursor = true;

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end
		debugKeys = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_1'));

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;

		mouseobject = new FlxSprite(0, 0).makeGraphic(1, 1, 0xFFFFFFFF);
		add(mouseobject);

		messback = new FlxSprite(); //if some images are sized incorrectly this guy got yo back
		messback.loadGraphic(Paths.image('discord/messageback'));
		messback.scrollFactor.set(0, 0);
		add(messback);

		chatlog = new FlxSprite(273);
		chatlog.scrollFactor.set(0, 0);
		add(chatlog);

		coolsonglist = new FlxTypedGroup<FlxSprite>();
		add(coolsonglist);

		disbg = new FlxSprite();
		disbg.scrollFactor.set(0, 0);
		add(disbg);

		getchat(curserver);
		scrolly = 652 - chatlog.height;
		chatlog.y = scrolly;

		serverlist = new FlxTypedGroup<FlxSprite>();
		add(serverlist);

		for(i in 0...servers.length) {
			var cooly = 0;
			if(i != 0) {
				cooly = 53 + ((i - 1) * 50);
			}
			var curser:FlxSprite = new FlxSprite(0, cooly + 2.5);
			curser.loadGraphic(Paths.image('discord/servers/' + servers[i]));
			curser.scale.x = 1 / 3;
			curser.scale.y = 1 / 3;
			curser.updateHitbox();
			curser.scrollFactor.set(0, 0);
			curser.ID = i;
			serverlist.add(curser);
		}

		var coolery = 228.0;
   
		for(i in 0...dmsonglist.length) {
			var epicsong:FlxSprite = new FlxSprite(songthingx, coolery);
			epicsong.loadGraphic(Paths.image('discord/songmes/' + dmsonglist[i]));
			epicsong.scrollFactor.set(0, 0);
			epicsong.ID = i;
			coolsonglist.add(epicsong);
			coolery += epicsong.height;
			if(curserver != 0) {
				epicsong.x = FlxG.width + 1;
			}
		}

		creditlist = new FlxTypedGroup<FlxSprite>();
		add(creditlist);

		for(i in 0...creditthing.length) {
			var credit:FlxSprite = new FlxSprite(1077, 75 + (i * 39));
			if(i > 8) {
				credit.y += 34;
			}
			credit.loadGraphic(Paths.image('discord/credits/' + creditthing[i]));
			credit.updateHitbox();
			credit.scrollFactor.set(0, 0);
			credit.ID = i;
			creditlist.add(credit);
		}

		idksomething();

		setting = new FlxSprite(208, 649);
		setting.loadGraphic(Paths.image('discord/setting'));
		setting.scrollFactor.set(0, 0);
		add(setting);

		super.create();
	}

	override function update(elapsed:Float) {
		if(FlxG.sound.music.volume < 0.8) {
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
			if(FreeplayState.vocals != null) FreeplayState.vocals.volume += 0.5 * elapsed;
		}

		if(!playing && !substatething) {
			mouseobject.x = FlxG.mouse.x;
			mouseobject.y = FlxG.mouse.y;
			
			var oldscrolly = scrolly;
	
			if(FlxG.mouse.wheel != 0) {
				scrolly += FlxG.mouse.wheel * 75;
				if(scrolly < 652 - chatlog.height) {
					scrolly = 652 - chatlog.height;
				} else if(scrolly > 20) {
					scrolly = 20;
				}
			}
	
			chatlog.y += scrolly - oldscrolly;
	
			serverlist.forEach(function(spr:FlxSprite) {
				var addstuff = '';
				if(spr.ID == curserver) {
					addstuff = 'c';
				}
				if(FlxCollision.pixelPerfectCheck(mouseobject, spr, 1)) {
					addstuff += 's';
					if (FlxG.mouse.justPressed) {
						getchat(spr.ID);
						if(spr.ID != (servers.length - 1)) {
							if(curserver != spr.ID) {
								scrolly = 652 - chatlog.height;
								chatlog.y = scrolly;
								curserver = spr.ID;
								idksomething();
							}
						}
					}
				}
				spr.loadGraphic(Paths.image('discord/servers/' + servers[spr.ID] + addstuff));
			});

			creditlist.forEach(function(spr:FlxSprite) {
				var addstuff = '';
				if(FlxCollision.pixelPerfectCheck(mouseobject, spr, 1)) {
					addstuff += 's';
					if (FlxG.mouse.justPressed) {
						switch(creditthing[spr.ID]) {
							case 'maddix':
								CoolUtil.browserLoad('https://twitter.com/ActuallyMaddix');
							case 'bleg':
								CoolUtil.browserLoad('https://twitter.com/BlegsBag');
							case 'buby':
								CoolUtil.browserLoad('https://twitter.com/bubydareal');
							case 'gorbini':
								CoolUtil.browserLoad('https://twitter.com/Gorbini3D');
							case 'hqc':
								CoolUtil.browserLoad('https://twitter.com/hqcs_');
							case 'mts':
								CoolUtil.browserLoad('https://www.youtube.com/@MarioTheSpartan');
							case 'paul':
								CoolUtil.browserLoad('https://twitter.com/SuperFaMiO');
							case 'wn':
								CoolUtil.browserLoad('https://whiteninja00.carrd.co/');
							case 'wrong':
								CoolUtil.browserLoad('https://twitter.com/pizzafIavored');
							case 'bacon':
								CoolUtil.browserLoad('https://twitter.com/DroidixBacon');
							case 'francis':
								CoolUtil.browserLoad('https://twitter.com/FrancisACNH');
							case 'hoot':
								CoolUtil.browserLoad('https://twitter.com/HootsTheSodaman');
						}
					}
				}
				spr.loadGraphic(Paths.image('discord/credits/' + creditthing[spr.ID] + addstuff));
			});
	
			var coolery = chatlog.y + 185.0;
			coolsonglist.forEach(function(spr:FlxSprite) {
				spr.y = coolery;
				coolery += spr.height;
				var addstuff = '';
				if(FlxCollision.pixelPerfectCheck(mouseobject, spr, 1)) {
					addstuff = 's';
					if (FlxG.mouse.justPressed) {
						switch(spr.ID) {
							case 0:
								startsong(['infiltrate', 'authentication', 'formidable'], true, 1);
							default:
								startsong([dmsonglist[spr.ID]]);
						}
					}
				}
				spr.loadGraphic(Paths.image('discord/songmes/' + dmsonglist[spr.ID] + addstuff));
			});

			var settingaddstuff = '';
			if(FlxCollision.pixelPerfectCheck(mouseobject, setting, 1)) {
				settingaddstuff = 's';
				if (FlxG.mouse.justPressed) {
					LoadingState.loadAndSwitchState(new options.OptionsState());
				}
			}
			setting.loadGraphic(Paths.image('discord/setting' + settingaddstuff));
			setting.updateHitbox();
	
			if(FlxG.keys.pressed.CONTROL && FlxG.keys.pressed.SLASH) {
				startsong(['parsed']);
			}
	
			#if desktop
			if(FlxG.keys.anyJustPressed(debugKeys)) {
				MusicBeatState.switchState(new MasterEditorMenu());
			}
			#end
		}

		super.update(elapsed);
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

	function getchat(something:Int) {
		var numba = (servers.length - 1);
		switch(something) {
			case 0:
				if(thingidklol) {
					chatlog.loadGraphic(Paths.image('discord/dmchat1'));
				} else {
					chatlog.loadGraphic(Paths.image('discord/dmchat1d'));
				}
				disbg.loadGraphic(Paths.image('discord/dmbase'));
			case 1:
				chatlog.loadGraphic(Paths.image('discord/chat'));
				disbg.loadGraphic(Paths.image('discord/base1'));
			case numba:
				openSubState(new DiscordJoin());
				substatething = true;
		}
		chatlog.updateHitbox();
	}

	function idksomething() {
		coolsonglist.forEach(function(differentspr:FlxSprite) {
			if(curserver == 0) {
				differentspr.x = songthingx;
			} else {
				differentspr.x = FlxG.width + 1;
			}
		});
		creditlist.forEach(function(spr:FlxSprite) {
			if(curserver == 1) {
				spr.x = 1077;
			} else {
				spr.x = FlxG.width + 1;
			}
		});
	}

	override function closeSubState() {
		super.closeSubState();
		substatething = false;
	}
}
