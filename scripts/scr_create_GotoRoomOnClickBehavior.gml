/// Setup behavior
var obj = scr_create_behavior_base(argument0, argument1);
var events = obj[? "events"];

ds_list_add(events[? "keys"], "onclick");
events[? "onclick"] = scr_GotoRoomOnClickBehavior_click;
obj[? "events"] = events;

event_perform_object(obj[? "target"], ev_user0, obj);
