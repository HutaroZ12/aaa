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
	}
}

	override function createPost()
	{
		layer5 = new BGSprite('stages/sky/layer5', -500, -300);
        layer5.scrollFactor.set(1, 1);
        add(layer5);
	}
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
