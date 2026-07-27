/// IMPORT

var room_name = room_get_name(room);

if ((prev_interact == 0 || prev_interact == 5 || prev_interact == 6 || audio_is_playing(snd_tensionhorn)) && mainchara_was_in_prev_room
#if CHAPTER_1 || CHAPTER_2 || CHAPTER_3 || CHAPTER_4
    && (instance_exists(obj_mainchara) || string_starts_with(room_name, "room_shop"))
    #if CHAPTER_3
        && !instance_exists(obj_mainchara_board)
    #endif
#else
    && (instance_exists(obj_mainchara) || instance_exists(obj_plat_player) || string_starts_with(room_name, "room_shop"))
#endif
    )
    scr_add_goal_array(70, room_name);