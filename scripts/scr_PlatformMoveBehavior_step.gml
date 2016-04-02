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
var blocks = obj[? "blocks"];
var jumps = obj[? "jumps"];

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

if (vsp < 10) vsp += gravityInc;

var onGround = scr_dslist_objects_place_meeting(x,y+1,blocks);
if (onGround)
    jumps =0;
    
if ((mvJump && jumps < 2 && vsp >= 0) ||
    onGround) {
    vsp = mvJump * -jumpStrength;
    if (mvJump) jumps++;
    if (mvJump && !onGround) jumps = 2;
}

//Horizontal Collision
if (scr_dslist_objects_place_meeting(x + hsp,y,blocks)) {
    while(!scr_dslist_objects_place_meeting(x + sign(hsp),y, blocks)) {
        target.x += sign(hsp);    
    }
    hsp = 0;    
}
target.x += hsp;

//Vertical Collision
if (scr_dslist_objects_place_meeting(x, y + vsp, blocks)) {
    while(!scr_dslist_objects_place_meeting(x,y + sign(vsp), blocks)) {
            target.y += sign(vsp);
    }
    vsp =0;    
}

target.y += vsp;

obj[?"hsp"] = hsp;
obj[?"vsp"] = vsp;
obj[? "jumps"] = jumps;
