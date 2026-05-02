/// PATCH

/// REPLACE
    game_restart();
/// CODE
    if (!instance_exists(obj_bingo_controller))
    {
        game_restart();
        exit;
    }

#if CHAPTER_1
    var possible_rooms = [PLACE_CONTACT, PLACE_MENU, room_legend];
#elsif CHAPTER_2
    var possible_rooms = [room_intro_ch2, room_intro_ch2, room_legend];
#elsif CHAPTER_3
    var possible_rooms = [room_intro, room_intro, room_legend];
#elsif CHAPTER_4
    var possible_rooms = [room_intro_ch4, room_intro_ch4, room_legend];
#endif

    var roomchoice = possible_rooms[0];

    if (scr_completed_chapter_any_slot(global.chapter))
        roomchoice = possible_rooms[2];
    else if (scr_chapter_save_file_exists(global.chapter))
        roomchoice = possible_rooms[1];

    if (roomchoice == room_legend)
        global.tempflag[10] = 1;

    if (global.is_console)
        global.screen_border_alpha = (roomchoice == room_legend);
    else
        io_clear();

    scr_gamestart();
    room_goto(roomchoice);
/// END