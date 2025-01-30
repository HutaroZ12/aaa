package states.stages;

import flixel.FlxG;
import flixel.addons.effects.FlxShader;

import states.stages.objects.*;

class Clouds extends BaseStage
{
    var layer0:FlxSprite;
    var layer1:FlxSprite;
    var layer2:FlxSprite;
    var layer3:FlxSprite;
    var layer4:FlxSprite;
    var layer5:FlxSprite;
    var skyShader:FlxShader;
    //var blackBars:FlxSprite;
    
    override function create()
    {
    super.create();
    skyShader = new FlxShader("assets/shaders/skyShader.frag");
    FlxG.cameras.setDefaultDrawTarget(skyShader);
        
        layer0 = new BGSprite('stages/sky/layer0', -500, -300);
        layer0.scrollFactor.set(1, 1);
        add(layer0);
        moveLayer0();

        layer1 = new BGSprite('stages/sky/layer1', -500, -300);
        layer1.scrollFactor.set(1, 1);
        add(layer1);
        moveLayer(layer1, 20);

        layer2 = new BGSprite('stages/sky/layer2', -500, -300);
        layer2.scrollFactor.set(0.85, 0.85);
        add(layer2);
        moveLayer(layer2, 20);

        layer3 = new BGSprite('stages/sky/layer3', -500, -300, 1, 1);
        add(layer3);

        /*layer4 = new BGSprite('stages/sky/layer4', -500, -300);
        add(layer4);

        /*blackBars = new BGSprite('movieBars', 0, 0);
        blackBars.scrollFactor.set(1, 1);
        blackBars.scale.x = 1;
        blackBars.scale.y = 1;
        blackBars.camera = camHUD;
        add(blackBars);
        */}
    
    override function createPost()
    {
        layer5 = new BGSprite('stages/sky/layer5', -500, -300);
        layer5.scrollFactor.set(1, 1);
        layer5.blend = ADD;
        add(layer5);
    }
    
    override function countdownTick(count:Countdown, num:Int)
        switch(count)
        {
            case THREE: //num 0
            case TWO: //num 1
            case ONE: //num 2
            case GO: //num 3
                dad.playAnim('hey', true);
                boyfriend.playAnim('hey', true);
            case START: //num 4
        }

    function moveLayer0()
    {
        FlxTween.tween(layer0, {x: -1500}, 100, {ease: FlxEase.linear, onComplete: resetLayer0});
    }

    function resetLayer0(tween:FlxTween):Void
    {
        layer0.x = 0;
        moveLayer0();
    }

    function moveLayer(layer:FlxSprite, duration:Float)
    {
        var startX = layer.x;
        var endX = -1500;
        
        FlxTween.tween(layer, {x: endX}, duration, {ease: FlxEase.linear, onComplete: function(tween:FlxTween):Void {
            layer.x = startX;
            moveLayer(layer, duration);
        }});
    }
}
