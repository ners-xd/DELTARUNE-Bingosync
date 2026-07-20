/// PATCH

/// AFTER
function scr_interact()
{
/// CODE
    var spr = (variable_instance_exists(id, "marker") && marker > 0 && variable_instance_exists(marker, "sprite_index")) ? marker.sprite_index : sprite_index;

#if CHAPTER_2
    if (spr == spr_treasurebox || spr == spr_queenart_treasure_middlepoint)
#elsif CHAPTER_3
    if (spr == spr_treasurebox || spr == spr_board_chest)
#elsif CHAPTER_5
    if (spr == spr_treasurebox || spr == spr_treasurebox_reflection || spr == spr_treasurebox_tail || spr == spr_treasurebox_pink || spr == spr_treasurebox_pink_reflection)
#else
    if (spr == spr_treasurebox)
#endif
    #if CHAPTER_3
        // The ice key chest can spawn at random coordinates,
        // and it shouldn't be counted multiple times
        if (object_index == obj_board_swordroute_icekey)
            scr_add_goal_array(114, room_get_name(room));
        else
    #endif
            scr_add_goal_array(114, room_get_name(room) + "-" + string(x) + "-" + string(y));

#if CHAPTER_5
    else if (spr == spr_npc_zenlooker)
        scr_add_goal_progress(169, 1);
#endif
/// END