package states.stages;

import states.stages.objects.*;

class Clouds extends BaseStage
{
    var layer0:FlxSprite;
    var layer1:FlxSprite;
    var layer2:FlxSprite;
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

        // Camada 2
        layer2 = new BGSprite('stages/sky/layer2', -500, -300);
        layer2.scrollFactor.set(0.9, 0.9);
        add(layer2);

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
        layer1.x -= 100 * elapsed; // Ajuste a velocidade conforme necessário
        layer2.x -= 110 * elapsed; // Ajuste a velocidade conforme necessário

        // Se a camada sair da tela, reposicione-a para o infinito
        if (layer1.x <= -layer1.width){
            layer1.x += layer1.width * 2;
        }
        if (layer2.x <= -layer2.width){
            layer2.x += layer2.width * 2;
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
