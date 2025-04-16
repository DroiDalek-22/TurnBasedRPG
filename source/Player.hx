package;

import flixel.FlxG;
import flixel.FlxSprite;

// import flixel.util.FlxColor;

class Player extends FlxSprite
{
    static inline var SPEED:Float = 100; // Player speed

    public function new(x:Float = 0, y:Float = 0)
    {
        super(x,y); // Call the parent constructor with x and y coordinates

        // makeGraphic(16, 16, FlxColor.BLUE); // Generate a blue square for the player

        loadGraphic(AssetPaths.player__png, true, 16, 16); // Load the player graphic
        drag.x = drag.y = 800; // Prevent player from running forever
        setFacingFlip(LEFT, false, false); // Set the facing direction to left, sprite will not be flipped
        setFacingFlip(RIGHT, true, false); // Set the facing direction to right, sprite will be flipped
        setSize(8, 8); // Set the size of the player sprite
        offset.set(4, 8); // Set the offset for the sprite

        // Add idle animations for down, left-right, and up directions
        animation.add("d_idle", [0]); 
        animation.add("lr_idle", [3]);
        animation.add("u_idle", [6]);
        // Add walk animations for down, left-right, and up directions
        animation.add("d_walk", [0, 1, 0, 2], 6);
        animation.add("lr_walk", [3, 4, 3, 5], 6);
        animation.add("u_walk", [6, 7, 6, 8], 6);
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
                facing = UP;
            }
            else if (down)
            {
                newAngle = 90;
                if (left)
                    newAngle += 45;
                else if (right)
                    newAngle -= 45;
                facing = DOWN;
            }
            else if (left)
            {
                newAngle = 180;
                facing = LEFT;
            }
            else if (right)
            {
                newAngle = 0;
                facing = RIGHT;
            }
            velocity.setPolarDegrees(SPEED, newAngle); // Set the velocity based on the angle and speed
        }

        var action = "idle";
        //check if the player is moving, and not walking into walls
        if ((velocity.x != 0 || velocity.y != 0) && touching == NONE)
        {
            action = "walk";
        }

        switch (facing)
        {
            case LEFT, RIGHT :
                animation.play("lr_" + action);
            case UP :
                animation.play("u_" + action);
            case DOWN :
                animation.play("d_" + action);
            case _ :
        }
    }

    override function update(elapsed:Float) 
    {
        updateMovement(); // Call the movement update function
        super.update(elapsed); // Call the parent update function
    }
}
