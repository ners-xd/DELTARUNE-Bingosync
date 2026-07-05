/// IMPORT

#if CHAPTER_1 || CHAPTER_2 || CHAPTER_3 || CHAPTER_4
if (prev_interact != 3 && mainchara_was_in_prev_room && instance_exists(obj_mainchara))
#else
if (prev_interact != 3 && mainchara_was_in_prev_room && (instance_exists(obj_mainchara) || instance_exists(obj_plat_player)))
#endif
    scr_add_goal_array(70, "wrong_warps", room_get_name(room));