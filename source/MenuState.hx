package;

import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.text.FlxText;

class MenuState extends FlxState
{
	var playButton:FlxButton;
	var menuBackground:FlxSprite;
	var logo:FlxSprite;
	override public function create():Void
	{
		super.create();
		var windowWidth = FlxG.stage.stageWidth;
		var windowHeight = FlxG.stage.stageHeight;
		menuBackground = new FlxSprite();
		// width: 640; height:480
		menuBackground.loadGraphic("assets/images/menu_background2.png", false, 640, 480);
		menuBackground.screenCenter();
		add(menuBackground);

		logo = new FlxSprite();
		logo.loadGraphic("assets/images/logo.png", false);
		logo.x = windowWidth * 0.25;
		logo.y = windowHeight * 0.8;
		add(logo);

		playButton = new FlxButton(0, 0, "Play now", clickPlay);
		playButton.screenCenter();
		add(playButton);

		var titleText = new FlxText((windowWidth * 0.5) - 25, 50, "EVOLVING SNAKE", 38);
		add(titleText);		
	}
	//Play Button is clicked:
	function clickPlay():Void

	{
		FlxG.switchState(new PlayState());
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}