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
        layer1.scrollFactor.set(1, 1);
        add(layer1);

        // Camada 2
        layer2 = new BGSprite('stages/sky/layer2', -500, -300);
        layer2.scrollFactor.set(0.85, 0.85);
        add(layer2);

        layer3 = new BGSprite('stages/sky/layer3', -500, -300, 1, 1);
        add(layer3);

        // Start parallax movement
        FlxG.update.add(parallaxUpdate);
    }

    override function createPost()
    {
        layer5 = new BGSprite('stages/sky/layer5', -500, -300);
        layer5.scrollFactor.set(1, 1);
        layer5.blend = ADD;
        add(layer5);
    }

    function parallaxUpdate(elapsed:Float)
    {
        layer1.x -= 1; // Adjust speed as needed
        layer2.x -= 0.85; // Adjust speed as needed

        if (layer1.x <= -layer1.width) {
            layer1.x = 0;
        }

        if (layer2.x <= -layer2.width) {
            layer2.x = 0;
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
