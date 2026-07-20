/// PATCH
// Fix entering room_field_start from the Castle Town great door cutscene counting as a wrong warp

/// REPLACE
    global.plot = 33;
    global.interact = 0;
/// CODE
    global.plot = 33;
    global.interact = 3;
/// END