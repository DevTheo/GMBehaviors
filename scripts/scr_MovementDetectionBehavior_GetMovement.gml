/*
returns a DSMAP in this shape
{
    up: true,
    down: true,
    left: true,
    right: true
}
*/
var obj = argument0;
var target = obj[? "target"];

var up = false;
var down = false;
var left = false;
var right = false;

var joystickNum = obj[? "joystickNumber"];
var joystickX = 0;
var joystickY = 0;
if(joystickNum > -1 && gamepad_is_supported() && gamepad_is_connected(joystickNum)) {
    if(ds_map_exists(obj, "joystickXAxes")) {
        joystickX = round(gamepad_axis_value(joystickNum, obj[? "joystickXAxes"])); 
    } else {
        joystickX = round(gamepad_axis_value(joystickNum, gp_axislh)); 
    }
    if(ds_map_exists(obj, "joystickYAxes")) {
        joystickY = round(gamepad_axis_value(joystickNum, obj[? "joystickYAxes"])); 
    } else {
        joystickY = round(gamepad_axis_value(joystickNum, gp_axislv)); 
    }
}

var keyUp = obj[? "keyUp"];
var keyDown = obj[? "keyDown"];
var keyLeft = obj[? "keyLeft"];
var keyRight = obj[? "keyRight"];


var otherUp = false;
var otherDown = false;
var otherLeft = false;
var otherRight = false;
if (ds_map_exists(obj, "keyUpLeft") && keyboard_check(ord(obj[? "keyUpLeft"])))
{
    otherLeft = true;
    otherUp = true;    
}

if (ds_map_exists(obj, "keyUpRight") && keyboard_check(ord(obj[? "keyUpRight"])))
{
    otherRight = true;
    otherUp = true;    
}
if (ds_map_exists(obj, "keyUpDownLeft") && keyboard_check(ord(obj[? "keyUpDownLeft"])))
{
    otherLeft = true;
    otherDown = true;    
}

if (ds_map_exists(obj, "keyUpDownRight") && keyboard_check(ord(obj[? "keyUpDownRight"])))
{
    otherRight = true;
    otherDown = true;    
}

if (otherDown || joystickY > 0 || keyboard_check(keyDown)) { 
    down= true;
} else if(otherUp || joystickY < 0 || keyboard_check(keyUp)) { 
    up = true;
}
if (otherRight || joystickX > 0 || keyboard_check(keyRight)) { 
    right = true;
} else if (otherLeft || joystickX < 0 || keyboard_check(keyLeft)) { 
    left = true;
}

var rtn = ds_map_create();
rtn[? "up"] = up;
rtn[? "down"] = down;
rtn[? "left"] = left;
rtn[? "right"] = right;

return rtn;
