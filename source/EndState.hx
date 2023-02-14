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
	var score:Float;
	override public function create():Void
	{
		super.create();
		var windowHeight = FlxG.stage.stageHeight;
		var windowWidth = FlxG.stage.stageWidth;
		//var score = PlayState.score;

		endBackground = new FlxSprite();
		endBackground.loadGraphic("assets/images/menu_background2.png", false, 640, 480);
		add(endBackground);

		gameOverText = new FlxText((windowWidth/2 - 200), windowHeight/5, 400,"Game Over!", 50);
		add(gameOverText);

		yourScoreText = new flixel.text.FlxText(windowWidth/2 - 150, windowHeight/3, 300, "Your Score: "+ "X", 30);
		add(yourScoreText);

		exitText = new FlxText(windowWidth /2 - 270, windowHeight* 0.8, 600, "---Click 'ALT' + 'F4' to exit Game---", 24);
		add(exitText);

		playAgainButton = new FlxButton (0, 0, "Play again", clickAgain);
		playAgainButton.screenCenter();
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