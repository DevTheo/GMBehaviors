/// Setup behavior

// Time to take a different approach here
/*
params:
{
    speed: 4,
    jumpStrength: 7,    
    button: -1, // any
    keyJump: ' ',    
    ladderBlocks: dslist,
    blocks, dslist, // required, solid objects
    gravity:0.2 // gravity inc
}
*/
var obj = scr_create_behavior_with_json_string_params(argument0, "PlatformMoveBehavior");
show_debug_message("PlatformMoveBehavior-json: " + json_encode(obj));
var target = scr_BehaviorProp_Target(obj);

if(is_undefined(target)) {
    target = self.id;
    script_execute(scr_BehaviorProp_Target, obj, target);
}

if(!ds_map_exists(obj, "button"))
    obj[? "button"] = -1;

if (!ds_map_exists(obj, "keyJump"))
{
    obj[? "keyJump"] = vk_space;
}

obj[? "jumps"] = 0;

obj[? "hsp"] = 0;
obj[? "vsp"] = 0;

var events = obj[? "events"];

ds_list_add(events[? "keys"], "step");
events[? "step"] = scr_PlatformMoveBehavior_step;
obj[? "_destroy_"] = scr_destroy_platformmovebehavior;

obj[? "events"] = events;

return obj;
