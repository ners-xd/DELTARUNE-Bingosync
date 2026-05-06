/// PATCH

/// AFTER
    scr_tempsave();
    room_goto(room_dw_mansion_top_post);
/// CODE
    scr_add_goal_progress(14, 1);
    scr_add_goal_array(111, "final_bosses_fought", "giga_queen");
    scr_add_goal_array(135, "bosses_fought", "giga_queen");
/// END