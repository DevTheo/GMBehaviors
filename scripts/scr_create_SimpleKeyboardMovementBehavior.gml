/// Setup behavior
var obj = scr_create_behavior_base(argument0);

obj[? "speed"] = argument1;

var constrain = true;

if (argument_count > 2) {
    constrain = argument2;
}

object_exists[? "constrain"] = constrain;

var keyUp = vk_up;
var keyDown = vk_down;
var keyLeft = vk_left;
var keyRight = vk_right;

if (argument_count == 4 && argument3 == true) {
    keyUp = ord("w");
    keyDown = ord("s");
    keyLeft = ord("a");
    keyRight = ord("d");
} else if (argument_count == 6) {
    keyUp = argument3;
    keyDown = argument4;
    keyLeft = argument5;
    keyRight = argument6;
}

obj[? "keyUp"] = keyUp;
obj[? "keyDown"] = keyDown;
obj[? "keyLeft"] = keyLeft;
obj[? "keyRight"] = keyRight;

var events = obj[? "events"];

ds_list_add(events[? "keys"], "step");
events[? "step"] = scr_SimpleKeyboardMovementBehavior_step;

obj[? "events"] = events;

return obj;
