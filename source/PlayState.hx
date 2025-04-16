package;

import flixel.FlxState;

class PlayState extends FlxState
{

	var player:Player;

	override public function create()
	{
		player = new Player(20,20); // Place the player at (20, 20)
		add(player); // Add the player to the state
		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
