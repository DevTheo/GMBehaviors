/// Setup behavior
var obj = scr_create_behavior_base(argument0, "GotoRoomOnClickBehavior");

obj[? "room"] = argument1;

var events = obj[? "events"];

ds_list_add(events[? "keys"], "leftbutton");
events[? "leftbutton"] = scr_GotoRoomOnClickBehavior_click;

obj[? "events"] = events;

obj[? "prop_Room"] = scr_BehaviorProp_Room;

return obj;
