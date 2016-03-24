/// Setup behavior
var obj = ds_map_create();

obj[? "target"] = argument0;
var events = ds_map_create();
events[? "keys"] = ds_list_create();
obj[? "events"] = events;

obj[? "prop_Target"] = scr_BehaviorProp_Target;

if (!is_undefined(argument0.behaviors)) {
    ds_list_add(argument0.behaviors, obj);
}

obj[? "BehaviorName"] = argument1;
return obj;
