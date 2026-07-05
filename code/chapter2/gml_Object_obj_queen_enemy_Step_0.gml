/// PATCH

/// AFTER
    snd_free(global.batmusic[0]);
/// CODE
    scr_add_goal_progress(15, 1);
    scr_add_goal_array(135, "bosses_fought", "queen");

    if (global.monsterhp[myself] > 0)
        scr_add_goal_progress(74, 1);
/// END