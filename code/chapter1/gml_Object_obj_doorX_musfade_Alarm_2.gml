/// PATCH

/// REPLACE
    room_goto(room_forest_savepoint2);
/// CODE
{
    global.egg_attempts = 0;
    room_goto(room_forest_savepoint2);
}
/// END

/// BEFORE
    ch = ceil(random(50));
/// CODE
    if (global.flag[910] == 0)
        global.egg_attempts++;
/// END