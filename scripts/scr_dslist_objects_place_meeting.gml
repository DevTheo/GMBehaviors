var placeX = argument0;
var placeY = argument1;
var listObj = argument2;

var size = ds_list_size(listObj);

var result = false;
for (var i=0; i<=size; i++) {
    var obj = ds_list_find_value(listObj, i);
    if (!is_undefined(obj)) {
        result = result || place_meeting(placeX, placeY, obj);
        if (result)
            break;
    }
}

return result;
