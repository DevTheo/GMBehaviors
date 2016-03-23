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

if(!is_string(argument0))
{
    if(!is_undefined(target._MultiSpriteBehavior_)) {
        return argument0._MultiSpriteBehavior_;
    }
    argument0 = "{ 'target': " + string(argument0.id) + "'default': " + string(argument0.sprite_index) + "}";
}

var obj = scr_create_behavior_with_json_string_params(argument1);

// one action
obj[? "_GetSprite"] = scr_MultipleSpritesBehavior_GetSprite;

var target = obj;
target._MultiSpriteBehavior_ = obj

// no events here

return obj;
