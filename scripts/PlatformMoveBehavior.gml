/// Setup behavior

// Time to take a different approach here
/*
params:
{
    speed: 4,
    jumpStrength: 10,    
    button: -1, // any
    keyJump: ' ',    
    ladderBlocks: dslist,
    gravity:0.5 // gravity inc
}
*/
var obj = scr_create_behavior_with_json_string_params(argument0, "PlatformMoveBehavior");
show_debug_message("PlatformMoveBehavior-json: " + json_encode(obj));
var target = scr_BehaviorProp_Target(obj);

if(is_undefined(target)) {
    target = self.id;
    script_execute(scr_BehaviorProp_Target, obj, target);
}


if(!ds_map_exists(obj, "gravity")) {
    obj[? "gravity"] = 0.5;
}
if(!ds_map_exists(obj, "button"))
    obj[? "button"] = -1;

if (!ds_map_exists(obj, "keyJump"))
{
    obj[? "keyJump"] = vk_space;
}

obj[? "prop_keyJump"] = scr_BehaviorProp_JumpKey;
obj[? "prop_MoveSpeed"] = scr_BehaviorProp_MoveSpeed;
obj[? "prop_JoystickButton"] = scr_BehaviorProp_Button;
obj[? "CanDblJump"] = true;

var events = obj[? "events"];

ds_list_add(events[? "keys"], "step");
events[? "step"] = scr_PlatformMoveBehavior_step;

obj[? "events"] = events;

return obj;
