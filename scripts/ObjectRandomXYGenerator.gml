/// Setup behavior
var obj = scr_create_behavior_base(argument0, "ObjectRandomXYGenerator");

script_execute(scr_BehaviorProp_Target2, obj, argument1);
script_execute(scr_BehaviorProp_Speed, obj, argument2);
script_execute(scr_BehaviorProp_ConstrainX, obj, argument3);
script_execute(scr_BehaviorProp_ConstrainY, obj, argument4);
script_execute(scr_BehaviorProp_ConstrainW, obj, argument5);
script_execute(scr_BehaviorProp_ConstrainH, obj, argument6);
script_execute(scr_BehaviorProp_Timeout, obj, 0);

var sound = -1;
if (argument_count > 8) {
    sound = argument[7];   
}

script_execute(scr_BehaviorProp_Sound, obj, sound);

obj[? "prop_ObjecToCreate"] = scr_BehaviorProp_Target2;
obj[? "prop_CreationSpeed"] = scr_BehaviorProp_Speed;
obj[? "prop_MinX"] = scr_BehaviorProp_ConstrainX;
obj[? "prop_MinY"] = scr_BehaviorProp_ConstrainY;
obj[? "prop_Width"] = scr_BehaviorProp_ConstrainW;
obj[? "prop_Height"] = scr_BehaviorProp_ConstrainH;
obj[? "prop_CreateIn"] = scr_BehaviorProp_Timeout;
obj[? "prop_Sound"] = scr_BehaviorProp_Sound;

var events = obj[? "events"];

ds_list_add(events[? "keys"], "step");
events[? "step"] = scr_ObjectRandomXYGenerator_step;

obj[? "events"] = events;

return obj;
