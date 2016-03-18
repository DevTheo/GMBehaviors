/// Setup behavior
var obj = scr_create_behavior_base(argument0);

obj[? "room"] = argument1;

var events = obj[? "events"];

ds_list_add(events[? "keys"], "leftbutton");
events[? "leftbutton"] = scr_GotoRoomOnClickBehavior_click;

obj[? "events"] = events;

if (!is_undefined(argument0.behaviors)) {
    ds_list_add(argument0.behaviors, obj);
}

return obj;
