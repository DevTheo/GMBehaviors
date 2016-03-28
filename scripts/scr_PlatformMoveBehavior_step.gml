var obj = argument0;

var target = scr_BehaviorProp_Target(obj);
var moveSpeed = scr_BehaviorProp_MoveSpeed(obj);
var button = scr_BehaviorProp_Button(obj);
var keyJump = obj[? "keyJump"];
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

var spriteDefault = script_execute(getSprite, "default");
var spriteLeft = script_execute(getSprite, "left");
var spriteRight = script_execute(getSprite, "right");
var spriteUp = script_execute(getSprite, "up");
var spriteDown = script_execute(getSprite, "down");
var spriteJumpLeft = script_execute(getSprite, "jumpLeft");
var spriteJumpRight = script_execute(getSprite, "jumpRight");
var renderSpriteChanges = spriteDefault != spriteLeft && 
                          spriteDefault != spriteRight &&
                          spriteDefault != spriteJumpLeft &&
                          spriteDefault != spriteJumpRight;
                          
var movementObj = MovementDetectionBehavior(target);
var movement = script_execute(movementObj[? "GetMovement"], movementObj);
var joystickNumber = scr_BehaviorProp_JoystickNumber(movementObj);
var joyJump = false;

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

var keyJumpDown = keyboard_check(ord(keyJump));
var mvJump = (joyJump == true || keyJumpDown == true);

// Now we can actually make changes
var offsetX = sprite_get_xoffset(target.sprite_index); // ??
var offsetY = sprite_get_yoffset(target.sprite_index); // ??

var spriteTop = target.y - offsetY;
var spriteMiddle = spriteTop + (target.sprite_height/2);
var spriteBottom = target.y + (target.sprite_height - offsetY);
var spriteLeft = target.x - offsetX;
var spriteCenter = spriteLeft + (target.sprite_width/2);
var spriteRight = target.x + (target.sprite_width - offsetX);

show_debug_message("x: " + string(target.x));
show_debug_message("offsetX: " + string(offsetX));
show_debug_message("spriteLeft: " + string(spriteLeft));
show_debug_message("spriteCenter: " + string(spriteCenter));
show_debug_message("spriteRight: " + string(spriteRight));

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

var wallOnLeft = !place_free(spriteLeft - 1, spriteMiddle);
var wallOnRight = !place_free(spriteRight + 1, spriteMiddle);

var onGround = !place_free(spriteCenter, spriteBottom + 1); // TODO: Add detection for ladders
show_debug_message("on ground: " + string(onGround));
var wallAbove = !place_free(spriteCenter, spriteTop - 1); // TODO: Add detection for ladders
show_debug_message("wall above: " + string(wallAbove));

var wallJump = wallOnLeft || wallOnRight; 
var canJump = wallJump || onGround;
              
var canDoubleJump = obj[? "CanDblJump"];
if (!place_free(offsetX, spriteBottom + 1)) {
    canDoubleJump = true;
}

if (mvJump && (canJump || canDoubleJump)) {
    if(!(mvJump && canJump)) {
        canDoubleJump = false;
    }
    //mvJump = true;
} else {
    mvJump = false;
}

// tutorial collide with ground
if (onGround && target.vspeed > 0) {
    move_contact_all(270, 12);
}

// if collide with wall above
if (wallAbove && target.vspeed > 0) {
    target.vspeed = 0;
}

// Tutorial Step code...
if (!onGround) {
    target.gravity_direction = 270;
    target.gravity = gravityInc;
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
    if(renderSpriteChanges) {
        if((!onGround || mvJump) && target.sprite_index != spriteJumpLeft) {
            target.sprite_index = spriteJumpLeft;
            target.image_index = 0;
        } else if (target.sprite_index != spriteLeft) {
            target.sprite_index = spriteLeft;
            target.image_index = 0;
        }
    }
    
    if( !wallOnLeft) {
        target.x -= moveSpeed;
    }
}

// Tutorial right key code...
if (mvRight) {    
    if(renderSpriteChanges) {
        if((!onGround || mvJump) && target.sprite_index != spriteJumpRight) {
            target.sprite_index = spriteJumpRight;
            target.image_index = 0;
        } else if (target.sprite_index != spriteRight) {
            target.sprite_index = spriteRight;
            target.image_index = 0;
        }    
    }
    if(!wallOnRight) {
        target.x += moveSpeed;
    }
}


obj[? "CanDblJump"] = canDoubleJump ;
