/// Setup behavior
var obj = scr_create_behavior_base(argument0);

obj[? "speed"] = argument1;

var joystickNumber = 0;
if (argument_count > 2) {
    joystickNumber = argument[2]; //list of 2 items
}

var constrain = true;

if (argument_count > 3) {
    constrain = argument[3];
}

obj[? "constrain"] = constrain;

var keyUp = vk_up;
var keyDown = vk_down;
var keyLeft = vk_left;
var keyRight = vk_right;

if (argument_count == 5 && argument[4] == true) {
    keyUp = ord("w");
    keyDown = ord("s");
    keyLeft = ord("a");
    keyRight = ord("d");
} else if (argument_count == 8) {
    keyUp = argument[4];
    keyDown = argument[5];
    keyLeft = argument[6];
    keyRight = argument[7];
}

obj[? "joystickNumber"] = joystickNumber;

obj[? "keyUp"] = keyUp;
obj[? "keyDown"] = keyDown;
obj[? "keyLeft"] = keyLeft;
obj[? "keyRight"] = keyRight;

obj[? "constrainX"] = 0;
obj[? "constrainY"] = 0;
obj[? "constrainH"] = room_height;
obj[? "constrainW"] = room_width;

obj[? "prop_keyUp"] = scr_BehaviorProp_UpKey;
obj[? "prop_keyDown"] = scr_BehaviorProp_DownKey;
obj[? "prop_keyLeft"] = scr_BehaviorProp_LeftKey;
obj[? "prop_keyRight"] = scr_BehaviorProp_RightKey;
obj[? "prop_constrain"] = scr_BehaviorProp_Constrain;
obj[? "prop_MoveSpeed"] = scr_BehaviorProp_MoveSpeed;
obj[? "prop_ConstrainX"] = scr_BehaviorProp_ConstrainX;
obj[? "prop_ConstrainY"] = scr_BehaviorProp_ConstrainY;
obj[? "prop_ConstrainHeight"] = scr_BehaviorProp_ConstrainH;
obj[? "prop_ConstrainWidth"] = scr_BehaviorProp_ConstrainW;
obj[? "prop_JoystickNumber"] = scr_BehaviorProp_JoystickNumber;

var events = obj[? "events"];

ds_list_add(events[? "keys"], "step");
events[? "step"] = scr_SimpleMovableBehavior_step;

obj[? "events"] = events;

if (!is_undefined(argument0.behaviors)) {
    ds_list_add(argument0.behaviors, obj);
}

return obj;
