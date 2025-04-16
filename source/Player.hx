package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class Player extends FlxSprite
{
    static inline var SPEED:Float = 100; // Player speed

    public function new(x:Float = 0, y:Float = 0)
    {
        super(x,y); // Call the parent constructor with x and y coordinates
        makeGraphic(16, 16, FlxColor.BLUE); // Generate a blue square for the player
        drag.x = drag.y = 800; // Prevent player from running forever
    }

    function updateMovement()
    {
        // Update the player's velocity based on key presses
        var up:Bool = false;
        var down:Bool = false;
        var left:Bool = false;
        var right:Bool = false;

        // Verify if certain keys are pressed, return true if that's the case
        up = FlxG.keys.anyPressed([UP,Z]);
        down = FlxG.keys.anyPressed([DOWN,S]);
        left = FlxG.keys.anyPressed([LEFT,Q]);
        right = FlxG.keys.anyPressed([RIGHT,D]);

        // Cancel out opposing directions
        if (up && down)
            up = down = false;
        if (left && right)
            left = right = false;

        // Set the angle based on the keys pressed
        if (up || down || left || right)
        {
            var newAngle:Float = 0;
            if (up)
            {
                newAngle = -90;
                if (left)
                    newAngle -= 45;
                else if (right)
                    newAngle += 45;
            }
            else if (down)
            {
                newAngle = 90;
                if (left)
                    newAngle += 45;
                else if (right)
                    newAngle -= 45;
            }
            else if (left)
                newAngle = 180;
            else if (right)
                newAngle = 0;
            
            velocity.setPolarDegrees(SPEED, newAngle); // Set the velocity based on the angle and speed
        }
    }

    override function update(elapsed:Float) 
    {
        updateMovement(); // Call the movement update function
        super.update(elapsed); // Call the parent update function
    }
}