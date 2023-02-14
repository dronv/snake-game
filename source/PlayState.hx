package;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.text.FlxText;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;

class PlayState extends FlxState
{
	var sprite:FlxSprite;
	var soarDragon:FlxSprite;
	var snakeHead:FlxSprite;
	var snakeBody:FlxSpriteGroup;
	var fruit:FlxSprite;
	var headPositions:Array<FlxPoint>;
	var score:Int = 0;
	var txtScore:FlxText;
	override public function create()
	{
		
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
		var snakeHead = new FlxSprite().loadGraphic(AssetPaths.snakehead__png);
		snakeHead.x=FlxG.width/2-snakeHead.width/2;
		snakeHead.y=FlxG.height/2-snakeHead.height/2;
		offsetSprite(snakeHead);
		headPositions = [FlxPoint.get(snakeHead.x, snakeHead.y)];
		snakeBody = new FlxSpriteGroup();
		add(snakeBody);
		add(snakeHead);
		var fruit = new FlxSprite().makeGraphic(6,6,flixel.util.FlxColor.RED);
		//randomizeFruitPosition();
		offsetSprite(fruit);
		add(fruit);
		var txtScore = new FlxText(10, 10, 200, "Score: " + score);
		add(txtScore);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		if(FlxG.keys.pressed.LEFT){
			snakeHead.x --;
		}
		
	}

	function gameover(){
			FlxG.switchState(new EndState());

		// if(snake.overlap(sprite)){
		// 	score = score + 1;
		// 	txtScore.text = "Score: " + score;
			
		// }
		
		// if(gameover()){
		// 	FlxG.state = new GameOverState(score);
		// }
	}

	function offsetSprite(Sprite:FlxSprite):Void
	{
		Sprite.offset.set(1, 1);
		Sprite.centerOffsets();
	}
}

// class GameOverState extends FlxState
// {
// 	var finalScore:Int;
// 	var txtFinalScore:FlxText;

// 	public function new(finalScore:Int)
// 	{
// 		super();
// 		this.finalScore = finalScore;
// 	}

// 	override public function create()
// 	{
// 		super.create();

// 		txtFinalScore = new FlxText(FlxG.width / 2, FlxG.height / 2, 200, "Final Score: " + finalScore);
// 		txtFinalScore.setFormat(null, 32, 0xffffff, "center");
// 		add(txtFinalScore);
// 	}

