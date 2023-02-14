package;

import PlayState;
import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.text.FlxText;

class EndState extends FlxState
{
	override public function create():Void
	{
		super.create();
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