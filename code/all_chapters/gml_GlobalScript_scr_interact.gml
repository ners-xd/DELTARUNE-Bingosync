/// PATCH

/// AFTER
    event_user(0);
/// CODE
#if CHAPTER_2
    if (sprite_index == spr_treasurebox || sprite_index == spr_queenart_treasure_middlepoint)
#elsif CHAPTER_3
    if (sprite_index == spr_treasurebox || sprite_index == spr_board_chest)
#else
    if (sprite_index == spr_treasurebox)
#endif
    #if CHAPTER_3
        // The ice key chest can spawn at random coordinates,
        // and it shouldn't be counted multiple times
        if (object_index == obj_board_swordroute_icekey)
            scr_add_goal_array(114, "chests_opened", room_get_name(room));
        else
    #endif
            scr_add_goal_array(114, "chests_opened", room_get_name(room) + "-" + string(x) + "-" + string(y));
/// END