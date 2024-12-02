package states;

import flixel.FlxObject;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.addons.display.FlxBackdrop;
import lime.app.Application;
import states.editors.MasterEditorMenu;
import options.OptionsState;

class MainMenuState extends MusicBeatState
{
	public static var psychEngineVersion:String = '0.7.3'; // This is also used for Discord RPC
	public static var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;

	var optionShit:Array<String> = [
		'story_mode', // 0
		'freeplay', // 1
		//#if MODS_ALLOWED 'mods', #end
		//#if ACHIEVEMENTS_ALLOWED 'awards', #end
		'credits', // 2
                //#if !switch 'donate', #end
		'options' // 3
	];

	var magenta:FlxSprite;
	var rairum:FlxSprite;
	var side:FlxSprite;
	var camFollow:FlxObject;

	var ColorArray:Array<Int> = [
		0xFF9400D3,
		0xFF4B0082,
		0xFF0000FF,
		0xFF00FF00,
		0xFFFFFF00,
		0xFFFF7F00,
		0xFFFF0000
	                                
	    ];
	public static var currentColor:Int = 1;    
	public static var currentColorAgain:Int = 0;
			
	var bgMove:FlxBackdrop;

	override function create()
	{
		#if MODS_ALLOWED
		Mods.pushGlobalMods();
		#end
		Mods.loadTopMod();

		#if DISCORD_ALLOWED
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

	//	transIn = FlxTransitionableState.defaultTransIn;
		//transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;

		var yScroll:Float = Math.max(0.25 - (0.05 * (optionShit.length - 4)), 0.1);
		var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('menuBG'));
		bg.antialiasing = ClientPrefs.data.antialiasing;
		bg.scrollFactor.set(0, yScroll);
		bg.setGraphicSize(Std.int(bg.width * 1.175));
		bg.updateHitbox();
		bg.screenCenter();
		add(bg);

		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);

		magenta = new FlxSprite(-80).loadGraphic(Paths.image('menuDesat'));
		magenta.antialiasing = ClientPrefs.data.antialiasing;
		magenta.scrollFactor.set(0, yScroll);
		magenta.setGraphicSize(Std.int(magenta.width * 1.175));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		magenta.color = 0xFFfd719b;
		add(magenta);

		bgMove = new FlxBackdrop(Paths.image('backdrop'), XY, 0, 0);
		bgMove.alpha = 0.1;
		bgMove.color = ColorArray[currentColor];		
		bgMove.velocity.set(FlxG.random.bool(50) ? 90 : -90, FlxG.random.bool(50) ? 90 : -90);
		bgMove.antialiasing = ClientPrefs.data.antialiasing;
		add(bgMove);
                bgMove.screenCenter(XY);
		bg.scrollFactor.set(0, 0);

		rairum = new FlxSprite();
		rairum.frames = Paths.getSparrowAtlas('mainmenu/Menu_rairum');
		rairum.x = -1200;
		rairum.antialiasing = ClientPrefs.data.antialiasing;
		rairum.animation.addByPrefix('vem',"Rairum vem",12);	
		rairum.animation.addByPrefix('idle',"Rairum idle",12);
		rairum.animation.addByPrefix('hey',"Rairum Hey",12);			
		rairum.animation.play('vem');
		add(rairum);

		FlxTween.tween(rairum, {x:0}, 2.4 + 0.1 * Math.abs(curSelected - i ), {ease: FlxEase.backInOut});
		rairum.animation.play('vem');
			
		side = new FlxSprite(0).loadGraphic(Paths.image('MainSide'));
		side.scrollFactor.set(0, 0);
		side.x += 1200;
		side.updateHitbox()side.updateHitbox();
		side.antialiasing = ClientPrefs.data.antialiasing;
		add(side);

		FlxTween.tween(side, {x:-4}, 2.4, {ease: FlxEase.expoInOut});

		
		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		for (i in 0...optionShit.length)
		{
			var offset:Float = 108 - (Math.max(optionShit.length, 4) - 4) * 80;
			var menuItem:FlxSprite = new FlxSprite(0, (i * 140) + offset);
			menuItem.antialiasing = ClientPrefs.data.antialiasing;
			menuItem.x += 1200;
			menuItem.scale.x = 0.7;
	                menuItem.scale.y = 0.7;
			menuItem.frames = Paths.getSparrowAtlas('mainmenu/menu_' + optionShit[i]);
			menuItem.animation.addByPrefix('idle', optionShit[i] + " idle", 10);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " selected", 12);
			menuItem.animation.play('idle');
			menuItems.add(menuItem);
			var scr:Float = (optionShit.length - 4) * 0.135;
			if (optionShit.length < 6)
				scr = 0;
			//menuItem.scrollFactor.set(0, scr);
			menuItem.updateHitbox();
			//menuItem.screenCenter(X);

			switch (i)
			{
			    case 0:
				FlxTween.tween(menuItem, {x:380}, 2.4, {ease: FlxEase.expoInOut});
				menuItem.y = 2;

			    case 1:
				FlxTween.tween(menuItem, {x:348}, 2.4, {ease: FlxEase.expoInOut});
				menuItem.y = 15;

			    case 2:
				FlxTween.tween(menuItem, {x:338}, 2.4, {ease: FlxEase.expoInOut});
				menuItem.y = 35;

			    case 3:
				FlxTween.tween(menuItem, {x:324}, 2.4, {ease: FlxEase.expoInOut});
				menuItem.y = 200;
			}	
			
		}

		var psychVer:FlxText = new FlxText(12, FlxG.height - 44, 0, "Psych Engine v" + psychEngineVersion, 12);
		psychVer.scrollFactor.set();
		psychVer.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(psychVer);
		var fnfVer:FlxText = new FlxText(12, FlxG.height - 24, 0, "Friday Night Funkin' v" + Application.current.meta.get('version'), 12);
		fnfVer.scrollFactor.set();
		fnfVer.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(fnfVer);
		changeItem();

		#if ACHIEVEMENTS_ALLOWED
		// Unlocks "Freaky on a Friday Night" achievement if it's a Friday and between 18:00 PM and 23:59 PM
		var leDate = Date.now();
		if (leDate.getDay() == 5 && leDate.getHours() >= 18)
			Achievements.unlock('friday_night_play');

		#if MODS_ALLOWED
		Achievements.reloadList();
		#end
		#end

		addTouchPad('UP_DOWN', 'A_B_E');

		super.create();

		//FlxG.camera.follow(camFollow, null, 9);
	}

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * elapsed;
			if (FreeplayState.vocals != null)
				FreeplayState.vocals.volume += 0.5 * elapsed;
		}

		if (!selectedSomethin)
		{
			if (controls.UI_UP_P)
				changeItem(-1);

			if (controls.UI_DOWN_P)
				changeItem(1);

			if (controls.BACK)
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new TitleState());
			}

			if (controls.ACCEPT)
			{
				FlxG.sound.play(Paths.sound('confirmMenu'));
				if (optionShit[curSelected] == 'donate')
				{
					CoolUtil.browserLoad('https://ninja-muffin24.itch.io/funkin');
				}
				else
				{
					selectedSomethin = true;

                                        FlxG.camera.flash(FlxColor.WHITE, 1);
					//if (ClientPrefs.data.flashing)    
						//FlxFlicker.flicker(magenta, 1.1, 0.15, false);

					
					FlxTween.tween(menuItems.members[curSelected], {x: -4000}, 2.4, {ease: FlxEase.expoInOut, onComplete: function(twn:FlxTween)
																	 
						switch (optionShit[curSelected])
						{
							case 'story_mode':
								MusicBeatState.switchState(new StoryMenuState());
							case 'freeplay':
								MusicBeatState.switchState(new FreeplayState());

							//#if MODS_ALLOWED
							//case 'mods':
							//	MusicBeatState.switchState(new ModsMenuState());
							//#end

							//#if ACHIEVEMENTS_ALLOWED
							//case 'awards':
							//	MusicBeatState.switchState(new AchievementsMenuState());
							//#end

							case 'credits':
								MusicBeatState.switchState(new CreditsState());
							case 'options':
								MusicBeatState.switchState(new OptionsState());
								OptionsState.onPlayState = false;
								if (PlayState.SONG != null)
								{
									PlayState.SONG.arrowSkin = null;
									PlayState.SONG.splashSkin = null;
									PlayState.stageUI = 'normal';
								}
						}
					});

					currentColor++;            
                                        if (currentColor > 6) currentColor = 1;
                                        currentColorAgain = currentColor - 1;
                                        if (currentColorAgain <= 0) currentColorAgain = 6;

					selectedSomethin = true;

					rairum.animation.play('hey');
						
					for (i in 0...menuItems.members.length)
					{
						if (i == curSelected)
							continue;
						FlxTween.tween(rairum, {x:-4000}, 2.4, {
							ease: FlxEase.expoInOut});
						
						FlxTween.tween(side, {x:-4000}, 2.4, {
							ease: FlxEase.expoInOut});
							
						FlxTween.tween(menuItems.members[i], {x: -4000}, 2.4, {
							ease: FlxEase.expoInOut,
						        onComplete: function(twn:FlxTween)
							{
								menuItems.members[i].kill();
							}
						});
					}
				}
			}
			else if (controls.justPressed('debug_1') || touchPad.buttonE.justPressed)
			{
				selectedSomethin = true;
				MusicBeatState.switchState(new MasterEditorMenu());
			}
		}

		super.update(elapsed);
	}

	function changeItem(change:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'));
		menuItems.members[curSelected].animation.play('idle');
		menuItems.members[curSelected].updateHitbox();
		//menuItems.members[curSelected].screenCenter(X);
		
		curSelected = FlxMath.wrap(curSelected + change, 0, menuItems.length - 1);

		menuItems.members[curSelected].animation.play('selected');
		//menuItems.members[curSelected].centerOffsets();
		//menuItems.members[curSelected].screenCenter(X);

		camFollow.setPosition(menuItems.members[curSelected].getGraphicMidpoint().x,
			menuItems.members[curSelected].getGraphicMidpoint().y - (menuItems.length > 4 ? menuItems.length * 8 : 0));
	}
}
