package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.ui.FlxButton;

class MenuState extends FlxState
{

    var playButton:FlxButton;

	override public function create()
	{
        playButton = new FlxButton(0, 0, "Play", clickPlay); // Create a button with the label "Play"
        add(playButton);
        playButton.screenCenter(); // Center the Play button on the screen
		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}

    function clickPlay()
    {
        FlxG.switchState(()->new PlayState()); // Switch to PlayState when the button is clicked
    }
}
