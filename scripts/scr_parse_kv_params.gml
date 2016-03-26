var kvString = scr_rtrim_char(scr_ltrim_char(argument0, " {"), " }");

var result = ds_map_create();

// {} are not gone from the string

// so split by commas

// then loop through the array, splitting on ":", triming the key/value

    // determine type (string, bool, real) and convert value accordingly
    
    // finally store value in result

// end loop

return result;

