package;

import PlayState;
import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.text.FlxText;

class EndState extends FlxState
{


	var endBackground:FlxSprite;
	var gameOverText:FlxText;
	var yourScoreText:FlxText;
	var exitText:FlxText;
	var playAgainButton:FlxButton;
	var score:Int;

	public function new(score:Int)
	{	
		super();
		this.score = score;
	}

	override public function create():Void
	{
		FlxG.sound.play(AssetPaths.fail__mp3);
		super.create();
		FlxG.mouse.visible = true;
		var windowHeight = FlxG.stage.stageHeight;
		var windowWidth = FlxG.stage.stageWidth;

		endBackground = new FlxSprite();
		endBackground.loadGraphic("assets/images/menu_background2.png", false, 640, 480);
		add(endBackground);

		gameOverText = new FlxText("Game Over!", 50);
		gameOverText.x = windowWidth*0.5 - gameOverText.width*0.5;
		gameOverText.y = windowHeight/5;
		add(gameOverText);

		yourScoreText = new flixel.text.FlxText("Your Score: " + score, 30);
		yourScoreText.x = windowWidth/2 - yourScoreText.width * 0.5;
		yourScoreText.y =  windowHeight/3;
		add(yourScoreText);

		exitText = new FlxText("---Click 'ALT' + 'F4' to exit Game---", 24);
		exitText.x = windowWidth /2 - exitText.width * 0.5;
		exitText.y = windowHeight * 0.85;
		add(exitText);

		playAgainButton = new FlxButton (0, 0, "Play again", clickAgain);
		playAgainButton.x = (windowWidth * 0.5 ) - playAgainButton.width / 2;
		playAgainButton.y = windowHeight * 0.65;

		add(playAgainButton);
	}
	//Play again button is clicked:
	function clickAgain():Void
	{
		FlxG.switchState(new PlayState());
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
