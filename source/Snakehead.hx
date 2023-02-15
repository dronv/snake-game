package;

import flixel.FlxSprite;
import flixel.FlxG;

class Snakehead extends FlxSprite
{
    public function new(x:Float=0,y:Float=0)
    {
        super(x,y);
        loadGraphic(AssetPaths.snakehead__png,40,40,false);
        setSize(40,40);
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
    }

    public function updatestate(){
        loadGraphic(AssetPaths.soardragon__png,50,50,false);
        setSize(50,50);
        FlxG.sound.play(AssetPaths.levelup__mp3);
    }
}