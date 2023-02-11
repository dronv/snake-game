package;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxG;

class PlayState extends FlxState
{
	var sprite:FlxSprite;
	override public function create()
	{
		super.create();
		var background = new FlxSprite().loadGraphic(AssetPaths.background__jpg);
		add(background);
		var snake = new FlxSprite().loadGraphic(AssetPaths.snake__png);
		add(snake);
		var soardragon = new FlxSprite().loadGraphic(AssetPaths.soardragon__png);
		add(soardragon);
		var score = 0;
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		
		if(){
			gameover();
		}
		function gameover(){
			FlxG.state= new FlxState();
		}
	}
}
