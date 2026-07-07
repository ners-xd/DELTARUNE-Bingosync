/// PATCH

/// REPLACE
    game_restart();
/// CODE
    if (!instance_exists(obj_bingo_controller))
    {
        game_restart();
        exit;
    }

    if (!global.is_console)
        io_clear();

    global.tempflag = array_create(100, 0);
    scr_gamestart();
    room_goto(scr_get_starting_room());
/// END