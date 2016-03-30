var obj = argument0;
var events = obj[? "events"];

ds_list_clear(events[? "keys"]);
ds_list_destroy(events[? "keys"]);
ds_map_clear(events);
ds_map_destroy(events);

ds_map_clear(obj);
ds_map_destroy(obj);
