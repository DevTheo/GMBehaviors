/// Setup behavior
var obj = scr_create_behavior_base(argument0, "SimpleMovableBehavior");

obj[? "speed"] = argument1;

var joystickNumber = 0;

var constrain = true;

if (argument_count > 2) {
    constrain = argument[2];
}


var constrainX = 0;
var constrainY = 0;
var constrainW = room_width;
var constrainH = room_height;        

if (argument_count > 5) {
    constrain = true;
    constrainX = argument[2];
    constrainY = argument[3];
    constrainW = argument[4];
    constrainH = argument[5];        
}
obj[? "constrain"] = constrain;

obj[? "constrainX"] = constrainX;
obj[? "constrainY"] = constrainY;
obj[? "constrainH"] = constrainH;
obj[? "constrainW"] = constrainW;

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
