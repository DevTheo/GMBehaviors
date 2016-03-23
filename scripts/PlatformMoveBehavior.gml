/// Setup behavior

// Time to take a different approach here
/*
params:
{
    speed: 0,
    button: -1, // any
    keyJump: ' ',    
    ladderBlocks: dslist,
    gravity:2
}
*/
var obj = scr_create_behavior_with_json_string_params(argument1);

var target = scr_BehaviorProp_Target();

if(!ds_map_exists(obj, "button"))
    obj[? "button"] = -1;

if (!ds_map_exists(obj, "keyJump"))
{
    obj[? "keyJump"] = vk_space;
}

obj[? "prop_keyJump"] = scr_BehaviorProp_JumpKey;
obj[? "prop_MoveSpeed"] = scr_BehaviorProp_MoveSpeed;
obj[? "prop_JoystickButton"] = scr_BehaviorProp_Button;

var events = obj[? "events"];

ds_list_add(events[? "keys"], "step");
events[? "step"] = scr_PlatformMoveBehavior_step;

obj[? "events"] = events;

return obj;