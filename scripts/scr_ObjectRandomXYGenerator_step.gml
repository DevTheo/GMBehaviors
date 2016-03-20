var obj = argument0;
var target = scr_BehaviorProp_Target(obj);
var createThis = scr_BehaviorProp_Target2(obj);
var createSpeed = scr_BehaviorProp_Speed(obj);
var minX = scr_BehaviorProp_ConstrainX(obj);
var minY = scr_BehaviorProp_ConstrainY(obj);
var w = scr_BehaviorProp_ConstrainW(obj);
var h = scr_BehaviorProp_ConstrainH(obj);
var timeout = scr_BehaviorProp_Timeout(obj);
var sound = scr_BehaviorProp_Sound(obj);

if (timeout > 0) {
    script_execute(scr_BehaviorProp_Timeout, obj, timeout-1);
} else {
    var xInc = 0;
    var yInc = 0;
    if (w > 1)
        xInc = random(w);
    if (h > 1)
        yInc = random(h);
    
    var newX = minX + xInc;
    var newY = minY + yInc;
    instance_create(newX, newY, createThis);
    script_execute(scr_BehaviorProp_Timeout, obj, createSpeed);
    if(sound > 0)
        sound_play(sound);
}
