var str = argument0;
var chars = argument1;

if (is_string(str)) {
    if(string_length(chars) == 0) {
        chars = ' ';
    }
    var aChars;
    for(var idx =1; idx<=string_length(chars); idx++) {
        aChars[idx] = chr(string_char_at(chars, idx));
    }
    
    var removeChar = false;
    do {
        removeChar = false;
        var firstChar = chr(string_char_at(str, 0));
        for(var z=1; z<=string_length(chars); z++) {
            if(aChars[z] = firstChar) {
                removeChar = true;
                break;
            }
        }
        if(removeChar) {
            str = string_copy(str, 2, string_length(str)); // remove 1 char
        }
    } until (removeChar)
}

return str;
