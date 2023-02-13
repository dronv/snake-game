package;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.text.FlxText;

class PlayState extends FlxState
{
	var sprite:FlxSprite;
	var snake:FlxSprite;
	var soarddragon:FlxSprite;
	override public function create()
	{
		super.create();
		super.create();
		sprite = new FlxSprite();
		sprite.makeGraphic(640,480,flixel.util.FlxColor.WHITE);
		for(y in 0... 490){
			for(x in 0 ...640){
				if(x%2 == 1 && y%2 == 1)
					sprite.pixels.setPixel(x,y,0x0000ff);
				if(x <5 || y<5 || x>635 || y>475)
					sprite.pixels.setPixel(x,y,0xffffff);
			}
		}
		add(sprite);
		var snake = new FlxSprite().loadGraphic(AssetPaths.snake__png);
		snake.x=FlxG.width/2-snake.width/2;
		snake.y=FlxG.height/2-snake.height/2;
		add(snake);
		var soardragon = new FlxSprite().loadGraphic(AssetPaths.soardragon__png);
		add(soardragon);
		var txtScore = new FlxText(10, 10, 200, "Score: 0", 20);
		var txtTime = new FlxText(10, 30, 200, "Time: 0", 20);
		add(txtScore);
		add(txtTime);
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
