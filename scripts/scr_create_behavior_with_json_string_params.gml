/// Setup behavior
var obj = json_decode(argument0);

var events = ds_map_create();
events[? "keys"] = ds_list_create();
obj[? "events"] = events;

if(ds_map_exists(obj, "target")) {
    obj[? "prop_Target"] = scr_BehaviorProp_Target;
    var target = obj[? "target"];
    if (!is_undefined(target.behaviors)) {
        ds_list_add(target.behaviors, obj);
    }
}

return obj;
