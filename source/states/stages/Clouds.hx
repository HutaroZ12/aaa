package states.stages;

import states.stages.objects.*;

class Clouds extends BaseStage
{
    var layer0:FlxSprite;
    var layer1:FlxSprite;
    var layer1b:FlxSprite; // Segunda instância da camada 1
    var layer2:FlxSprite;
    var layer2b:FlxSprite; // Segunda instância da camada 2
    var layer3:FlxSprite;
    var layer4:FlxSprite;
    var layer5:FlxSprite;

    override function create()
    {       
        layer0 = new BGSprite('stages/sky/layer0', -500, -300);
        layer0.scrollFactor.set(1, 1);
        add(layer0);

        // Camada 1
        layer1 = new BGSprite('stages/sky/layer1', -500, -300);
        layer1.scrollFactor.set(0.85, 0.85);
        add(layer1);

        // Segunda instância da camada 1
        layer1b = new BGSprite('stages/sky/layer1', layer1.x + layer1.width, layer1.y);
        layer1b.scrollFactor.set(0.85, 0.85);
        add(layer1b);

        // Camada 2
        layer2 = new BGSprite('stages/sky/layer2', -500, -300);
        layer2.scrollFactor.set(0.9, 0.9);
        add(layer2);

        // Segunda instância da camada 2
        layer2b = new BGSprite('stages/sky/layer2', layer2.x + layer2.width, layer2.y);
        layer2b.scrollFactor.set(0.9, 0.9);
        add(layer2b);

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
    
    override function update(elapsed:Float)
    {
        super.update(elapsed);
        parallaxUpdate(elapsed);
    }

    function parallaxUpdate(elapsed:Float)
    {
            // Atualizar a posição das camadas
            layer1.x -= 50 * elapsed; // Ajuste a velocidade conforme necessário
            layer1b.x -= 50 * elapsed; // Ajuste a velocidade conforme necessário

            layer2.x -= 8 * elapsed; // Ajuste a velocidade conforme necessário
            layer2b.x -= 8 * elapsed; // Ajuste a velocidade conforme necessário

            // Reposicionar camadas para loop infinito
            if (layer1.x + layer1.width <= 0){
                layer1.x = layer1b.x + layer1b.width;
            }
            if (layer1b.x + layer1b.width <= 0){
                layer1b.x = layer1.x + layer1.width;
            }

            if (layer2.x + layer2.width <= 0){
                layer2.x = layer2b.x + layer2b.width;
            }
            if (layer2b.x + layer2b.width <= 0){
                layer2b.x = layer2.x + layer2.width;
            }
        }
    }

    override function countdownTick(count:Countdown, num:Int)
    {
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
    }
}
