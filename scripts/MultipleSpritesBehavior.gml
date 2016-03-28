/*argument0 = self.id or json
{
    target: {object}
    default: {sprite}, 
// Optional:  Consult what your behaviors expect   
    up: {sprite},
    down: {sprite},    
    left: {sprite},
    right: {sprite},    
    upLeft: {sprite},    
    downLeft: {sprite}, 
    upRight: {sprite},               
    downRight: {sprite},
    jump: {sprite},
    jumpLeft: {sprite},
    jumpRight:: {sprite},
}
*/
var arg0 = argument0;
if(!is_string(arg0))
{
    var bh = scr_create_behavior_with_json_string_params(arg0, "MultipleSpritesBehavior");
    if(!is_undefined(bh)) {
        return bh;
    } 

    arg0 = "{ 'target': " + string(argument0.id) + "'default': " + string(argument0.sprite_index) + "}";
}

var obj = scr_create_behavior_with_json_string_params(arg0, "MultipleSpritesBehavior");

// one action
obj[? "_GetSprite"] = scr_MultipleSpritesBehavior_GetSprite;

// no events here

return obj;
