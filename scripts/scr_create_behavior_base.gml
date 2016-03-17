/// Setup behavior
var obj = ds_map_create();

obj[? "target"] = argument0;
obj[? "room"] = argument1;
var events = ds_map_create();
events[? "onclick"] = scr_GotoRoomOnClickBehavior_click;
obj[? "events"] = events;


event_perform_object(self.target, ev_user0, obj);
