/// PATCH

/// AFTER
    event_user(0);
/// CODE
#if CHAPTER_2
    if ((sprite_index == spr_treasurebox || sprite_index == spr_queenart_treasure_middlepoint) && (!variable_instance_exists(id, "noroom") || !noroom))
#elsif CHAPTER_3
    if ((sprite_index == spr_treasurebox || sprite_index == spr_board_chest) && (!variable_instance_exists(id, "noroom") || !noroom))
#else
    if (sprite_index == spr_treasurebox && (!variable_instance_exists(id, "noroom") || !noroom))
#endif
        scr_add_goal_custom_array(114, "chests_opened", room_get_name(room) + "-" + string(x) + "-" + string(y));
/// END