var str = argument0;
var chars = argument1;

if (is_string(str)) {
    if(string_length(chars) == 0) {
        chars = ' ';
    }
    var aChars;
    for(var idx =1; idx<=string_length(chars); idx++) {
        aChars[idx] = string_char_at(chars, idx);
    }
    
    var removeChar = false;
    do {
        removeChar = false;
        var lastChar = string_char_at(str, string_length(str));
        for(var z=1; z<=string_length(chars); z++) {
            if(aChars[z] = lastChar) {
                removeChar = true;
                break;
            }
        }
        if(removeChar) {
            str = string_copy(str, 1, string_length(str)-1); // remove 1 char from end
        }
    } until (!removeChar || str == "")
}

return str;
