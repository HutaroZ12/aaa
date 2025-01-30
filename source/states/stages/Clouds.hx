package states.stages;

import shaders.SkyShader;
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
    
    override function create()
    {       
        layer0 = new BGSprite('stages/sky/layer0', -500, -300);
        layer0.scrollFactor.set(1, 1);
        add(layer0);
        moveLayer0();

        layer1 = new BGSprite('stages/sky/layer1', -500, -300);
        layer1.scrollFactor.set(1, 1);
        add(layer1);
        moveLayerContinuous(layer1, 20);

        layer2 = new BGSprite('stages/sky/layer2', -500, -300);
        layer2.scrollFactor.set(0.85, 0.85);
        add(layer2);
        moveLayerContinuous(layer2, 15);

        layer3 = new BGSprite('stages/sky/layer3', -500, -300, 1, 1);
        add(layer3);
    }
    
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
            case THREE:
            case TWO:
            case ONE:
            case GO:
                dad.playAnim('hey', true);
                boyfriend.playAnim('hey', true);
            case START:
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

    function moveLayerContinuous(layer:FlxSprite, speed:Float)
    {
        addShader(layer);
        layer.velocity.x = -speed;
        layer.scrollFactor.x = 1;
    }

    function addShader(layer:FlxSprite)
    {
        // Adicione seu código de shader aqui, se necessário
    }
}
