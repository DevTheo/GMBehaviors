var obj = argument0;

var target = scr_BehaviorProp_Target(obj);
var bulletObj = scr_BehaviorProp_Target2(obj); // bullet object
var firespeed = scr_BehaviorProp_Speed(obj); // firespeed
var relativeX = scr_BehaviorProp_RelativeX(obj);
var relativeY = scr_BehaviorProp_RelativeY(obj);
var bulletDir = scr_BehaviorProp_BulletDir(obj);
var bulletSpeed = scr_BehaviorProp_Speed2(obj);
var key = scr_BehaviorProp_Key(obj);
var fireAvailableIn = scr_BehaviorProp_Timeout(obj);
var joystick = scr_BehaviorProp_Joystick(obj);
var joystickButton = scr_BehaviorProp_Button(obj);

var canFire = fireAvailableIn == 0;

if (canFire == false) {
    script_execute(scr_BehaviorProp_Timeout, obj, fireAvailableIn - 1);
    
} else {    
    // we can fire
    var joyButtonDown = false;
    
    if (joystick > 0) {
        if (joystickButton > 0) {
            joyButtonDown = joystick_check_button(joystick, joystickutton);
        } else {
            for(var i=1; i<=32; i++) {
                joyButtonDown = joystick_check_button(joystick, i);
                if (joyButtonDown) {
                    break;
                }
            }
        }
    }
    
    if (joyButtonDown || keyboard_check(key)) {
        script_execute(scr_BehaviorProp_Timeout, obj, firespeed);
        var newX = target.x + relativeX;
        var newY = target.y + relativeY;
        var bullet = instance_create(newX,newY,bulletObj);
        bullet.speed = bulletSpeed;
        bullet.direction = bulletDir;
    }
}
