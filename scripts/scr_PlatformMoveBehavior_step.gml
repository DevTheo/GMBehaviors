var obj = argument0;

var target = scr_BehaviorProp_Target(obj);
var moveSpeed = scr_BehaviorProp_MoveSpeed(obj);
var button = scr_BehaviorProp_Button(obj);
var keyJump = scr_BehaviorProp_JumpKey(obj);
var ladderBlocks = scr_BehaviorProp_Target2(obj);
var timeout = scr_BehaviorProp_Timeout(obj);
var hasSprites = false;

var multiSpritesBehavior = MultipleSpritesBehavior(target);
var getSprite = multiSpritesBehavior[? "_GetSprite"]

var spriteLeft = script_execute(getSprite, "left");
var spriteRight = script_execute(getSprite, "right");
//var spriteUp = script_execute(getSprite, "up");
//var spriteDown = script_execute(getSprite, "down");
var spriteJumpLeft = script_execute(getSprite, "jumpLeft");
var spriteJumpRight = script_execute(getSprite, "jumpRight");
var grav = obj[? "gravity"];

var movementObj = MovementDetectionBehavior(target);
var movement = script_execute(movementObj[? "GetMovement"], movementObj);
var joystickNumber = scr_BehaviorProp_JoystickNumber(movementObj);

if (joystickNumber > 0) {
    if(button > 0) {
        joyJump = gamepad_button_check(joystickNumber, button);
    } else { // any button
        var buttonCount = gamepad_button_count(joystickNumber);
        for(var btnNum = 1; btnNum <= buttonCount; btnNum ++) {
            joyJump = gamepad_button_check(joystickNumber, btnNum);
            if(joyJump)
                break;
        }
    }
}

mvLeft = movement[? "left"];
mvRight = movement[? "right"];
mvJump = joyJump || keyboard_check(ord(keyJump));

// Now we can actually make changes
var offsetX = target.sprite_get_xoffset(target.sprite_index)); // ??
var offsetY = target.sprite_get_yoffset(target.sprite_index)); // ??
var bottom = target.y + (target.sprite_height - offsetY));
var left = target.x -  (target.sprite_height - offsetX));
var right = target.x + (target.sprite_height - offsetX);
var canJump = freePlace(
