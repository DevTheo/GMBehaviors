/// Setup behavior
if(!is_string(argument0)) {
    // arg0 is target instance and arg1 is behavior name
    var target = argument0;
    var bhCount = ds_list_size(target.behaviors);
    for(var idx = 0; idx < bhCount; idx++) {
        var bh = ds_list_find_value(target.behaviors, idx);
        if(!is_undefined(bh) && ds_map_exists(bh, "behaviorName") && bh[? "behaviorName"] == argument1) {
            return bh;
        }
    }
    return undefined;
}

var obj = scr_parse_kv_params(argument0);
if(!is_undefined(obj[? "default"])) {
    obj = obj[? "default"];
}
obj[? "behaviorName"] = argument1;

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
