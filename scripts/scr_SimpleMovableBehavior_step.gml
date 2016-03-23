var obj = argument0;
var target = obj[? "target"];

var constrain = obj[? "constrain"];
var constrainX = obj[? "constrainX"];
var constrainY = obj[? "constrainY"];
var constrainX2 = obj[? "constrainW"] + constrainX;
var constrainY2 = obj[? "constrainH"] + constrainY;
var mv_speed = obj[? "speed"];

var spriteH = target.sprite_height - target.sprite_yoffset;
var spriteW = target.sprite_width - target.sprite_xoffset;
var newX = target.x;
var newY = target.y;

var movementObj = MovementDetectionBehavior(target);
var movement = script_execute(movementObj[? "GetMovement"], movementObj);

if (movement[? "down"] && 
    (!constrain || (newY + spriteH) + mv_speed <  constrainY2)) {
    newY += mv_speed;
} else if (movement[? "up"] && 
           (!constrain || (newY - target.sprite_yoffset) - mv_speed > constrainY)) {
    newY -= mv_speed;
}

if (movement[? "right"] && 
    (!constrain || (newX + spriteW) + mv_speed < constrainX2)) {
    newX += mv_speed;
} else if (movement[? "left"] && (!constrain || (newX - target.sprite_xoffset) - mv_speed > constrainX)) {
    newX -= mv_speed;
}

if (place_free(newX, newY)) {
    target.x = newX;
    target.y = newY;
}
