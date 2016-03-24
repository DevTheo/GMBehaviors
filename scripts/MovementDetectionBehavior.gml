/*
argument0 is either a target.id or a json string in this format:

{
    target: {object.id}
    joystickNumber: {1 or 2 or -1}, // -1 is off
    joystickXAxes: {1-4), // optional (defaults to 1 if first is there)
    joystickYAxes: {1-4), // optional (defaults to 2 if first is there)
    altKey: true, // optional, if true sets changes the defaults
    keyUp: ord("k"), // optional, default=up key, alt="w"
    keyDown: ord("k"), // optional, default=down key, alt="s"
    keyLeft: ord("k"), // optional, default=left key, alt="a"
    keyRight: ord("k"), // optional, default=right key, alt="d"
    // The following are all optional, 
    //      thay let you define more fine-grained key controls
    keyUpLeft: ord("k"), 
    keyUpRight: ord("k"),     
    keyUpDownLeft: ord("k"),     
    keyUpDownRight: ord("k"),     
}
*/

if (!is_string(argument0)) {
    if(!is_undefined(target._MovementDetection_)) {
        return argument0._MovementDetection_;
    } 
    argument0 = "{}"
}


var obj = scr_create_behavior_with_json_string_params(argument0, "MovementDetectionBehavior");

var target = obj[? "target"];

var alt = false;
if(ds_map_exists(obj, "alt"))
    alt = obj[? "alt"];
if(!ds_map_exists(obj, "keyUp"))
    if(!alt)
        obj[? "keyUp"] = vk_up;
    else
        obj[? "keyUp"] = ord("w");

if(!ds_map_exists(obj, "keyDown"))
    if(!alt)
        obj[? "keyDown"] = vk_down;
    else
        obj[? "keyDown"] = ord("s");

if(!ds_map_exists(obj, "keyLeft"))
    if(!alt)
        obj[? "keyLeft"] = vk_left;
    else
        obj[? "keyLeft"] = ord("s");

if(!ds_map_exists(obj, "keyRight"))
    if(!alt)
        obj[? "keyRight"] = vk_left;
    else
        obj[? "keyRight"] = ord("s");

if(ds_map_exists(obj, "joystickNumber")) {
    if(!ds_map_exists(obj, "joystickXAxes"))
        obj[? "joystickXAxes"] = -1;
    if(!ds_map_exists(obj, "joystickYAxes"))
        obj[? "joystickYAxes"] = -1;
}

obj[? "GetMovement"] = scr_MovementDetectionBehavior_GetValues

target._MovementDetection_ = obj;

return obj;
