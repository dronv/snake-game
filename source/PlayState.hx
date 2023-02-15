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
	var apple:FlxSprite;
	var headPoints:Array<FlxPoint>;
	var snakeBody:FlxSpriteGroup;
	var bodyBlock : FlxSprite;
	var score:Int = 0;
	var currentDir = FlxDirection.LEFT;
	var nextDir = FlxDirection.LEFT;
	var _movementInterval:Float = 8;
	var MIN_INTERVAL : Float = 2;
	var timer : FlxTimer;
	var snakeHead:Snakehead;

	override public function create()
	{
		FlxG.sound.play(AssetPaths.playclick__wav);
		FlxG.sound.playMusic(AssetPaths.bgm__ogg);
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
		snakeHead = new Snakehead(0,0);
		add(snakeHead);
		snakeHead.screenCenter;

		snakeHead.facing = DOWN;
		snakeHead.setFacingFlip(RIGHT, false, true);
		snakeHead.setFacingFlip(LEFT, false, true);
		snakeHead.setFacingFlip(UP, true, false);
		snakeHead.setFacingFlip(DOWN,true, false);
		
		headPoints = [FlxPoint.get(snakeHead.x, snakeHead.y)];
		
		snakeBody = new FlxSpriteGroup();
		add(snakeBody);

		for (i in 0...3)
		{
			addBody();
			movement();
		}
		add(snakeHead);

		apple = new FlxSprite();
        apple.loadGraphic(AssetPaths.apple__png);
		applePosition();
		apple.offset.set(1, 1);
		apple.centerOffsets();
		add(apple);

		scoreText = new FlxText(0, 4, FlxG.width, "Score: " + 0);
		scoreText.setFormat(null, 16, FlxColor.WHITE, CENTER, OUTLINE);
		add(scoreText);
		makeSnakeMove();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		if (FlxG.keys.anyPressed([UP, W]) && currentDir != DOWN)
		{
			nextDir = UP;
			snakeHead.facing = UP;
		}
		else if (FlxG.keys.anyPressed([DOWN, S]) && currentDir != UP)
		{
			nextDir = DOWN;
			snakeHead.facing = DOWN;
		}
		else if (FlxG.keys.anyPressed([LEFT, A]) && currentDir != RIGHT)
		{
			nextDir = LEFT;
			snakeHead.facing = LEFT;
		}
		else if (FlxG.keys.anyPressed([RIGHT, D]) && currentDir != LEFT)
		{
			nextDir = RIGHT;
			snakeHead.facing = RIGHT;
		}

		FlxG.overlap(snakeHead, apple, snakeEatsFruit);
		hit();
	}

	function increaseScore(Amount:Int = 10):Void
	{
		score += Amount;
		scoreText.text = "Score: " + score;
		scoreText.alpha = 0;
		FlxTween.tween(scoreText, {alpha: 1}, 0.5);
	}

	function addBody():Void
	{
		bodyBlock = new FlxSprite(-20, -20);
		bodyBlock.makeGraphic(20, 20, FlxColor.GREEN);
		snakeBody.add(bodyBlock);
	}

	function snakeEatsFruit(Object1:FlxObject, Object2:FlxObject):Void
	{
		increaseScore();
		addBody();
		applePosition();
		FlxG.sound.play(AssetPaths.eat__wav);
		if(score>=200 &&score<250){
			snakeHead.updatestate();
		}
	}
	function applePosition(?Object1:FlxObject, ?Object2:FlxObject):Void
	{

		apple.x = FlxG.random.int(0, Math.floor(FlxG.width / 8) - 1) * 8;
		apple.y = FlxG.random.int(0, Math.floor(FlxG.height / 8) - 1) * 8;
	}

	function makeSnakeMove(?Timer:FlxTimer):Void
	
	{
		if (!snakeHead.alive && Timer != null)
		{
			Timer.destroy();
			return;
		}

		new FlxTimer().start(_movementInterval / FlxG.updateFramerate, makeSnakeMove);
		movement();
	}

	function movement():Void
	{
		headPoints.unshift(FlxPoint.get(snakeHead.x, snakeHead.y));

		if (headPoints.length > snakeBody.members.length)
		{
			headPoints.pop();
		}

		
		switch (nextDir)
		{
			case LEFT:
				snakeHead.x -= 15;
			case RIGHT:
				snakeHead.x += 15;
			case UP:
				snakeHead.y -= 15;
			case DOWN:
				snakeHead.y += 15;
		}
		currentDir = nextDir;

		FlxSpriteUtil.screenWrap(snakeHead);

		for (i in 0...headPoints.length)
		{
			snakeBody.members[i].setPosition(headPoints[i].x, headPoints[i].y);
		}
	}

	function hit():Void {
		if(FlxG.overlap(snakeHead,bodyBlock)){
			FlxG.switchState(new EndState(score));
		}
	}	

}

