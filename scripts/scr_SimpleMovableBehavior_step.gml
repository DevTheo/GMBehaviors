var obj = argument0;
var target = obj[? "target"];

var keyUp = obj[? "keyUp"];
var keyDown = obj[? "keyDown"];
var keyLeft = obj[? "keyLeft"];
var keyRight = obj[? "keyRight"];

var constrain = obj[? "constrain"];
var constrainX = obj[? "constrainX"];
var constrainY = obj[? "constrainY"];
var constrainX2 = obj[? "constrainW"] + constrainX;
var constrainY2 = obj[? "constrainH"] + constrainY;

var mv_speed = obj[? "speed"];

var spriteH = target.sprite_height - target.sprite_yoffset;
var spriteW = target.sprite_width - target.sprite_xoffset;

if (keyboard_check(keyDown) && (!constrain || (target.y + spriteH) + mv_speed <  constrainY2)) {
    target.y += mv_speed;
} else if (keyboard_check(keyUp) && (!constrain || (target.y - target.sprite_yoffset) - mv_speed > constrainY)) {
    target.y -= mv_speed;
}


if (keyboard_check(keyRight) && (!constrain || (target.x + spriteW) + mv_speed < constrainX2)) {
    target.x += mv_speed;
} else if (keyboard_check(keyLeft) && (!constrain || (target.x - target.sprite_xoffset) - mv_speed > constrainX)) {
    target.x -= mv_speed;
}
