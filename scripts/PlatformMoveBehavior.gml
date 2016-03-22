/// Setup behavior

// Time to take a different approach here
/*
params:
{
    speed: 0,
    joystickNumber: 1,
    button: -1, // any
    altKeys: true,
    keyUp: ord('w'),
    keyDown: 's',
    keyLeft: 'a',
    keyRight: 'd'
    keyJump: ' ',    
    ladderBlocks: dslist,
    playerSprites: {
        normal: {sprite},
        left: {sprite},
        right: {sprite},
        up: {sprite}, // climb
        down: {sprite}, // climb
        jump: {sprite},
        jumpLeft: {sprite},
        jumpRight: {sprite},      
    },
    gravity:2
}
*/
var obj = scr_create_behavior_with_json_string_params(argument1);

var target = scr_BehaviorProp_Target();

if(!ds_map_exists(obj, "joystickNumber"))
    obj[? "joystickNumber"] = 0;

if(!ds_map_exists(obj, "joystickNumber"))
    obj[? "button"] = -1;

var alt = false;
if (!ds_map_exists(obj, "altKeys")) 
{
    alt = obj[? "altKeys"] == true;
}

if (!ds_map_exists(obj, "keyUp"))
{
    if(alt)
        obj[? "keyUp"] = ord("w");
    else
        obj[? "keyUp"] = vk_up;
}
if (!ds_map_exists(obj, "keyDown"))
{
    if(alt)
        obj[? "keyDown"] = ord("s");
    else
        obj[? "keyDown"] = vk_down;
}
if (!ds_map_exists(obj, "keyLeft"))
{
    if(alt)
        obj[? "keyLeft"] = ord("a");
    else
        obj[? "keyLeft"] = vk_left;
}
if (!ds_map_exists(obj, "keyRight"))
{
    if(alt)
        obj[? "keyRight"] = ord("d");
    else
        obj[? "keyRight"] = vk_right;
}
if (!ds_map_exists(obj, "keySpace"))
{
    obj[? "keySpace"] = vk_space;
}

obj[? "prop_keyUp"] = scr_BehaviorProp_UpKey;
obj[? "prop_keyDown"] = scr_BehaviorProp_DownKey;
obj[? "prop_keyLeft"] = scr_BehaviorProp_LeftKey;
obj[? "prop_keyRight"] = scr_BehaviorProp_RightKey;
obj[? "prop_keyJump"] = scr_BehaviorProp_JumpKey;
obj[? "prop_MoveSpeed"] = scr_BehaviorProp_MoveSpeed;
obj[? "prop_ConstrainX"] = scr_BehaviorProp_ConstrainX;
obj[? "prop_ConstrainY"] = scr_BehaviorProp_ConstrainY;
obj[? "prop_ConstrainHeight"] = scr_BehaviorProp_ConstrainH;
obj[? "prop_ConstrainWidth"] = scr_BehaviorProp_ConstrainW;
obj[? "prop_JoystickNumber"] = scr_BehaviorProp_JoystickNumber;
obj[? "prop_JoystickButton"] = scr_BehaviorProp_Button;

var events = obj[? "events"];

ds_list_add(events[? "keys"], "step");
events[? "step"] = scr_PlatformMoveBehavior_step;

obj[? "events"] = events;

return obj;
