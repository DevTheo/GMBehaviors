var obj = argument0;

var target = scr_BehaviorProp_Target(obj);
var moveSpeed = scr_BehaviorProp_MoveSpeed(obj);
var joystickNumber = scr_BehaviorProp_MoveSpeed(obj);
var button = scr_BehaviorProp_Button(obj);
var keyUp = scr_BehaviorProp_UpKey(obj);
var keyDown = scr_BehaviorProp_DownKey(obj);
var keyLeft = scr_BehaviorProp_LeftKey(obj);
var keyRight = scr_BehaviorProp_RightKey(obj);
var keyJump = scr_BehaviorProp_JumpKey(obj);
var ladderBlocks = scr_BehaviorProp_Target2(obj);
var timeout = scr_BehaviorProp_Timeout(obj);
var hasSprites = false;
var spriteNormal = target.sprite_index;
var spriteLeft = -1;
var spriteRight = -1;
var spriteUp = -1;
var spriteDown = -1;
var spriteJump = -1;
var spriteJumpLeft = -1;
var spriteJumpRight = -1;
var grav = obj[? "gravity"];

if(ds_map_exists(obj, "playerSprites")) {
    // we have sprites 
    var playerSprites = obj[? "playerSprites"];
    hasSprites = true;
    
    if(ds_map_exists(playerSprites, "normal")) 
        spriteNormal = playerSprites[? "normal"]
        
    if(ds_map_exists(playerSprites, "left")) 
        spriteLeft = playerSprites[? "left"]
    else 
         playerSprites[? "left"] = spriteLeft = spriteNormal;
    
        
    if(ds_map_exists(playerSprites, "right")) 
        spriteRight = playerSprites[? "right"]
    else
        playerSprites[? "right"] = spriteRight = spriteNormal;
        
    if(ds_map_exists(playerSprites, "up")) 
        spriteUp = playerSprites[? "up"]
    else
        playerSprites[? "up"] = spriteUp = spriteNormal;        
                
    if(ds_map_exists(playerSprites, "down")) 
        spriteDown = playerSprites[? "down"]
    else
        playerSprites[? "down"] = spriteDown = spriteNormal;
        
    if(ds_map_exists(playerSprites, "jump")) 
        spriteJump = playerSprites[? "jump"]
    else
        playerSprites[? "jump"] = spriteJump = spriteNormal;                
        
    if(ds_map_exists(playerSprites, "jumpLeft")) 
        spriteJumpLeft = playerSprites[? "jumpLeft"]
    else
        playerSprites[? "jumpLeft"] = spriteJumpLeft = spriteNormal;        
        
    if(ds_map_exists(playerSprites, "jumpRight")) 
        spriteJumpRight = playerSprites[? "jumpRight"]
    else
        playerSprites[? "jumpRight"] = spriteJumpRight = spriteNormal;        
}
