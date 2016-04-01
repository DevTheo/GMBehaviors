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
var hsp = obj[?"hsp"];
var vsp = obj[?"vsp"];
//var object_Wall = obj_wall;

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

mvLeft = -movement[? "left"];
mvRight = movement[? "right"];

var move = mvLeft + mvRight;

var keyJumpDown = keyboard_check(ord(keyJump));
var mvJump = (joyJump == true || keyJumpDown == true);

hsp = move * moveSpeed;

// wall below
var onGround = false;
var willCollideV = false;
var willCollideH = false;
var blocks = obj[? "blocks"];
for(var i=0; i <= ds_list_size(blocks); i++) {
    var object_Wall = ds_list_find_value(blocks, i);
    if (!is_undefined(object_Wall)) {
        onGround = onGround || place_meeting(target.x,target.y+1,object_Wall);

        willCollideH = willCollideH || place_meeting(target.x + hsp,target.y, object_Wall);
        willCollideV = willCollideV || place_meeting(target.x, target.y + vsp, object_Wall);
    }
}

if (vsp < 10) vsp += gravityInc;

if (onGround) {
    vsp = mvJump * -jumpStrength;
}

//Horizontal Collision
if (willCollideH) {
    var wallBesideCheck = false;
    while (!wallBesideCheck) {    
       for(var i=0; i <= ds_list_size(blocks); i++) {
            var object_Wall = ds_list_find_value(blocks, i);
            if (!is_undefined(object_Wall)) {
                wallBesideCheck = wallBesideCheck || 
                    place_meeting(target.x + sign(hsp),target.y, object_Wall);
            }
       }
       if (!wallBesideCheck) {    
            target.x += sign(hsp);    
       }
    }
    hsp = 0;    
}
target.x += hsp;

//Vertical Collision
if (willCollideV) {
    var wallBelowCheck = false;
    while (!wallBelowCheck) {
        for(var i=0; i <= ds_list_size(blocks); i++) {
            var object_Wall = ds_list_find_value(blocks, i);
            if (!is_undefined(object_Wall)) {
                wallBelowCheck = wallBelowCheck || 
                    place_meeting(target.x, target.y + sign(vsp), object_Wall); 
            }
        }
        if (wallBelowCheck) {
            target.y += sign(vsp);
        }
    }
    vsp =0;    
}

target.y += vsp;

obj[?"hsp"] = hsp;
obj[?"vsp"] = vsp;

