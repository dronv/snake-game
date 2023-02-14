package;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.text.FlxText;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	var sprite:FlxSprite;
	var soarDragon:FlxSprite;
	var snakeHead:FlxSprite;
	var snakeBody:FlxSpriteGroup;
	var headPositions:Array<FlxPoint>;
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
		offestSprite(snakeHead);
		headPositions = [FlxPoint.get(snakeHead.x, snakeHead.y)];
		snakeBody = new FlxSpriteGroup();
		add(snakeBody);
		add(snakeHead);
		var soarDragon = new FlxSprite().loadGraphic(AssetPaths.soardragon__png);
		add(soarDragon);
		var txtScore = new FlxText(10, 10, 200, "Score: " + score);
		var txtTime = new FlxText(10, 30, 200, "Time: 0", 20);
		add(txtScore);
		add(txtTime);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		
		if(snake.overlap(sprite)){
			score = score + 1;
			txtScore.text = "Score: " + score;
			
		}
		
		function gameover(){
			//a function that indicates the game is over, when the time reaches zero. Prolly, will be outside the update. ~AV
		}
		if(gameover()){
			FlxG.state = new GameOverState(score);
		}
	}
	function offestSprite(Sprite:FlxSprite):Void
	{
		Sprite.offset.set(1, 1);
		Sprite.centerOffsets();
	}
}

class GameOverState extends FlxState
{
	var finalScore:Int;
	var txtFinalScore:FlxText;

	public function new(finalScore:Int)
	{
		super();
		this.finalScore = finalScore;
	}

	override public function create()
	{
		super.create();

		txtFinalScore = new FlxText(FlxG.width / 2, FlxG.height / 2, 200, "Final Score: " + finalScore);
		txtFinalScore.setFormat(null, 32, 0xffffff, "center");
		add(txtFinalScore);
	}
}
