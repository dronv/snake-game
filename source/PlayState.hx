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
import flixel.util.FlxSpriteUtil;
import flixel.util.FlxDirection;
import flixel.util.FlxTimer;

class PlayState extends FlxState
{
	var sprite:FlxSprite;
	var scoreText:FlxText;
	var fruit:FlxSprite;
	var snakeHead:FlxSprite;
	var headPoints:Array<FlxPoint>;
	var snakeBody:FlxSpriteGroup;
	var score:Int = 0;
	var currentDir = FlxDirection.LEFT;
	var nextDir = FlxDirection.LEFT;
	var _movementInterval:Float = 8;
	var MIN_INTERVAL : Float = 2;
	var timer : FlxTimer;

	override public function create()
	{
		super.create();
		sprite = new FlxSprite();
		sprite.makeGraphic(640,480,flixel.util.FlxColor.WHITE);
		for(y in 0 ... 480){
			for(x in 0 ...640){
				if(x%2 == 1 && y%2 == 1)
					sprite.pixels.setPixel(x,y,0x0000ff);
				if(x<5 || y<5 ||x>635 || y>475)
					sprite.pixels.setPixel(x,y,0xffffff);
			}
		}
		add(sprite);
		FlxG.mouse.visible = false;
		snakeHead = new FlxSprite();
        snakeHead.loadGraphic(AssetPaths.snakehead__png);
		snakeHead.offset.set(1, 1);
		snakeHead.centerOffsets();
		snakeHead.x = Math.floor(FlxG.width / 2);
		snakeHead.y = Math.floor(FlxG.height / 2);
		add(snakeHead);
		
		snakeBody = new FlxSpriteGroup();
		add(snakeBody);

		fruit = new FlxSprite();
        fruit.loadGraphic(AssetPaths.apple__png);
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
		// if (FlxG.keys.anyPressed([UP, W]) && currentDir != DOWN)
		// {
		// 	nextDir = UP;
		// }
		// else if (FlxG.keys.anyPressed([DOWN, S]) && currentDir != UP)
		// {
		// 	nextDir = DOWN;
		// }
		// else if (FlxG.keys.anyPressed([LEFT, A]) && currentDir != RIGHT)
		// {
		// 	nextDir = LEFT;
		// }
		// else if (FlxG.keys.anyPressed([RIGHT, D]) && currentDir != LEFT)
		// {
		// 	nextDir = RIGHT;
		// }
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
		addSegment();
		randomizeFruitPosition();

	}
	function randomizeFruitPosition(?Object1:FlxObject, ?Object2:FlxObject):Void
	{
		// Pick a random place to put the fruit down
		fruit.x = FlxG.random.int(0, Math.floor(FlxG.width / 8) - 1) * 8;
		fruit.y = FlxG.random.int(0, Math.floor(FlxG.height / 8) - 1) * 8;
	}

	function resetTimer(?Timer:FlxTimer):Void
	{
		// Stop the movement cycle if we're dead
		if (!snakeHead.alive && Timer != null)
		{
			Timer.destroy();
			return;
		}

		new FlxTimer().start(_movementInterval / FlxG.updateFramerate, resetTimer);
		moveSnake();
	}

	function moveSnake():Void
	{
		headPoints.unshift(FlxPoint.get(snakeHead.x, snakeHead.y));

		if (headPoints.length > snakeBody.members.length)
		{
			headPoints.pop();
		}

		
		switch (nextDir)
		{
			case LEFT:
				snakeHead.x -= 10;
			case RIGHT:
				snakeHead.x += 10;
			case UP:
				snakeHead.y -= 10;
			case DOWN:
				snakeHead.y += 10;
		}
		currentDir = nextDir;

		FlxSpriteUtil.screenWrap(snakeHead);

		for (i in 0...headPoints.length)
		{
			snakeBody.members[i].setPosition(headPoints[i].x, headPoints[i].y);
		}
		timer = new FlxTimer();
		if (!snakeHead.alive && timer != null)
		{
			timer.destroy();
			return;
		}

		new FlxTimer().start(_movementInterval / FlxG.updateFramerate, resetTimer);
		moveSnake();
	}

}
