package states.stages;

import states.stages.objects.*;

class Clouds extends BaseStage
{
    var layer0:FlxSprite;
    var layer1:FlxSprite;
    var layer2:FlxSprite;
    var layer1b:FlxSprite; // Segunda instância da camada 1
    var layer2b:FlxSprite; // Segunda instância da camada 2
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

        // Camada 1
        layer1 = new BGSprite('stages/sky/layer1', -500, -300);
        layer1.scrollFactor.set(1, 1);
        add(layer1);
        layer1b = new BGSprite('stages/sky/layer1', layer1.x + layer1.width, -300); // Segunda instância
        layer1b.scrollFactor.set(1, 1);
        add(layer1b);
        moveLayerContinuous(layer1, layer1b, 20);

        // Camada 2
        layer2 = new BGSprite('stages/sky/layer2', -500, -300);
        layer2.scrollFactor.set(0.85, 0.85);
        add(layer2);
        layer2b = new BGSprite('stages/sky/layer2', layer2.x + layer2.width, -300); // Segunda instância
        layer2b.scrollFactor.set(0.85, 0.85);
        add(layer2b);
        moveLayerContinuous(layer2, layer2b, 15);

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

    function moveLayerContinuous(layer:FlxSprite, layerb:FlxSprite, speed:Float)
    {
        // Define a velocidade de movimento das camadas
        layer.velocity.x = -speed;
        layerb.velocity.x = -speed;

        // Atualiza a posição das camadas continuamente
        layer.update = function(elapsed:Float):Void {
            super.update(elapsed);
            if (layer.x + layer.width < 0) {
                layer.x = layerb.x + layerb.width;
            }
        };

        layerb.update = function(elapsed:Float):Void {
            super.update(elapsed);
            if (layerb.x + layerb.width < 0) {
                layerb.x = layer.x + layer.width;
            }
        };
    }
}
