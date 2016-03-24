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
var target = obj.target;

var up = false;
var down = false;
var left = false;
var right = false;

var joystickNum = obj[? "joystickNumber"];
var joyStickX = 0;
var joyStickY = 0;
if(joystickNum > -1 && gamepad_is_supported() && gamepad_is_connected(joystickNum)) {
    if(ds_map_exists(obj, "joystickXAxes")) {
        joyStickX = round(gamepad_axis_value(joystickNum, obj[? "joystickXAxes"])); 
    } else {
        joyStickX = round(gamepad_axis_value(joystickNum, gp_axislh)); 
    }
    if(ds_map_exists(obj, "joystickYAxes")) {
        joyStickY = round(gamepad_axis_value(joystickNum, obj[? "joystickYAxes"])); 
    } else {
        joyStickY = round(gamepad_axis_value(joystickNum, gp_axislv)); 
    }
}

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

if (otherDown || joyStickY > 0 || keyboard_check(keyDown)) { // TODO: add downRight/downLeft
    down= true;
} else if(otherUp || joyStickY < 0 || keyboard_check(keyUp)) { // TODO: add downRight/downLeft
    up = true;
}
if (otherRight || joyStickX > 0 || keyboard_check(keyRight)) { // TODO: add upRight/downRight
    right = true;
} else if (otherLeft || joyStickX < 0 || keyboard_check(keyLeft)) { // TODO: add upLeft/downLeft
    left = true;
}

var rtn = ds_map_create();
rtn[? "up"] = up;
rtn[? "down"] = down;
rtn[? "left"] = left;
rtn[? "right"] = right;

return rtn;
