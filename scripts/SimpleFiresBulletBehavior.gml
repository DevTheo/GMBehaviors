/// Setup behavior
var obj = scr_create_behavior_base(argument0);

script_execute(scr_BehaviorProp_Target2, obj, argument1); // bullet object
script_execute(scr_BehaviorProp_Speed, obj, argument2); // firespeed
script_execute(scr_BehaviorProp_RelativeX, obj, argument3);
script_execute(scr_BehaviorProp_RelativeY, obj, argument4);
script_execute(scr_BehaviorProp_BulletDir, obj, argument5);
script_execute(scr_BehaviorProp_Speed2, obj, argument6);
script_execute(scr_BehaviorProp_Key, obj, argument7);
script_execute(scr_BehaviorProp_Timeout, obj, 0);
var joystick = -1;
var button = -1;
if (argument_count > 8) {
    joystick = argument[8];
}
if (argument_count > 9) {
    joystickButton = argument[9];
}
script_execute(scr_BehaviorProp_Joystick, obj, joystick);
script_execute(scr_BehaviorProp_Button, obj, button);
if (argument_count > 10) {
    script_execute(scr_BehaviorProp_Sound, obj, argument[10]);    
}
obj[? "prop_BulletObject"] = scr_BehaviorProp_Target2;
obj[? "prop_FireSpeed"] = scr_BehaviorProp_Speed;
obj[? "prop_RelativeX"] = scr_BehaviorProp_RelativeX;
obj[? "prop_RelativeY"] = scr_BehaviorProp_RelativeY;
obj[? "prop_BulletDir"] = scr_BehaviorProp_BulletDir;
obj[? "prop_BulletSpeed"] = scr_BehaviorProp_Speed2;
obj[? "prop_Joystick"] = scr_BehaviorProp_Joystick;
obj[? "prop_JoystickButton"] = scr_BehaviorProp_Button;
obj[? "prop_Key"] = scr_BehaviorProp_Key;
obj[? "prop_MoveSpeed"] = scr_BehaviorProp_MoveSpeed;
obj[? "prop_Reload"] = scr_BehaviorProp_Timeout;

var events = obj[? "events"];

ds_list_add(events[? "keys"], "step");
events[? "step"] = scr_SimpleFiresBulletBehavior_step;

obj[? "events"] = events;

if (!is_undefined(argument0.behaviors)) {
    ds_list_add(argument0.behaviors, obj);
}

return obj;
