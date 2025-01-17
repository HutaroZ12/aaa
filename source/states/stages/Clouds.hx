package states.stages;

import states.stages.objects.*;

class Clounds extends BaseStage
{
	var layer0:FlxSprite;
	var layer1:FlxSprite;
	var layer2:FlxSprite;
	var layer3:FlxSprite;
	var layer4:FlxSprite;
	var layer5:FlxSprite;
	var blackBars:FlxSprite;
	
	override function create()
	{
	layer0 = new BGSprite('stages/sky/layer0', -500, -300);
        layer0.scrollFactor.set(1, 1);
        add(layer0);

	layer1 = new BGSprite('stages/sky/layer1', -500, -300);
        layer1.scrollFactor.set(1, 1);
        add(layer1);

	layer2 = new BGSprite('stages/sky/layer2', -500, -300);
        layer2.scrollFactor.set(1, 1);
        add(layer2);

	layer3 = new BGSprite('stages/sky/layer3', -500, -300);
        layer3.scrollFactor.set(1, 1);
        add(layer3);

	layer4 = new BGSprite('stages/sky/layer4', -500, -300);
        layer4.scrollFactor.set(1, 1);
        add(layer4);

	layer5 = new BGSprite('stages/sky/layer5', -500, -300);
        layer5.scrollFactor.set(1, 1);
        add(layer5);

	blackBars = new BGSprite('movieBars', 0, 0);
        blackBars.scrollFactor.set(1, 1);
        blackBars.scale.x = 1;
        blackBars.scale.y = 1;
        blackBars.camera = camHUD;
        add(blackBars);
	
	override function createPost()
	{
		layer5 = new BGSprite('stages/sky/layer5', -500, -300);
        layer5.scrollFactor.set(1, 1);
        add(layer5);
	}

	override function update(elapsed:Float)
	{
		// Code here
	}

	override function destroy()
	{
		// Code here
	}

	
	override function countdownTick(count:Countdown, num:Int)
	{
		switch(count)
		{
			case THREE: //num 0
			case TWO: //num 1
			case ONE: //num 2
			case GO: //num 3
				boyfriend.playAnim('hey');
				dad.playAnim('hey');
			case START: //num 4
		}
	}

	override function startSong()
	{
		// Code here
	}

	// Steps, Beats and Sections:
	//    curStep, curDecStep
	//    curBeat, curDecBeat
	//    curSection
	override function stepHit()
	{
		// Code here
	}
	override function beatHit()
	{
		// Code here
	}
	override function sectionHit()
	{
		// Code here
	}

	// Substates for pausing/resuming tweens and timers
	override function closeSubState()
	{
		if(paused)
		{
			//timer.active = true;
			//tween.active = true;
		}
	}

	override function openSubState(SubState:flixel.FlxSubState)
	{
		if(paused)
		{
			//timer.active = false;
			//tween.active = false;
		}
	}

	// For events
	override function eventCalled(eventName:String, value1:String, value2:String, flValue1:Null<Float>, flValue2:Null<Float>, strumTime:Float)
	{
		switch(eventName)
		{
			case "My Event":
		}
	}
	override function eventPushed(event:objects.Note.EventNote)
	{
		// used for preloading assets used on events that doesn't need different assets based on its values
		switch(event.event)
		{
			case "My Event":
				//precacheImage('myImage') //preloads images/myImage.png
				//precacheSound('mySound') //preloads sounds/mySound.ogg
				//precacheMusic('myMusic') //preloads music/myMusic.ogg
		}
	}
	override function eventPushedUnique(event:objects.Note.EventNote)
	{
		// used for preloading assets used on events where its values affect what assets should be preloaded
		switch(event.event)
		{
			case "My Event":
				switch(event.value1)
				{
					// If value 1 is "blah blah", it will preload these assets:
					case 'blah blah':
						//precacheImage('myImageOne') //preloads images/myImageOne.png
						//precacheSound('mySoundOne') //preloads sounds/mySoundOne.ogg
						//precacheMusic('myMusicOne') //preloads music/myMusicOne.ogg

					// If value 1 is "coolswag", it will preload these assets:
					case 'coolswag':
						//precacheImage('myImageTwo') //preloads images/myImageTwo.png
						//precacheSound('mySoundTwo') //preloads sounds/mySoundTwo.ogg
						//precacheMusic('myMusicTwo') //preloads music/myMusicTwo.ogg
					
					// If value 1 is not "blah blah" or "coolswag", it will preload these assets:
					default:
						//precacheImage('myImageThree') //preloads images/myImageThree.png
						//precacheSound('mySoundThree') //preloads sounds/mySoundThree.ogg
						//precacheMusic('myMusicThree') //preloads music/myMusicThree.ogg
				}
		}
	}

	// Note Hit/Miss
	override function goodNoteHit(note:Note)
	{
		// Code here
	}

	override function opponentNoteHit(note:Note)
	{
		// Code here
	}

	override function noteMiss(note:Note)
	{
		// Code here
	}

	override function noteMissPress(direction:Int)
	{
		// Code here
	}
}
