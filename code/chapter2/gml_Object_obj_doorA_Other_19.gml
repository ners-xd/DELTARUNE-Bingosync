/// PATCH

/// AFTER
    touched = 1;
/// CODE
    if (room == room_dw_mansion_potBalance && instance_exists(obj_racingline) && !global.failed_pot_balance)
        scr_add_goal_progress(76, 1);
/// END