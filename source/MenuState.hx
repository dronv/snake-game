package;

import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.text.FlxText;

class MenuState extends FlxState
{

	var playButton:FlxButton;
	var menuBackground:FlxSprite;
	override public function create():Void
	{
		super.create();
		var windowWidth = FlxG.stage.stageWidth;
		var windowHeight = FlxG.stage.stageHeight;
		
		//adding background
		menuBackground = new FlxSprite();
		menuBackground.loadGraphic("assets/images/menu_background2.png", false, 640, 480);
		menuBackground.screenCenter();
		add(menuBackground);

		//adding play button
		playButton = new FlxButton(0, 0, "Play now", clickPlay);
		playButton.x = windowWidth *0.5 - playButton.width*0.5;
		playButton.y = windowHeight *0.4;
		add(playButton);

		//adding title text
		var titleText = new FlxText("EVOLVING SNAKE", 47);
		titleText.x = windowWidth * 0.5 - titleText.width * 0.5;
		titleText.y = 50;
		add(titleText);	

		//adding Instructions
		var howToPlayText1 = new FlxText(
		"Use the ARROW KEYS to move around,
		      collect APPLES and grow!     ");
		howToPlayText1.setFormat(null, 16, FlxColor.BLACK, CENTER, OUTLINE);
		howToPlayText1.x = windowWidth* 0.5 - howToPlayText1.width * 0.5;
		howToPlayText1.y = windowHeight*0.55;
		add(howToPlayText1);

		var howToPlayText2 = new FlxText(
		"But careful: Don't CRASH into yourself!");
		howToPlayText2.setFormat(null, 16, FlxColor.BLACK, CENTER, OUTLINE);
		howToPlayText2.x = windowWidth* 0.5 - howToPlayText1.width * 0.5;
		howToPlayText2.y = windowHeight*0.75;
		add(howToPlayText2);
	}

	//if play button is clicked:
	function clickPlay():Void

	{
		FlxG.switchState(new PlayState());
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}