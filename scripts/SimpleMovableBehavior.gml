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

obj[? "constrainX"] = 0;
obj[? "constrainY"] = 0;
obj[? "constrainH"] = room_height;
obj[? "constrainW"] = room_width;

obj[? "prop_constrain"] = scr_BehaviorProp_Constrain;
obj[? "prop_ConstrainX"] = scr_BehaviorProp_ConstrainX;
obj[? "prop_ConstrainY"] = scr_BehaviorProp_ConstrainY;
obj[? "prop_ConstrainHeight"] = scr_BehaviorProp_ConstrainH;
obj[? "prop_ConstrainWidth"] = scr_BehaviorProp_ConstrainW;

var events = obj[? "events"];

ds_list_add(events[? "keys"], "step");
events[? "step"] = scr_SimpleMovableBehavior_step;

obj[? "events"] = events;

return obj;
