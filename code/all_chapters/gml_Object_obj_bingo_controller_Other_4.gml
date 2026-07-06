/// IMPORT

if (prev_interact == 0 && mainchara_was_in_prev_room && instance_exists(obj_mainchara))
    scr_add_goal_array(70, "wrong_warps", room_get_name(room));