var target = argument0;
var obj = MultipleSpritesBehavior(target);
var defaultSprite = obj[? "default"];
var key = argument1;

if(ds_map_exists(obj, key)){
    return obj[? key];
} else {
    return defaultSprite;
}
