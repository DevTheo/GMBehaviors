var obj = argument0;

var target = scr_BehaviorProp_Target(obj);
var moveSpeed = scr_BehaviorProp_MoveSpeed(obj);
var button = scr_BehaviorProp_Button(obj);
var keyJump = scr_BehaviorProp_JumpKey(obj);
var ladderBlocks = scr_BehaviorProp_Target2(obj);
var timeout = scr_BehaviorProp_Timeout(obj);
var gravityInc = obj[? "gravity"];
var jumpStrength = obj[? "jumpStrength"];
var ladderBlocks = -1;

if(ds_map_exists(obj, "ladderBlocks")) {
    ladderBlocks = obj[? "ladderBlocks"];
}

var multiSpritesBehavior = MultipleSpritesBehavior(target);
var getSprite = multiSpritesBehavior[? "_GetSprite"]

var spriteLeft = script_execute(getSprite, "left");
var spriteRight = script_execute(getSprite, "right");
var spriteUp = script_execute(getSprite, "up");
var spriteDown = script_execute(getSprite, "down");
var spriteJumpLeft = script_execute(getSprite, "jumpLeft");
var spriteJumpRight = script_execute(getSprite, "jumpRight");

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
var offsetX = sprite_get_xoffset(target.sprite_index); // ??
var offsetY = sprite_get_yoffset(target.sprite_index); // ??
var spriteBottom = target.y + (target.sprite_height - offsetY);
var spriteLeft = target.x -  (target.sprite_height - offsetX);
var spriteRight = target.x + (target.sprite_height - offsetX);

// detect ladder blocks
var ladderOnLeft = false;
var ladderOnRight = false;
if (ladderBlocks > -1) {
    var ladderCount = ds_list_size(ladderBlocks);
    for(var idx=0; idx<ladderCount; idx++) {
        var block = ds_list_find_value(ladderBlocks, idx);
        if(!is_undefined(block)) {
            if(!ladderOnLeft && position_meeting(spriteLeft-1, offsetY, block))
                ladderOnLeft = true;
            if(!ladderOnRight && position_meeting(spriteRight+1, offsetY, block))
                ladderOnRight = true;
            if(ladderOnLeft && ladderOnRight)
                break; // no need to continue
        }
    }
}
var wallOnLeft = !place_free(spriteLeft - 1, offsetY);
var wallOnRight = !place_free(spriteRight + 1, offsetY);
var onGround = !place_free(offsetX, spriteBottom + 1); // TODO: Add detection for ladders
var wallJump = wallOnLeft || wallOnRight; 
var canJump = wallJump || onGround;
              
var canDoubleJump = obj[? "CanDblJump"];
if (!place_free(offsetX, spriteBottom + 1)) {
    canDoubleJump = true;
}

if (mvJump && canJump || canDoubleJump) {
    if(!(mvJump && canJump)) {
        canDoubleJump = false;
    }
    mvJump = true;
} else {
    mvJump = false;
}

// Tutorial Step code...
if (!onGround) {
    target.gravity = gravityInc;
    target.gravity_direction = 270;
} else {
    target.gravity = 0;
    target.gravity_direction = 270;    
}
if (target.vspeed > 12) {
    target.vspeed = 12;
}

// Tutorial Jump key code...
if (mvJump) {
    target.vspeed = -10;
}

// Tutorial left key code...
if (mvLeft) {
    if((!onGround || mvJump) && target.sprite_index != spriteJumpLeft) {
        target.sprite_index = spriteJumpLeft;
        target.image_index = 0;
    } else if (target.sprite_index != spriteLeft) {
        target.sprite_index = spriteLeft;
        target.image_index = 0;
    }
    if( !wallOnLeft) {
        target.x -= moveSpeed;
    }
}

// Tutorial right key code...
if (mvRight) {
    if((!onGround || mvJump) && target.sprite_index != spriteJumpRight) {
        target.sprite_index = spriteJumpRight;
        target.image_index = 0;
    } else if (target.sprite_index != spriteRight) {
        target.sprite_index = spriteRight;
        target.image_index = 0;
    }
    
    if(!wallOnRight) {
        target.x += moveSpeed;
    }
}


obj[? "CanDblJump"] = canDoubleJump ;
