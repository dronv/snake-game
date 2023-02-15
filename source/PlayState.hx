package;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.text.FlxText;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import flixel.tweens.FlxTween;

class PlayState extends FlxState
{
	var scoreText:FlxText;
	var fruit:FlxSprite;
	var snakeHead:FlxSprite;
	var snakeBody:FlxSpriteGroup;
	var score:Int = 0;

	override public function create()
	{
		super.create();
		FlxG.mouse.visible = false;
		snakeHead = new FlxSprite();
		snakeHead.makeGraphic(10,10,FlxColor.LIME);
		snakeHead.offset.set(1, 1);
		snakeHead.centerOffsets();
		snakeHead.x = Math.floor(FlxG.width / 2);
		snakeHead.y = Math.floor(FlxG.height / 2);
		add(snakeHead);
		
		snakeBody = new FlxSpriteGroup();
		add(snakeBody);

		fruit = new FlxSprite();
		fruit.makeGraphic(10, 10, FlxColor.RED);
		randomizeFruitPosition();
		snakeHead.offset.set(1, 1);
		snakeHead.centerOffsets();
		add(fruit);

		scoreText = new FlxText(0, 4, FlxG.width, "Score: " + 0);
		scoreText.setFormat(null, 16, FlxColor.WHITE, CENTER, OUTLINE);
		add(scoreText);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		if(FlxG.keys.pressed.LEFT){
			snakeHead.x -= 3;
		} else if(FlxG.keys.pressed.RIGHT){
			snakeHead.x += 3;
		} else if(FlxG.keys.pressed.UP){
			snakeHead.y -= 3;
		} else if(FlxG.keys.pressed.DOWN){
			snakeHead.y += 3;
		}

		FlxG.overlap(snakeHead, fruit, snakeEatsFruit);
	}

	function increaseScore(Amount:Int = 10):Void
	{
		score += Amount;
		scoreText.text = "Score: " + score;
		scoreText.alpha = 0;
		FlxTween.tween(scoreText, {alpha: 1}, 0.5);
	}

	function addSegment():Void
	{
		// Spawn the new segment outside of the screen
		// It'll be attached to the snake end in the next moveSnake() call
		var segment:FlxSprite = new FlxSprite(-20, -20);
		segment.makeGraphic(10, 10, FlxColor.GREEN);
		snakeBody.add(segment);
	}

	function snakeEatsFruit(Object1:FlxObject, Object2:FlxObject):Void{

		increaseScore();
		randomizeFruitPosition();

	}
	function randomizeFruitPosition(?Object1:FlxObject, ?Object2:FlxObject):Void
	{
		// Pick a random place to put the fruit down
		fruit.x = FlxG.random.int(0, Math.floor(FlxG.width / 8) - 1) * 8;
		fruit.y = FlxG.random.int(0, Math.floor(FlxG.height / 8) - 1) * 8;

		// Check that the coordinates we picked aren't already covering the snake, if they are then run this function again
		// FlxG.overlap(_fruit, _snakeBody, randomizeFruitPosition);
	}

}