var kvString = argument0;
kvString = scr_rtrim_char(kvString, " },") + ",";
var result = ds_map_create();
var addKeys = true;
var keysList = -1;
var currentKVP = "";
var currentKey = "";

// ending spaces, and } are not gone from the string
var commaCount = string_count(",", kvString );
var commaPlace = string_pos(",", kvString);
var kvpStart = 1;

if (addKeys) {
    keysList = ds_list_create();
}

// so split by commas
while (commaCount > 0) {
    var kvp = string_copy(kvString, kvpStart, commaPlace - kvpStart);
    
// then loop through the array, splitting on ":", triming the key/value
    var colonPlace = string_pos(":", kvp);
    var key = scr_rtrim_char(
              scr_ltrim_char(
                string_copy(kvp, 1, colonPlace - 1)
              , " ")
              , " ");
    var value = scr_ltrim_char(
                scr_rtrim_char(
                        string_copy(kvp, colonPlace + 1, (string_length(kvp) - colonPlace))
                        , " ")
                        , " ");
    
    // determine type (string, bool, real) and convert value accordingly
    if(string_char_at(value, 1) == '"' || string_char_at(value, 1) == "'") {
        value = string_copy(value, 1, string_length(value)-2);
    } else if (string_upper(value) == "FALSE") {
        value = false
    } else if (string_upper(value) == "TRUE") {
        value = true;
    } else {
        var negate = 1;
        if (string_pos("-", value) > 0) 
            negate = -1;
        value = negate * real(string_digits(value));
    }
    
    // finally store value in result
    result[? key] = value;
    if (addKeys) {
        ds_list_add(keysList, ds_list_size(keysList), key);
    }
    commaCount--;
    var kvpStart = commaPlace + 1;    
    kvString = string_copy(kvString, kvpStart, string_length(kvString) - kvpStart);
    
    var kvpStart = 1;
    var commaPlace = string_pos(",", kvString);
    if(commaPlace == 0)
        commaPlace = string_length(kvString) + 1;
}

if (addKeys) {
    result[? "keys"] = keysList;
}

return result;

