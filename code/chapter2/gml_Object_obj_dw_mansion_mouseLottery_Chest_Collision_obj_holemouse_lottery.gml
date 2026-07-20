/// PATCH

/// PREPEND
scr_add_goal_array(114, room_get_name(room) + "-" + string(x) + "-" + string(y));
/// END

/// AFTER
    con = 1;
/// CODE
    if (global.flag[374] == 1 && global.flag[375] == 1)
        scr_add_goal_progress(78, 1);
/// END